static int g_iWeapon[MAXPLAYERS + 1] =  { -1, ... };
static int g_iDefIndex[MAXPLAYERS + 1] =  { -1, ... };
static int g_iSite[MAXPLAYERS + 1] =  { 0, ... };

void ChangeWearMenu(int client)
{
	g_iWeapon[client] = CSGOItems_GetActiveWeapon(client);
	g_iDefIndex[client] = CSGOItems_GetActiveWeaponDefIndex(client);
	
	float fWear = GetEntPropFloat(g_iWeapon[client], Prop_Send, "m_flFallbackWear");
	
	char sDisplay[WP_DISPLAY];
	CSGOItems_GetWeaponDisplayNameByDefIndex(g_iDefIndex[client], sDisplay, sizeof(sDisplay));
	
	Menu menu = new Menu(Menu_ChangeWear);
	
	menu.SetTitle("Wear anpassen von\n%s\nAktueller Wear: %.4f", sDisplay, fWear);
	menu.AddItem("default", "Standard (0.0001)");
	menu.AddItem("+1.0", "+1");
	menu.AddItem("+0.1", "+0,1");
	menu.AddItem("+0.01", "+0,01");
	menu.AddItem("+0.001", "+0,001");
	menu.AddItem("-0.001", "-0,001");
	menu.AddItem("-0.01", "-0,01");
	menu.AddItem("-0.1", "-0,1");
	menu.AddItem("-1.0", "-1");
	menu.ExitButton = true;
	menu.ExitBackButton = true;
	
	menu.DisplayAt(client, g_iSite[client], MENU_TIME_FOREVER);
}


public int Menu_ChangeWear(Menu menu, MenuAction action, int client, int param)
{
	if (action == MenuAction_Select)
	{
		char sValue[12];
		menu.GetItem(param, sValue, sizeof(sValue));
		
		if (StrEqual(sValue, "default", false))
		{
			SetClientWear(client, g_iWeapon[client], g_iDefIndex[client], DEFAULT_WEAR);
		}
		else if (ReplaceString(sValue, sizeof(sValue), "+", "") > 0)
		{
			float fWear = GetEntPropFloat(g_iWeapon[client], Prop_Send, "m_flFallbackWear");
			float fBuf = StringToFloat(sValue);
			
			fBuf += fWear;
			
			if(fBuf > 0.001 && fBuf < 1.0)
			{
				SetClientWear(client, g_iWeapon[client], g_iDefIndex[client], fBuf);
			}
			else
			{
				SetClientWear(client, g_iWeapon[client], g_iDefIndex[client], 1.0);
			}
		}
		else if (ReplaceString(sValue, sizeof(sValue), "-", "") > 0)
		{
			float fWear = GetEntPropFloat(g_iWeapon[client], Prop_Send, "m_flFallbackWear");
			float fBuf = StringToFloat(sValue);
			
			fWear -= fBuf;
			
			if(fWear > 0.001 && fWear < 1.0)
			{
				SetClientWear(client, g_iWeapon[client], g_iDefIndex[client], fWear);
			}
			else
			{
				SetClientWear(client, g_iWeapon[client], g_iDefIndex[client], DEFAULT_WEAR);
			}
		}
		
		g_iDefIndex[client] = -1;
		g_iWeapon[client] = -1;
		
		g_iSite[client] = menu.Selection;
	}
	else if (action == MenuAction_Cancel && param == MenuCancel_ExitBack)
	{
		Command_WS(client, 0);
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

void SetClientWear(int client, int iWeapon, int weaponIndex, float fWear)
{
	char sWeapon[WP_DISPLAY], sClass[WP_CLASSNAME];
	CSGOItems_GetWeaponDisplayNameByDefIndex(weaponIndex, sWeapon, sizeof(sWeapon));
	CSGOItems_GetWeaponClassNameByDefIndex(weaponIndex, sClass, sizeof(sClass));
	
	if (!IsValidWeapon(client, weaponIndex, true))
	{
		Command_WS(client, 0);
		return;
	}
	
	int iDef = GetEntProp(iWeapon, Prop_Send, "m_nFallbackPaintKit");
	
	if (g_bDebug)
	{
		PrintToChat(client, "You've choosen: [%d/%d] %s and wear: %.4f", weaponIndex, iDef, sWeapon, fWear);
	}
	
	int iSeed = GetEntProp(g_iWeapon[client], Prop_Send, "m_nFallbackSeed");
	
	UpdateClientArray(client, sClass, iDef, fWear, iSeed, DEFAULT_QUALITY);
	UpdateClientMySQL(client, sClass, iDef, fWear, iSeed, DEFAULT_QUALITY);
	
	CSGOItems_RemoveWeapon(client, iWeapon);
	
	DataPack pack = new DataPack();
	RequestFrame(Frame_wGivePlayerItem, pack);
	pack.WriteCell(GetClientUserId(client));
	pack.WriteString(sClass);
}

public void Frame_wGivePlayerItem(any pack)
{
	ResetPack(pack);
	int client = GetClientOfUserId(ReadPackCell(pack));
	char sClass[WP_CLASSNAME];
	ReadPackString(pack, sClass, sizeof(sClass));
	delete view_as<DataPack>(pack);
	
	if(IsClientValid(client))
	{
		int iWeapon = GivePlayerItem(client, sClass);
		EquipPlayerWeapon(client, iWeapon);
		
		DataPack pack2 = new DataPack();
		RequestFrame(Frame_wSetActionWeapon, pack2);
		pack2.WriteCell(GetClientUserId(client));
		pack2.WriteCell(iWeapon);
	}
}

public void Frame_wSetActionWeapon(any pack)
{
	ResetPack(pack);
	int client = GetClientOfUserId(ReadPackCell(pack));
	int weapon = ReadPackCell(pack);
	delete view_as<DataPack>(pack);
	
	if (IsClientValid(client) && CSGOItems_IsValidWeapon(weapon))
	{
		CSGOItems_SetActiveWeapon(client, weapon);
		ChangeWearMenu(client);
	}
}

