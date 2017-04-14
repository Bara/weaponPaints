static int g_iDefIndex[MAXPLAYERS + 1] =  { -1, ... };
static int g_iWeapon[MAXPLAYERS + 1] =  { -1, ... };
static int g_iSite[MAXPLAYERS + 1] =  { 0, ... };

void ChooseCurrentWeapon(int client)
{
	Menu menu = new Menu(Menu_ChooseCurrentWeapon);
	
	g_iDefIndex[client] = CSGOItems_GetActiveWeaponDefIndex(client);
	
	if (!IsValidWeapon(client, g_iDefIndex[client], true))
	{
		g_iDefIndex[client] = -1;
		g_iWeapon[client] = -1;
		
		Command_WS(client, 0);
		
		return;
	}
	
	g_iWeapon[client] = CSGOItems_GetActiveWeapon(client);
	
	char sDisplay[WP_DISPLAY];
	CSGOItems_GetWeaponDisplayNameByDefIndex(g_iDefIndex[client], sDisplay, sizeof(sDisplay));
	
	menu.SetTitle("Wähle ein Skin für\n%s:", sDisplay);
	
	AddWeaponSkinsToMenu(menu, client, g_iWeapon[client]);
	
	menu.ExitButton = true;
	menu.ExitBackButton = true;
	
	menu.DisplayAt(client, g_iSite[client], MENU_TIME_FOREVER);
}

public int Menu_ChooseCurrentWeapon(Menu menu, MenuAction action, int client, int param)
{
	if (action == MenuAction_Select)
	{
		char sDefIndex[12];
		menu.GetItem(param, sDefIndex, sizeof(sDefIndex));
		
		int defIndex = StringToInt(sDefIndex);
		
		SetClientSkin(client, g_iWeapon[client], defIndex, g_iDefIndex[client], 1);
		
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
