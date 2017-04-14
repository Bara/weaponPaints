static int g_iWeapon[MAXPLAYERS + 1] =  { -1, ... };
static int g_iDefIndex[MAXPLAYERS + 1] =  { -1, ... };
static int g_iSite[MAXPLAYERS + 1] =  { 0, ... };

void ChangeSeedMenu(int client)
{
	g_iWeapon[client] = CSGOItems_GetActiveWeapon(client);
	g_iDefIndex[client] = CSGOItems_GetActiveWeaponDefIndex(client);
	
	bool isKnife = CSGOItems_IsDefIndexKnife(g_iDefIndex[client]);
	
	if (isKnife || !IsValidWeapon(client, g_iDefIndex[client], true))
	{
		if (isKnife && g_bShowKnifeSeedMessage)
		{
			PrintToChat(client, "You can't change the seed for a knife!");
		}
		
		g_iDefIndex[client] = -1;
		g_iWeapon[client] = -1;
		
		Command_WS(client, 0);
		
		return;
	}
	
	int iSeed = GetEntProp(g_iWeapon[client], Prop_Send, "m_nFallbackSeed");
	
	char sDisplay[WP_DISPLAY];
	CSGOItems_GetWeaponDisplayNameByDefIndex(g_iDefIndex[client], sDisplay, sizeof(sDisplay));
	
	Menu menu = new Menu(Menu_ChangeSeedMenu);
	
	menu.SetTitle("Seed anpassen von\n%s\nAktueller Seed: %d", sDisplay, iSeed);
	menu.AddItem("default", "Standard (0)");
	menu.AddItem("+100", "+100");
	menu.AddItem("+50", "+50");
	menu.AddItem("+20", "+20");
	menu.AddItem("+10", "+10");
	menu.AddItem("+5", "+5");
	menu.AddItem("+2", "+2");
	menu.AddItem("+1", "+1");
	menu.AddItem("-1", "-1");
	menu.AddItem("-2", "-2");
	menu.AddItem("-5", "-5");
	menu.AddItem("-10", "-10");
	menu.AddItem("-20", "-20");
	menu.AddItem("-50", "-50");
	menu.AddItem("-100", "-100");

	menu.ExitButton = true;
	menu.ExitBackButton = true;
	
	menu.DisplayAt(client, g_iSite[client], MENU_TIME_FOREVER);
}


public int Menu_ChangeSeedMenu(Menu menu, MenuAction action, int client, int param)
{
	if (action == MenuAction_Select)
	{
		char sValue[12];
		menu.GetItem(param, sValue, sizeof(sValue));
		
		if (StrEqual(sValue, "default", false))
		{
			SetClientSeed(client, g_iWeapon[client], g_iDefIndex[client], DEFAULT_SEED);
		}
		else if (ReplaceString(sValue, sizeof(sValue), "+", "") > 0)
		{
			int iSeed = GetEntProp(g_iWeapon[client], Prop_Send, "m_nFallbackSeed");
			int iBuf = StringToInt(sValue);
			
			iSeed += iBuf;
			
			SetClientSeed(client, g_iWeapon[client], g_iDefIndex[client], iSeed);
		}
		else if (ReplaceString(sValue, sizeof(sValue), "-", "") > 0)
		{
			int iSeed = GetEntProp(g_iWeapon[client], Prop_Send, "m_nFallbackSeed");
			int iBuf = StringToInt(sValue);
			
			iSeed -= iBuf;
			
			SetClientSeed(client, g_iWeapon[client], g_iDefIndex[client], iSeed);
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

void SetClientSeed(int client, int iWeapon, int weaponIndex, int iSeed)
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
		PrintToChat(client, "You've choosen: [%d/%d] %s and seed: %d", weaponIndex, iDef, sWeapon, iSeed);
	}
	
	float fWear = GetEntPropFloat(g_iWeapon[client], Prop_Send, "m_flFallbackWear");
	
	UpdateClientArray(client, sClass, iDef, fWear, iSeed, DEFAULT_QUALITY);
	UpdateClientMySQL(client, sClass, iDef, fWear, iSeed, DEFAULT_QUALITY);
	
	CSGOItems_RemoveWeapon(client, iWeapon);
	
	DataPack pack = new DataPack();
	RequestFrame(Frame_sGivePlayerItem, pack);
	pack.WriteCell(GetClientUserId(client));
	pack.WriteString(sClass);
}

public void Frame_sGivePlayerItem(any pack)
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
		RequestFrame(Frame_sSetActionWeapon, pack2);
		pack2.WriteCell(GetClientUserId(client));
		pack2.WriteCell(iWeapon);
	}
}

public void Frame_sSetActionWeapon(any pack)
{
	ResetPack(pack);
	int client = GetClientOfUserId(ReadPackCell(pack));
	int weapon = ReadPackCell(pack);
	delete view_as<DataPack>(pack);
	
	if (IsClientValid(client) && CSGOItems_IsValidWeapon(weapon))
	{
		CSGOItems_SetActiveWeapon(client, weapon);
		ChangeSeedMenu(client);
	}
}

