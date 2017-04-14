static int g_iwDefIndex[MAXPLAYERS + 1] =  { -1, ... };
static int g_iSiteWeapons[MAXPLAYERS + 1] =  { 0, ... };
static int g_iSiteSkins[MAXPLAYERS + 1] =  { 0, ... };

void ChooseWeaponMenu(int client)
{
	Menu menu = new Menu(Menu_ChooseWeaponMenu);
	
	menu.SetTitle("Wähle eine Waffe:");
	
	for (int i = 0; i <= CSGOItems_GetWeaponCount(); i++)
	{
		int defIndex = CSGOItems_GetWeaponDefIndexByWeaponNum(i);
		
		if (IsValidWeapon(client, defIndex, false))
		{
			char sDefIndex[12], sDisplay[WP_DISPLAY];
			
			IntToString(defIndex, sDefIndex, sizeof(sDefIndex));
			CSGOItems_GetWeaponDisplayNameByDefIndex(defIndex, sDisplay, sizeof(sDisplay));
			
			menu.AddItem(sDefIndex, sDisplay);
		}
	}
	
	menu.ExitButton = true;
	menu.ExitBackButton = true;
	menu.DisplayAt(client, g_iSiteWeapons[client], MENU_TIME_FOREVER);
}


public int Menu_ChooseWeaponMenu(Menu menu, MenuAction action, int client, int param)
{
	if (action == MenuAction_Select)
	{
		char sDefIndex[12];
		menu.GetItem(param, sDefIndex, sizeof(sDefIndex));
		
		g_iwDefIndex[client] = StringToInt(sDefIndex);
		
		g_iSiteWeapons[client] = menu.Selection;
		
		ChooseWeaponSkin(client, g_iwDefIndex[client]);
		
		if (g_bDebug)
		{
			char sDisplay[WP_DISPLAY], sClass[WP_CLASSNAME];
			
			CSGOItems_GetWeaponClassNameByDefIndex(g_iwDefIndex[client], sClass, sizeof(sClass));
			CSGOItems_GetWeaponDisplayNameByDefIndex(g_iwDefIndex[client], sDisplay, sizeof(sDisplay));
			
			if (g_bDebug)
			{
				PrintToChat(client, "You've choosen: [%d/%s] %s ", g_iwDefIndex[client], sClass, sDisplay);
			}
		}
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

void ChooseWeaponSkin(int client, int defIndex)
{
	Menu menu = new Menu(Menu_ChooseWeaponSkin);
	
	if (!IsValidWeapon(client, defIndex, true))
	{
		Command_WS(client, 0);
		
		return;
	}
	
	char sDisplay[WP_DISPLAY];
	CSGOItems_GetWeaponDisplayNameByDefIndex(g_iwDefIndex[client], sDisplay, sizeof(sDisplay));
	
	menu.SetTitle("Wähle ein Skin für\n%s:", sDisplay);
	
	AddWeaponSkinsToMenu(menu, client);
	
	menu.ExitButton = true;
	menu.ExitBackButton = true;
	menu.DisplayAt(client, g_iSiteSkins[client], MENU_TIME_FOREVER);
}

public int Menu_ChooseWeaponSkin(Menu menu, MenuAction action, int client, int param)
{
	if (action == MenuAction_Select)
	{
		char sDefIndex[12];
		menu.GetItem(param, sDefIndex, sizeof(sDefIndex));
		
		int defIndex = StringToInt(sDefIndex);
		
		char sDisplay[WP_DISPLAY], swDisplay[WP_DISPLAY], sClass[WP_CLASSNAME];
		CSGOItems_GetSkinDisplayNameByDefIndex(defIndex, sDisplay, sizeof(sDisplay));
		CSGOItems_GetWeaponDisplayNameByDefIndex(g_iwDefIndex[client], swDisplay, sizeof(swDisplay));
		CSGOItems_GetWeaponClassNameByDefIndex(g_iwDefIndex[client], sClass, sizeof(sClass));
		
		if (g_bDebug)
		{
			PrintToChat(client, "You've choosen: [%d/%s] %s and skin: [%d] %s", g_iwDefIndex[client], sClass, swDisplay, defIndex, sDisplay);
		}
		
		SetClientSkin(client, -1, defIndex, g_iwDefIndex[client], 2);
		
		g_iwDefIndex[client] = -1;
		g_iSiteSkins[client] = menu.Selection;
	}
	else if (action == MenuAction_Cancel && param == MenuCancel_ExitBack)
	{
		ChooseWeaponMenu(client);
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}
