void SetClientSkin(int client, int iWeapon = -1, int skinIndex, int weaponIndex, int iMenu)
{
	char sDisplay[WP_DISPLAY], sWeapon[WP_DISPLAY], sClass[WP_CLASSNAME];
	CSGOItems_GetSkinDisplayNameByDefIndex(skinIndex, sDisplay, sizeof(sDisplay));
	
	CSGOItems_GetWeaponDisplayNameByDefIndex(weaponIndex, sWeapon, sizeof(sWeapon));
	CSGOItems_GetWeaponClassNameByDefIndex(weaponIndex, sClass, sizeof(sClass));
	
	if (!IsValidWeapon(client, weaponIndex, true))
	{
		Command_WS(client, 0);
		return;
	}
	
	if (g_bDebug)
	{
		PrintToChat(client, "You've choosen: [%d] %s for [%d] %s", skinIndex, sDisplay, weaponIndex, sWeapon);
	}
		
	UpdateClientArray(client, sClass, skinIndex, DEFAULT_WEAR, DEFAULT_SEED, DEFAULT_QUALITY);
	UpdateClientMySQL(client, sClass, skinIndex, DEFAULT_WEAR, DEFAULT_SEED, DEFAULT_QUALITY);
	
	if (iWeapon != -1)
	{
		CSGOItems_RemoveWeapon(client, iWeapon);
		
		DataPack pack = new DataPack();
		RequestFrame(Frame_GivePlayerItem, pack);
		pack.WriteCell(GetClientUserId(client));
		pack.WriteString(sClass);
		pack.WriteCell(iMenu);
	}
}

public void Frame_GivePlayerItem(any pack)
{
	ResetPack(pack);
	int client = GetClientOfUserId(ReadPackCell(pack));
	char sClass[WP_CLASSNAME];
	ReadPackString(pack, sClass, sizeof(sClass));
	int iMenu = ReadPackCell(pack);
	delete view_as<DataPack>(pack);
	
	if(IsClientValid(client))
	{
		int iWeapon = GivePlayerItem(client, sClass);
		EquipPlayerWeapon(client, iWeapon);
		
		DataPack pack2 = new DataPack();
		RequestFrame(Frame_SetActionWeapon, pack2);
		pack2.WriteCell(GetClientUserId(client));
		pack2.WriteCell(iWeapon);
		pack2.WriteCell(iMenu);
	}
}

public void Frame_SetActionWeapon(any pack)
{
	ResetPack(pack);
	int client = GetClientOfUserId(ReadPackCell(pack));
	int weapon = ReadPackCell(pack);
	int iMenu = ReadPackCell(pack);
	delete view_as<DataPack>(pack);
	
	if (IsClientValid(client) && CSGOItems_IsValidWeapon(weapon))
	{
		CSGOItems_SetActiveWeapon(client, weapon);
		
		if (iMenu == 1)
		{
			ChooseCurrentWeapon(client);
		}
		else if (iMenu == 2)
		{
			int defIndex = CSGOItems_GetWeaponDefIndexByWeapon(weapon);
			ChooseWeaponSkin(client, defIndex);
		}
	}
}
