#if defined _csgoitems_included_
#endinput
#endif
#define _csgoitems_included_


public SharedPlugin __pl_csgoitems = 
{
	name = "CSGO_Items", 
	file = "CSGO_Items.smx", 
	#if defined REQUIRE_PLUGIN
	required = 1, 
	#else
	required = 0, 
	#endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_csgoitems_SetNTVOptional() {
	MarkNativeAsOptional("CSGOItems_IsValidWeapon");
	MarkNativeAsOptional("CSGOItems_GiveWeapon");
}
#endif

native int CSGOItems_GetWeaponCount();
native int CSGOItems_GetMusicKitCount();
native int CSGOItems_GetSkinCount();
native int CSGOItems_GetGlovesCount();
native int CSGOItems_GetSprayCount();
native int CSGOItems_GetGlovesPaintCount();
native int CSGOItems_GetActiveWeaponCount(const char[] chClassName, int iTeam = 0);

// WEAPONS
native int CSGOItems_GetWeaponNumByDefIndex(int iDefIndex);
native bool CSGOItems_GetWeaponNumByClassName(const char[] chClassName);
native int CSGOItems_GetWeaponDefIndexByWeaponNum(int iWeaponNum);
native bool CSGOItems_GetWeaponDefIndexByClassName(const char[] chClassName);
native bool CSGOItems_GetWeaponClassNameByWeaponNum(int iWeaponNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponClassNameByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponDisplayNameByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponDisplayNameByClassName(const char[] chClassName, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponDisplayNameByWeaponNum(int iWeaponNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponViewModelByWeaponNum(int iWeaponNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponViewModelByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponViewModelByClassName(const char[] chClassName, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponWorldModelByWeaponNum(int iWeaponNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponWorldModelByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetWeaponWorldModelByClassName(const char[] chClassName, char[] chBuffer, int iLengh);
native bool CSGOItems_IsDefIndexKnife(int iDefIndex);
native int CSGOItems_GetWeaponDefIndexByWeapon(int iWeapon);
native bool CSGOItems_GetWeaponClassNameByWeapon(int iWeapon, char[] chBuffer, int iLengh);
native int CSGOItems_GetActiveWeapon(int iClient);
native int CSGOItems_GetActiveWeaponDefIndex(int iClient);
native bool CSGOItems_GetActiveClassName(int iClient, char[] chBuffer, int iLengh);
native bool CSGOItems_IsSkinnableDefIndex(int iDefIndex);
native int CSGOItems_FindWeaponByClassName(int iClient, const char[] chClassName);
native int CSGOItems_GetActiveWeaponNum(int iClient);
native int CSGOItems_GetWeaponSlotByWeaponNum(int iWeaponNum);
native int CSGOItems_GetWeaponSlotByClassName(const char[] chClassName);
native int CSGOItems_GetWeaponSlotByDefIndex(int iDefIndex);
native int CSGOItems_GetWeaponTeamByDefIndex(int iDefIndex);
native int CSGOItems_GetWeaponTeamByClassName(const char[] chClassName);
native int CSGOItems_GetWeaponTeamByWeaponNum(int iWeaponNum);
native int CSGOItems_GetWeaponClipAmmoByDefIndex(int iDefIndex);
native int CSGOItems_GetWeaponClipAmmoByClassName(const char[] chClassName);
native int CSGOItems_GetWeaponClipAmmoByWeaponNum(int iWeaponNum);
native int CSGOItems_GetWeaponReserveAmmoByDefIndex(int iDefIndex);
native int CSGOItems_GetWeaponReserveAmmoByClassName(const char[] chClassName);
native int CSGOItems_GetWeaponReserveAmmoByWeaponNum(int iWeaponNum);
native int CSGOItems_GetWeaponKillAwardByDefIndex(int iDefIndex);
native int CSGOItems_GetWeaponKillAwardByClassName(const char[] chClassName);
native int CSGOItems_GetWeaponKillAwardByWeaponNum(int iWeaponNum);
native float CSGOItems_GetWeaponSpreadByDefIndex(int iDefIndex);
native float CSGOItems_GetWeaponSpreadByClassName(const char[] chClassName);
native float CSGOItems_GetWeaponSpreadByWeaponNum(int iWeaponNum);
native float CSGOItems_GetWeaponCycleTimeByDefIndex(int iDefIndex);
native float CSGOItems_GetWeaponCycleTimeByClassName(const char[] chClassName);
native float CSGOItems_GetWeaponCycleTimeByWeaponNum(int iWeaponNum);
native bool CSGOItems_GetItemSetNumByClassName(const char[] chClassName, char[] chBuffer, int iLengh);
native bool CSGOItems_GetItemSetDisplayNameByClassName(const char[] chClassName, char[] chBuffer, int iLengh);
native bool CSGOItems_GetItemSetDisplayNameByItemSetNum(int iSetNum, char[] chBuffer, int iLengh);
native bool CSGOItems_RefillClipAmmo(int iWeapon);
native bool CSGOItems_RefillReserveAmmo(int iWeapon);
native bool CSGOItems_IsValidWeapon(int iWeapon);
native int CSGOItems_GiveWeapon(int iClient, const char[] chClassName, int iReserveAmmo = -1, int iClipAmmo = -1, int iSwitchTo = -1);
native bool CSGOItems_RemoveKnife(int iClient);
native bool CSGOItems_RemoveWeapon(int iClient, int iWeapon);
native int CSGOItems_RemoveAllWeapons(int iClient, int iSkipSlot = -1);
native bool CSGOItems_SetWeaponAmmo(int iWeapon, int iReserveAmmo = -1, int iClipAmmo = -1);
native int CSGOItems_SetAllWeaponsAmmo(const char[] chClassName, int iReserveAmmo = -1, int iClipAmmo = -1);
native bool CSGOItems_SetActiveWeapon(int iClient, int iWeapon);
native bool CSGOItems_DropWeapon(int iClient, int iWeapon);
native int CSGOItems_GetActiveWeaponSlot(int iClient);
native bool CSGOItems_AreItemsSynced();
native bool CSGOItems_AreItemsSyncing();
native bool CSGOItems_ReSync();
native int CSGOItems_GetRandomSkin();

// SKINS
native bool CSGOItems_IsSkinNumGloveApplicable(int iSkinNum);
native int CSGOItems_GetSkinNumByDefIndex(int iDefIndex);
native int CSGOItems_GetSkinDefIndexBySkinNum(int iSkinNum);
native bool CSGOItems_GetSkinDisplayNameByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetSkinDisplayNameBySkinNum(int iSkinNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetSkinVmtPathBySkinNum(int iSkinNum, char[] chBuffer, int iLength);
native bool CSGOItems_IsNativeSkin(int iSkinNum, int iItemNum);

// Gloves
native int CSGOItems_GetGlovesNumByDefIndex(int iDefIndex);
native bool CSGOItems_GetGlovesNumByClassName(const char[] chClassName);
native int CSGOItems_GetGlovesDefIndexByGlovesNum(int iGlovesNum);
native bool CSGOItems_GetGlovesDisplayNameByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetGlovesDisplayNameByGlovesNum(int iGlovesNum, char[] chBuffer, int iLengh);

native bool CSGOItems_GetGlovesViewModelByGlovesNum(int iGlovesNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetGlovesViewModelByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetGlovesWorldModelByGlovesNum(int iGlovesNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetGlovesWorldModelByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);

// Sprays
native int CSGOItems_GetSprayNumByDefIndex(int iDefIndex);
native int CSGOItems_GetSprayDefIndexBySprayNum(int iSprayNum);

native int CSGOItems_GetSprayCacheIndexByDefIndex(int iDefIndex);
native int CSGOItems_GetSprayCacheIndexBySprayNum(int iSprayNum);

native bool CSGOItems_GetSprayDisplayNameByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetSprayDisplayNameBySprayNum(int iSprayNum, char[] chBuffer, int iLengh);

native bool CSGOItems_GetSprayVMTBySprayNum(int iSprayNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetSprayVMTByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetSprayVTFBySprayNum(int iSprayNum, char[] chBuffer, int iLengh);
native bool CSGOItems_GetSprayVTFByDefIndex(int iSprayNum, char[] chBuffer, int iLengh);

// MUSIC KITS
native int CSGOItems_GetMusicKitNumByDefIndex(int iDefIndex);
native int CSGOItems_GetMusicKitDefIndexByMusicKitNum(int iMusicKitNum);
native bool CSGOItems_GetMusicKitDisplayNameByDefIndex(int iDefIndex, char[] chBuffer, int iLengh);
native bool CSGOItems_GetMusicKitDisplayNameByMusicKitNum(int iMusicKitNum, char[] chBuffer, int iLengh); 