/****************************************************************************************************
[CSGO] CSGO Items
*****************************************************************************************************
Credits: 
		NeuroToxin:
					I have learnt a lot from a lot from your previous work and that has helped create this.
****************************************************************************************************
CHANGELOG
****************************************************************************************************
	0.1 ~ 
		- Many changes which I did not even log..
	0.2 ~ 
	
		- Added the ability to get weapon team(s).
		- Added ability to get weapon clip size.
		- Added ability to refill weapon clip size.
		- Added ability to check if a weapon edict is valid.
	0.3 ~ 
	
		- Added CSGOItems_GiveWeapon
							This function is a replacement for GivePlayerItem, it fixes players not getting loadout skins when the weapon team is the opposite of the player.
							This function also automatically equips knives, so you don't need to use EquipPlayerWeapon.
							Example: CSGOItems_GiveWeapon(iClient, "weapon_ak47"); Player team = CT.
							Outcome: Player will recieve an AK47 with his loadout skin.
							Return: Weapon edict index or -1 if failed.
	0.4 ~
		
		- Added CSGOItems_RemoveWeapon
							This function will properly remove a weapon from a client and automatically kill the entity.
							Example: CSGOItems_RemoveWeapon(iClient, iWeapon);
							TBD: CSGOItems_RemoveWeaponSlot(iClient, CS_SLOT_PRIMARY);
							Outcome: The players weapon will be completely removed.
							Return: True on success or false if the weapon is invalid.
		
		- Improved CSGOItems_GiveWeapon
							- Added the ability to set custom reserve / clip ammo (Only for guns for obvious reasons :P).
								- Example: CSGOItems_GiveWeapon("weapon_ak47", 10, 30); 10 reserve + 30 clip, if nothing defined it will use games default values.
							- Improved team switching functionality.
							- Improved equip functionality to remove animations, This is still WIP and does not yet work for all weapons.
		
		- Added CSGOItems_SetWeaponAmmo (Thanks Zipcore for the suggestion)
							This function allows you to set the ammo if any valid weapon entity index.
							Example: CSGOItems_SetWeaponAmmo(iWeapon, 30, 30); 30 Reserve / 30 Clip.
							Usage: You can use -1 to skip setting a certain type of ammo, CSGOItems_SetWeaponAmmo(iWeapon, -1, 30); would skip changing the reserve ammo.
							Outcome: The weapon Reserve and / or clip ammo will be changed if the weapon index is valid.
							Return: True on success or false if the weapon is invalid.
							
		0.5 ~
			- Will add a changelog later, too tired for it now :P
		
		0.6 ~ 
			- Fixed Reserve and Clip ammo functionality.
			- Fixed a bug which caused KV Iteration to fail in some cases.
			- Fixed error spam related to m_iZoomLevel.
			- Added CSGOItems_RemoveKnife. (This function will remove the players knife without removing the Zeus if he has one.)
			- Added CSGOItems_RefillReserveAmmo.
			- Added Reserve ammo natives (For retrieving the values).
			- General Cleanup.
		0.7 ~
			- Removed System2.
			- Using SteamWorks now to retrieve language file.
			- Fixed potential infinite loop / crash.
		0.8 ~
			- General optimization / cleanup.
			- Added CSGOItems_GetRandomSkin
							This function will return a random skin defindex.		
			
			- Added CSGOItems_SetAllWeaponsAmmo
							This function will loop through all spawned weapons of a specific classname and set clip/reserve ammo.
		0.9 ~
			- Added CSGOItems_GetActiveWeaponCount
							This function will return the number of actively equipped weapons by classname.
							
							Example 1, Get number of players with AWP equipped on CT: 
									CSGOItems_GetActiveWeaponCount("weapon_awp", CS_TEAM_CT);
							
							Example 2, Get number of players with AWP equipped on T: 
									CSGOItems_GetActiveWeaponCount("weapon_awp", CS_TEAM_T);
									
							Example 3, Get number of players with AWP equipped on any team: 
									CSGOItems_GetActiveWeaponCount("weapon_awp");
									
			- Added CSGOItems_GetWeaponKillAward(ByDefIndex, ByClassName, ByWeaponNum)
							These functions will return the kill award for the specified weapon.
			
			- Fixed some logic errors with variables / loops.
			- Fixed a rare issue where CSGOItems_GiveWeapon would fail when it shouldn't of.
		1.0 ~
			- New method for Removing player weapons, this should fix some crashes!
		
		1.0.1 ~
			- Added CSGOItems_RemoveAllWeapons
					This function will safely remove all the weapons a client has got equipped, with an option to skip a certain slot.
					
					Example 1, Remove all clients weapons.
							CSGOItems_RemoveAllWeapons(iClient);
					
					Example 2, Remove all clients weapons but leave the knife slot.
							CSGOItems_RemoveAllWeapons(iClient, CS_SLOT_KNIFE);
							
					Return: Number of weapons sucessfully removed from client.
					
			- Implemented Bacardi's weapon looping, Very nice, credits to him! (This is a lot safer and more efficient than my old method.)
			- Added an extra validation check before removing client weapons.
		1.1 ~
			- Fixed a bug when retrieving Language would not automatically rename the newly retrieved file.
			- Implemented a new API which retrieves a fixed version of the Item schema which can be iterated without issues, (Thanks Valve, you forced me to spend a day coding in PHP)
		1.2 ~
			- Updated item schema url.
			- Improved validation before removing weapons now.
		1.3 ~
			- Added some experimental and untested support for CSGO Item sets (Still needs some work)
			- Fix item sync not happening on plugin start if late loaded.
			- Fixed a rare case where players hud would disappear.
			- Improved and cleaned up KV Iteration.
			- Improved give weapon, remove weapon and switch weapon code and added more validation (Should help fix some crashes and strange issues which occur)
			- General code cleanup and improvements.
			
		1.3.1 ~
			- Added CSGOItems_DropWeapon
					This function will safely drop a weapon which the client has equipped, what makes this different is it will prevent errors if the weapon does not belong to the client.
					
					Example:
						(BOOL) CSGOItems_DropWeapon(iClient, iWeapon);
				
					Return: True on success
					
			- Fixed netprops for last csgo update.
			- Added CSGOItems_GetWeaponViewModel & CSGOItems_GetWeaponWorldModel natives.
			- General logic improvements / fixes in the natives.
		
		1.3.2 ~
			- Added CSGOItems_GetWeaponSpread natives.
					These natives will return the spread value as a float.
		1.3.3 ~
			- Added CSGOItems_GetWeaponCycleTime natives.
					These natives will return the spread value as a float.
			- Fixed tag mismatches in new natives.
			
		1.3.4 ~
			- Improved RemoveWeapon, now removes the weapon world entity to help prevent crashes.
			- Added Vanilla & Default to skin list.
			- Make sure / Wait for SteamWorks to be loaded before retrieving language / item schema.
			- General validation improvements.
			
		1.3.5 ~
			- Added gloves & spray support.
			- Added experimental support for giving certain weapons in special scenarios when it would give the wrong weapon (Example giving USP when client has P2K in loadout) (PTAH is required)
			- Fixed translation url.
			- Fixed SteamWorks loading late.
			- Fixed a bug where the SwitchTo was being incorrectly determined in CSGOItems_GiveWeapon
			- Added CSGOItems_OnWeaponGiven forward
					public void CSGOItems_OnWeaponGiven(int iClient, int iWeapon, const char[] szClassName, int iDefIndex, int iWeaponSlot, bool bSkinnable, bool bIsKnife)
			- Increased Cell array sizes (I really need to implement Dynamic at some point..)
			- Prevent giving knives to avoid GLST bans (It will now automatically set it to weapon_knife or weapon_knife_t dependent of the client team.)
			- Many other fixes / code cleanup (Please avoid indenting the code using Spedit it will break a few things) (Ignore the compile warnings.)
		1.3.6 ~
			- Removed PTAH completely.
			- Made sprays feature optional, if you create a spray plugin then you will want to enable the cvar csgoitems_spraysenabled.
			- Improved weapon removal method.
			- A few other misc fixes.
		1.3.7 ~
			- Update language url.
		1.3.8 ~
			- Fixed crash related to null being passed in forward when a definition index was out of bounds.
			- Removed the horrible backward slashes which were causing indentation to fuck up, Apparently they were not needed and a forward slash is fine.
				- If you utilize the spray natives then you will notice the folder will be regenerated as csgoitemsv2 in order to fix any pure mismatches with clients.
				- You will have to reupload the new files to your FastDL server.
			- Fixed CSGOItems_IsSkinnableDefIndex throwing an error when the input was out of bounds.
				- It will now also throw an error if the defindex goes over 700 (Which is the current max size of the cell arrays) Just incase volvo add new weapons eventually.
			- Removed some left over code and variables which is no longer used.
			- Fixed WeaponDefIndex and WeaponNum potentially being incorrect inside the CSGOItems_GiveWeapon native.
			
****************************************************************************************************
INCLUDES
***************************************************************************************************/
#include <sourcemod>
#include <sdktools>
#include <cstrike> 
#include <sdkhooks> 
#include <csgoitems> 
#include <SteamWorks> 
#include <autoexecconfig> 

/****************************************************************************************************
DEFINES
*****************************************************************************************************/
#define VERSION "1.3.8"

#define 	DEFINDEX 		0
#define 	CLASSNAME 		1
#define 	DISPLAYNAME 	2
#define 	SLOT 			3
#define 	TEAM 			4
#define 	CLIPAMMO 		5
#define 	RESERVEAMMO 	6
#define 	TYPE 			7
#define 	KILLAWARD 		8
#define 	ITEMNAME        9
#define     RARITY			10
#define     SKIN_WEAPON		11
#define     SKIN_CASE		12
#define     VIEWMODEL		13
#define     WORLDMODEL		14
#define     DROPMODEL		14
#define     VIEWMATERIAL	15
#define     WORLDMATERIAL	16
#define     SPREAD			17
#define     CYCLETIME		18
#define     VMTPATH			19
#define     VTFPATH			20

#define 	LANGURL         "http://api.fragdeluxe.com/itemdata/csgo_language.php"
#define 	SCHEMAURL         "http://api.fragdeluxe.com/itemdata/csgo_schema.php"

/****************************************************************************************************
ETIQUETTE.
*****************************************************************************************************/
#pragma newdecls required // To be moved before includes one day.
#pragma semicolon 1

/****************************************************************************************************
PLUGIN INFO.
*****************************************************************************************************/
public Plugin myinfo = 
{
	name = "CSGO Items", 
	author = "SM9", 
	version = VERSION, 
	url = "http://www.fragdeluxe.com"
};

/****************************************************************************************************
HANDLES.
*****************************************************************************************************/
Handle g_hItemsKv = null;
Handle g_hOnItemsSynced = null;
Handle g_hOnPluginEnd = null;
Handle g_hSwitchWeaponCall = null;
Handle g_hOnWeaponGiven = null;
ConVar g_hCvarSpraysEnabled = null;

/****************************************************************************************************
BOOLS.
*****************************************************************************************************/
bool g_bIsDefIndexKnife[700];
bool g_bIsDefIndexSkinnable[700];
bool g_bSkinNumGloveApplicable[700];
bool g_bItemsSynced;
bool g_bItemsSyncing;
bool g_bLanguageDownloading;
bool g_bSchemaDownloading;
bool g_bGivingWeapon[MAXPLAYERS + 1];
bool g_bIsNativeSkin[650][100];
bool g_bIsSkinInSet[100][650];
bool g_bSteamWorksLoaded = false;
bool g_bRoundEnd = false;
bool g_bSpraysEnabled = false;

/****************************************************************************************************
STRINGS.
*****************************************************************************************************/
char g_szWeaponInfo[100][22][48];
char g_chPaintInfo[650][22][96];
char g_chMusicKitInfo[100][3][48];
char g_chGlovesInfo[100][22][96];
char g_chSprayInfo[650][22][128];
char g_chItemSetInfo[100][3][48];
char g_chLangPhrases[2198296];
char g_chSchemaPhrases[2198296];

static char g_chViewSequence1[][] = 
{
	"weapon_knife_falchion", "weapon_knife_push", 
	"weapon_knife_survival_bowie", "weapon_m4a1_silencer"
};

/****************************************************************************************************
INTS.
*****************************************************************************************************/
int g_iPaintCount = 0;
int g_iWeaponCount = 0;
int g_iMusicKitCount = 0;
int g_iGlovesCount = 0;
int g_iGlovesPaintCount = 0;
int g_iItemSetCount = 0;
int g_iSprayCount = 0;
int g_iLanguageDownloadAttempts = 0;
int g_iSchemaDownloadAttempts = 0;

#define CSGOItems_LoopWeapons(%1) for(int %1 = 0; %1 < g_iWeaponCount; %1++)
#define CSGOItems_LoopSkins(%1) for(int %1 = 0; %1 < g_iPaintCount; %1++)
#define CSGOItems_LoopGloves(%1) for(int %1 = 0; %1 < g_iGlovesCount; %1++)
#define CSGOItems_LoopSprays(%1) for(int %1 = 0; %1 < g_iSprayCount; %1++)
#define CSGOItems_LoopMusicKits(%1) for(int %1 = 0; %1 < g_iMusicKitCount; %1++)
#define CSGOItems_LoopItemSets(%1) for(int %1 = 0; %1 < g_iItemSetCount; %1++)
#define CSGOItems_LoopWeaponSlots(%1) for(int %1 = 0; %1 < 6; %1++)
#define CSGOItems_LoopValidWeapons(%1) for(int %1 = MaxClients; %1 < 2048; %1++) if(CSGOItems_IsValidWeapon(%1))
#define CSGOItems_LoopValidClients(%1) for(int %1 = 1; %1 < MaxClients; %1++) if(IsValidClient(%1))

public void OnPluginStart()
{
	if (GetEngineVersion() != Engine_CSGO) {
		Call_StartForward(g_hOnPluginEnd);
		Call_Finish();
		SetFailState("This plugin is for CSGO only.");
	}
	
	/****************************************************************************************************
											--FORWARDS--
	*****************************************************************************************************/
	g_hOnItemsSynced = CreateGlobalForward("CSGOItems_OnItemsSynced", ET_Ignore);
	g_hOnPluginEnd = CreateGlobalForward("CSGOItems_OnPluginEnd", ET_Ignore);
	g_hOnWeaponGiven = CreateGlobalForward("CSGOItems_OnWeaponGiven", ET_Ignore, Param_Cell, Param_Cell, Param_String, Param_Cell, Param_Cell, Param_Cell, Param_Cell);
	
	Handle hConfig = LoadGameConfigFile("sdkhooks.games");
	
	StartPrepSDKCall(SDKCall_Player);
	PrepSDKCall_SetFromConf(hConfig, SDKConf_Virtual, "Weapon_Switch");
	PrepSDKCall_AddParameter(SDKType_CBaseEntity, SDKPass_Pointer);
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	
	g_hSwitchWeaponCall = EndPrepSDKCall();
	
	CloseHandle(hConfig);
	
	CSGOItems_LoopValidClients(iClient) {
		OnClientPutInServer(iClient);
	}
	
	HookEvent("player_death", Event_PlayerDeath);
	HookEvent("round_poststart", OnRoundStart, EventHookMode_Post);
	HookEvent("round_end", OnRoundEnd, EventHookMode_Pre);
	
	AutoExecConfig_SetFile("plugin.csgoitems");
	g_hCvarSpraysEnabled = AutoExecConfig_CreateConVar("csgoitems_spraysenabled", "0", "Should CSGO Items add support for sprays / make clients download them?");
	g_hCvarSpraysEnabled.AddChangeHook(OnCvarChanged);
	AutoExecConfig_CleanFile(); AutoExecConfig_ExecuteFile();
}

public void OnCvarChanged(ConVar hConVar, const char[] szOldValue, const char[] szNewValue)
{
	if (hConVar == g_hCvarSpraysEnabled) {
		g_bSpraysEnabled = view_as<bool>(StringToInt(szNewValue));
	}
}

public int SteamWorks_SteamServersConnected() {
	RetrieveLanguage();
}

public void OnAllPluginsLoaded() {
	g_bSteamWorksLoaded = LibraryExists("SteamWorks");
	
	if (g_bSteamWorksLoaded) {
		RetrieveLanguage();
	}
}

public void OnLibraryAdded(const char[] szName) {
	if (StrEqual(szName, "SteamWorks")) {
		g_bSteamWorksLoaded = true;
		RetrieveLanguage();
	}
}

public void OnLibraryRemoved(const char[] szName) {
	if (StrEqual(szName, "SteamWorks")) {
		g_bSteamWorksLoaded = false;
	}
}

public void OnPluginEnd()
{
	Call_StartForward(g_hOnPluginEnd);
	Call_Finish();
}

public APLRes AskPluginLoad2(Handle hMyself, bool bLate, char[] chError, int iErrMax)
{
	/****************************************************************************************************
											--GENERAL NATIVES--
	*****************************************************************************************************/
	
	// Item Counts
	CreateNative("CSGOItems_GetWeaponCount", Native_GetWeaponCount);
	CreateNative("CSGOItems_GetSkinCount", Native_GetSkinCount);
	CreateNative("CSGOItems_GetGlovesCount", Native_GetGlovesCount);
	CreateNative("CSGOItems_GetSprayCount", Native_GetSprayCount);
	CreateNative("CSGOItems_GetGlovesPaintCount", Native_GetGlovesPaintCount);
	CreateNative("CSGOItems_GetMusicKitCount", Native_GetMusicKitCount);
	CreateNative("CSGOItems_GetItemSetCount", Native_GetItemSetCount);
	CreateNative("CSGOItems_AreItemsSynced", Native_AreItemsSynced);
	CreateNative("CSGOItems_AreItemsSyncing", Native_AreItemsSyncing);
	CreateNative("CSGOItems_ReSync", Native_Resync);
	CreateNative("CSGOItems_GetActiveWeaponCount", Native_GetActiveWeaponCount);
	
	/****************************************************************************************************
											--WEAPON NATIVES--
	*****************************************************************************************************/
	
	// Weapon Numbers
	CreateNative("CSGOItems_GetWeaponNumByDefIndex", Native_GetWeaponNumByDefIndex);
	CreateNative("CSGOItems_GetWeaponNumByClassName", Native_GetWeaponNumByClassName);
	
	// Weapon Definition Indexes
	CreateNative("CSGOItems_GetWeaponDefIndexByWeaponNum", Native_GetWeaponDefIndexByWeaponNum);
	CreateNative("CSGOItems_GetWeaponDefIndexByClassName", Native_GetWeaponDefIndexByClassName);
	
	// Weapon Class Names
	CreateNative("CSGOItems_GetWeaponClassNameByWeaponNum", Native_GetWeaponClassNameByWeaponNum);
	CreateNative("CSGOItems_GetWeaponClassNameByDefIndex", Native_GetWeaponClassNameByDefIndex);
	CreateNative("CSGOItems_GetWeaponClassNameByWeapon", Native_GetWeaponClassNameByWeapon);
	
	// Weapon Display Names
	CreateNative("CSGOItems_GetWeaponDisplayNameByDefIndex", Native_GetWeaponDisplayNameByDefIndex);
	CreateNative("CSGOItems_GetWeaponDisplayNameByClassName", Native_GetWeaponDisplayNameByClassName);
	CreateNative("CSGOItems_GetWeaponDisplayNameByWeaponNum", Native_GetWeaponDisplayNameByWeaponNum);
	
	// Weapon Models
	CreateNative("CSGOItems_GetWeaponViewModelByWeaponNum", Native_GetWeaponViewModelByWeaponNum);
	CreateNative("CSGOItems_GetWeaponViewModelByDefIndex", Native_GetWeaponViewModelByDefIndex);
	CreateNative("CSGOItems_GetWeaponViewModelByClassName", Native_GetWeaponViewModelByClassName);
	
	CreateNative("CSGOItems_GetWeaponWorldModelByWeaponNum", Native_GetWeaponWorldModelByWeaponNum);
	CreateNative("CSGOItems_GetWeaponWorldModelByDefIndex", Native_GetWeaponWorldModelByDefIndex);
	CreateNative("CSGOItems_GetWeaponWorldModelByClassName", Native_GetWeaponWorldModelByClassName);
	
	// Weapon Teams
	CreateNative("CSGOItems_GetWeaponTeamByDefIndex", Native_GetWeaponTeamByDefIndex);
	CreateNative("CSGOItems_GetWeaponTeamByClassName", Native_GetWeaponTeamByClassName);
	CreateNative("CSGOItems_GetWeaponTeamByWeaponNum", Native_GetWeaponTeamByWeaponNum);
	
	// Weapon Slots
	CreateNative("CSGOItems_GetWeaponSlotByWeaponNum", Native_GetWeaponSlotByWeaponNum);
	CreateNative("CSGOItems_GetWeaponSlotByClassName", Native_GetWeaponSlotByClassName);
	CreateNative("CSGOItems_GetWeaponSlotByDefIndex", Native_GetWeaponSlotByDefIndex);
	
	// Weapon Ammo
	CreateNative("CSGOItems_GetWeaponClipAmmoByDefIndex", Native_GetWeaponClipAmmoByDefIndex);
	CreateNative("CSGOItems_GetWeaponClipAmmoByClassName", Native_GetWeaponClipAmmoByClassName);
	CreateNative("CSGOItems_GetWeaponClipAmmoByWeaponNum", Native_GetWeaponClipAmmoByWeaponNum);
	CreateNative("CSGOItems_GetWeaponReserveAmmoByDefIndex", Native_GetWeaponReserveAmmoByDefIndex);
	CreateNative("CSGOItems_GetWeaponReserveAmmoByClassName", Native_GetWeaponReserveAmmoByClassName);
	CreateNative("CSGOItems_GetWeaponReserveAmmoByWeaponNum", Native_GetWeaponReserveAmmoByWeaponNum);
	CreateNative("CSGOItems_SetWeaponAmmo", Native_SetWeaponAmmo);
	CreateNative("CSGOItems_SetAllWeaponsAmmo", Native_SetAllWeaponsAmmo);
	CreateNative("CSGOItems_RefillClipAmmo", Native_RefillClipAmmo);
	CreateNative("CSGOItems_RefillReserveAmmo", Native_RefillReserveAmmo);
	
	// Weapon Cash
	CreateNative("CSGOItems_GetWeaponKillAwardByDefIndex", Native_GetWeaponKillAwardByDefIndex);
	CreateNative("CSGOItems_GetWeaponKillAwardByClassName", Native_GetWeaponKillAwardByClassName);
	CreateNative("CSGOItems_GetWeaponKillAwardByWeaponNum", Native_GetWeaponKillAwardByWeaponNum);
	
	// Weapon Spread
	CreateNative("CSGOItems_GetWeaponSpreadByDefIndex", Native_GetWeaponSpreadByDefIndex);
	CreateNative("CSGOItems_GetWeaponSpreadByClassName", Native_GetWeaponSpreadByClassName);
	CreateNative("CSGOItems_GetWeaponSpreadByWeaponNum", Native_GetWeaponSpreadByWeaponNum);
	
	// Weapon Cycle Time
	CreateNative("CSGOItems_GetWeaponCycleTimeByDefIndex", Native_GetWeaponCycleTimeByDefIndex);
	CreateNative("CSGOItems_GetWeaponCycleTimeByClassName", Native_GetWeaponCycleTimeByClassName);
	CreateNative("CSGOItems_GetWeaponCycleTimeByWeaponNum", Native_GetWeaponCycleTimeByWeaponNum);
	
	// Misc
	CreateNative("CSGOItems_IsDefIndexKnife", Native_IsDefIndexKnife);
	CreateNative("CSGOItems_GetWeaponDefIndexByWeapon", Native_GetWeaponDefIndexByWeapon);
	CreateNative("CSGOItems_GetActiveClassName", Native_GetActiveClassName);
	CreateNative("CSGOItems_GetActiveWeaponDefIndex", Native_GetActiveWeaponDefIndex);
	CreateNative("CSGOItems_GetActiveWeaponNum", Native_GetActiveWeaponNum);
	CreateNative("CSGOItems_GetActiveWeapon", Native_GetActiveWeapon);
	CreateNative("CSGOItems_FindWeaponByClassName", Native_FindWeaponByClassName);
	CreateNative("CSGOItems_IsValidWeapon", Native_IsValidWeapon);
	CreateNative("CSGOItems_GiveWeapon", Native_GiveWeapon);
	CreateNative("CSGOItems_RemoveWeapon", Native_RemoveWeapon);
	CreateNative("CSGOItems_DropWeapon", Native_DropWeapon);
	CreateNative("CSGOItems_RemoveAllWeapons", Native_RemoveAllWeapons);
	CreateNative("CSGOItems_RemoveKnife", Native_RemoveKnife);
	CreateNative("CSGOItems_SetActiveWeapon", Native_SetActiveWeapon);
	CreateNative("CSGOItems_GetActiveWeaponSlot", Native_GetActiveWeaponSlot);
	
	/****************************************************************************************************
											--SKIN NATIVES--
	*****************************************************************************************************/
	// Skin Numbers
	CreateNative("CSGOItems_GetSkinNumByDefIndex", Native_GetSkinNumByDefIndex);
	
	// Skin Definition Indexes
	CreateNative("CSGOItems_GetSkinDefIndexBySkinNum", Native_GetSkinDefIndexBySkinNum);
	
	// Skin Display Names
	CreateNative("CSGOItems_GetSkinDisplayNameByDefIndex", Native_GetSkinDisplayNameByDefIndex);
	CreateNative("CSGOItems_GetSkinDisplayNameBySkinNum", Native_GetSkinDisplayNameBySkinNum);
	
	
	// Misc
	CreateNative("CSGOItems_IsSkinnableDefIndex", Native_IsSkinnableDefIndex);
	CreateNative("CSGOItems_IsSkinNumGloveApplicable", Native_IsSkinNumGloveApplicable);
	CreateNative("CSGOItems_GetRandomSkin", Native_GetRandomSkin);
	CreateNative("CSGOItems_GetSkinVmtPathBySkinNum", Native_GetSkinVmtPathBySkinNum);
	CreateNative("CSGOItems_IsNativeSkin", Native_IsNativeSkin);
	
	/****************************************************************************************************
											--MUSIC KIT NATIVES--
	*****************************************************************************************************/
	
	// Music Kit Numbers
	CreateNative("CSGOItems_GetMusicKitNumByDefIndex", Native_GetMusicKitNumByDefIndex);
	
	// Music Kit Definition Indexes
	CreateNative("CSGOItems_GetMusicKitDefIndexByMusicKitNum", Native_GetMusicKitDefIndexByMusicKitNum);
	
	// Music Kit Display Names
	CreateNative("CSGOItems_GetMusicKitDisplayNameByDefIndex", Native_GetMusicKitDisplayNameByDefIndex);
	CreateNative("CSGOItems_GetMusicKitDisplayNameByMusicKitNum", Native_GetMusicKitDisplayNameByMusicKitNum);
	
	/****************************************************************************************************
											--ITEM SET NATIVES--
	*****************************************************************************************************/
	
	// Item Set Numbers
	CreateNative("CSGOItems_GetItemSetNumByClassName", Native_GetItemSetNumByClassName);
	
	// Set Names
	CreateNative("CSGOItems_GetItemSetDisplayNameByClassName", Native_GetItemSetDisplayNameByClassName);
	CreateNative("CSGOItems_GetItemSetDisplayNameByItemSetNum", Native_GetItemSetDisplayNameByItemSetNum);
	
	/****************************************************************************************************
											--GLOVES NATIVES--
	*****************************************************************************************************/
	
	// Gloves Numbers
	CreateNative("CSGOItems_GetGlovesNumByDefIndex", Native_GetGlovesNumByDefIndex);
	CreateNative("CSGOItems_GetGlovesNumByClassName", Native_GetGlovesNumByClassName);
	
	// Gloves Definition Indexes
	CreateNative("CSGOItems_GetGlovesDefIndexByGlovesNum", Native_GetGlovesDefIndexByGlovesNum);
	
	// Gloves Display Names
	CreateNative("CSGOItems_GetGlovesDisplayNameByDefIndex", Native_GetGlovesDisplayNameByDefIndex);
	CreateNative("CSGOItems_GetGlovesDisplayNameByGlovesNum", Native_GetGlovesDisplayNameByGlovesNum);
	
	// Gloves Models
	CreateNative("CSGOItems_GetGlovesViewModelByGlovesNum", Native_GetGlovesViewModelByGlovesNum);
	CreateNative("CSGOItems_GetGlovesViewModelByDefIndex", Native_GetGlovesViewModelByDefIndex);
	
	CreateNative("CSGOItems_GetGlovesWorldModelByGlovesNum", Native_GetGlovesWorldModelByGlovesNum);
	CreateNative("CSGOItems_GetGlovesWorldModelByDefIndex", Native_GetGlovesWorldModelByDefIndex);
	
	/****************************************************************************************************
											--SPRAY NATIVES--
	*****************************************************************************************************/
	
	// Spray Numbers
	CreateNative("CSGOItems_GetSprayNumByDefIndex", Native_GetSprayNumByDefIndex);
	
	// Spray Indexes
	CreateNative("CSGOItems_GetSprayDefIndexBySprayNum", Native_GetSprayDefIndexBySprayNum);
	
	// Spray Display Names
	CreateNative("CSGOItems_GetSprayDisplayNameByDefIndex", Native_GetSprayDisplayNameByDefIndex);
	CreateNative("CSGOItems_GetSprayDisplayNameBySprayNum", Native_GetSprayDisplayNameBySprayNum);
	
	// Spray Textures
	CreateNative("CSGOItems_GetSprayVMTBySprayNum", Native_GetSprayVMTBySprayNum);
	CreateNative("CSGOItems_GetSprayVMTByDefIndex", Native_GetSprayVMTByDefIndex);
	
	CreateNative("CSGOItems_GetSprayVTFBySprayNum", Native_GetSprayVTFBySprayNum);
	CreateNative("CSGOItems_GetSprayVTFByDefIndex", Native_GetSprayVTFByDefIndex);
	
	CreateNative("CSGOItems_GetSprayCacheIndexBySprayNum", Native_GetSprayCacheIndexBySprayNum);
	CreateNative("CSGOItems_GetSprayCacheIndexDefIndex", Native_GetSprayCacheIndexByDefIndex);
	
	RegPluginLibrary("CSGO_Items");
	return APLRes_Success;
}

public Action OnRoundStart(Handle hEvent, char[] szName, bool bDontBroadcast) { g_bRoundEnd = false; }
public Action OnRoundEnd(Handle hEvent, char[] szName, bool bDontBroadcast) { g_bRoundEnd = true; }

public bool RetrieveLanguage()
{
	if (!g_bSteamWorksLoaded) {
		return false;
	}
	
	if (g_bLanguageDownloading || g_bSchemaDownloading || g_bItemsSyncing || !SteamWorks_IsConnected()) {
		return false;
	}
	
	Handle hRequest = SteamWorks_CreateHTTPRequest(k_EHTTPMethodGET, LANGURL);
	
	SteamWorks_SetHTTPRequestHeaderValue(hRequest, "Pragma", "no-cache");
	SteamWorks_SetHTTPRequestHeaderValue(hRequest, "Cache-Control", "no-cache");
	SteamWorks_SetHTTPCallbacks(hRequest, Language_Retrieved);
	
	if (SteamWorks_SendHTTPRequest(hRequest) && hRequest != null) {
		g_bLanguageDownloading = true;
		g_iLanguageDownloadAttempts++;
		return true;
	} else {
		CreateTimer(2.0, Timer_SyncLanguage, hRequest);
		LogMessage("[WARNING] SteamWorks language retrieval failed, attempting to use old file (If one is available)");
		
		if (hRequest != null) {
			CloseHandle(hRequest);
		}
	}
	
	return false;
}

public int Language_Retrieved(Handle hRequest, bool bFailure, bool bRequestSuccessful, EHTTPStatusCode eStatusCode, any anything)
{
	if (bRequestSuccessful && eStatusCode == k_EHTTPStatusCode200OK) {
		if (FileExists("resource/csgo_english_utf8.txt")) {
			SteamWorks_WriteHTTPResponseBodyToFile(hRequest, "resource/csgo_english_utf8_new.txt");
		} else {
			SteamWorks_WriteHTTPResponseBodyToFile(hRequest, "resource/csgo_english_utf8.txt");
		}
	}
	
	LogMessage("UTF-8 language file successfully retrieved.");
	
	CreateTimer(1.0, Timer_SyncLanguage, hRequest);
}

public Action Timer_SyncLanguage(Handle hTimer, Handle hRequest)
{
	Handle hLanguageFile = OpenFile("resource/csgo_english_utf8.txt", "r");
	Handle hLanguageFileNew = OpenFile("resource/csgo_english_utf8_new.txt", "r");
	
	if (hLanguageFileNew != null && ReadFileString(hLanguageFileNew, g_chLangPhrases, 2198296) && StrContains(g_chLangPhrases, "// GAMEUI_ENGLISH.txt") != -1) {
		if (hLanguageFile != null) {
			CloseHandle(hLanguageFile);
			hLanguageFile = null;
		}
		
		CloseHandle(hLanguageFileNew); hLanguageFileNew = null;
		
		DeleteFile("resource/csgo_english_utf8.txt");
		RenameFile("resource/csgo_english_utf8.txt", "resource/csgo_english_utf8_new.txt");
	}
	
	else if (hLanguageFile != null && ReadFileString(hLanguageFile, g_chLangPhrases, 2198296) && StrContains(g_chLangPhrases, "// GAMEUI_ENGLISH.txt") != -1) {
		if (hLanguageFileNew != null) {
			CloseHandle(hLanguageFileNew);
			hLanguageFileNew = null;
		}
		
		CloseHandle(hLanguageFile); hLanguageFile = null;
		
		DeleteFile("resource/csgo_english_utf8_new.txt");
	}
	else {
		g_bLanguageDownloading = false;
		
		if (hRequest != null) {
			CloseHandle(hRequest);
		}
		
		if (hLanguageFile != null) {
			CloseHandle(hLanguageFile);
		}
		
		if (hLanguageFileNew != null) {
			CloseHandle(hLanguageFileNew);
		}
		
		DeleteFile("resource/csgo_english_utf8.txt"); DeleteFile("resource/csgo_english_utf8_new.txt");
		
		if (g_iLanguageDownloadAttempts < 10) {
			RetrieveLanguage();
			return Plugin_Stop;
		} else {
			Call_StartForward(g_hOnPluginEnd);
			Call_Finish();
			SetFailState("UTF-8 language file is corrupted, failed after %d attempts. \nCheck: %s", g_iLanguageDownloadAttempts, LANGURL);
		}
	}
	
	if (hRequest != null) {
		CloseHandle(hRequest);
	}
	
	if (hLanguageFile != null) {
		CloseHandle(hLanguageFile);
	}
	
	if (hLanguageFileNew != null) {
		CloseHandle(hLanguageFileNew);
	}
	
	g_bLanguageDownloading = false;
	g_iLanguageDownloadAttempts = 0;
	LogMessage("UTF-8 language file successfully processed, retrieving item schema.");
	
	RetrieveItemSchema();
	
	return Plugin_Stop;
}

public bool RetrieveItemSchema()
{
	if (g_bItemsSyncing || g_bSchemaDownloading) {
		return false;
	}
	
	Handle hRequest = SteamWorks_CreateHTTPRequest(k_EHTTPMethodGET, SCHEMAURL);
	
	SteamWorks_SetHTTPRequestHeaderValue(hRequest, "Pragma", "no-cache");
	SteamWorks_SetHTTPRequestHeaderValue(hRequest, "Cache-Control", "no-cache");
	SteamWorks_SetHTTPCallbacks(hRequest, Schema_Retrieved);
	
	if (SteamWorks_SendHTTPRequest(hRequest) && hRequest != null) {
		g_bSchemaDownloading = true;
		g_iSchemaDownloadAttempts++;
		return true;
	} else {
		CreateTimer(2.0, Timer_SyncSchema, hRequest);
		LogMessage("[WARNING] SteamWorks schema retrieval failed, attempting to use old file (If one is available)");
	}
	
	return false;
}

public int Schema_Retrieved(Handle hRequest, bool bFailure, bool bRequestSuccessful, EHTTPStatusCode eStatusCode, any anything)
{
	if (bRequestSuccessful && eStatusCode == k_EHTTPStatusCode200OK) {
		if (FileExists("scripts/items/items_game_fixed.txt")) {
			SteamWorks_WriteHTTPResponseBodyToFile(hRequest, "scripts/items/items_game_fixed_new.txt");
		} else {
			SteamWorks_WriteHTTPResponseBodyToFile(hRequest, "scripts/items/items_game_fixed.txt");
		}
	}
	
	LogMessage("Item Schema successfully retrieved.");
	
	CreateTimer(1.0, Timer_SyncSchema, hRequest);
}

public Action Timer_SyncSchema(Handle hTimer, Handle hRequest)
{
	Handle hSchemaFile = OpenFile("scripts/items/items_game_fixed.txt", "r");
	Handle hSchemaFileNew = OpenFile("scripts/items/items_game_fixed_new.txt", "r");
	
	if (hSchemaFileNew != null && ReadFileString(hSchemaFileNew, g_chSchemaPhrases, 2198296) && StrContains(g_chSchemaPhrases, "\"items_game\"") != -1) {
		if (hSchemaFile != null) {
			CloseHandle(hSchemaFile);
			hSchemaFile = null;
		}
		
		CloseHandle(hSchemaFileNew); hSchemaFileNew = null;
		
		DeleteFile("scripts/items/items_game_fixed.txt");
		RenameFile("scripts/items/items_game_fixed.txt", "scripts/items/items_game_fixed_new.txt");
	}
	
	else if (hSchemaFile != null && ReadFileString(hSchemaFile, g_chSchemaPhrases, 2198296) && StrContains(g_chSchemaPhrases, "\"items_game\"") != -1) {
		if (hSchemaFileNew != null) {
			CloseHandle(hSchemaFileNew);
			hSchemaFileNew = null;
		}
		
		CloseHandle(hSchemaFile); hSchemaFile = null;
		
		DeleteFile("scripts/items/items_game_fixed_new.txt");
	}
	else {
		g_bItemsSyncing = false;
		
		if (hRequest != null) {
			CloseHandle(hRequest);
		}
		
		if (hSchemaFile != null) {
			CloseHandle(hSchemaFile);
		}
		
		if (hSchemaFileNew != null) {
			CloseHandle(hSchemaFileNew);
		}
		
		DeleteFile("scripts/items/items_game_fixed.txt"); DeleteFile("scripts/items/items_game_fixed_new.txt");
		
		if (g_iSchemaDownloadAttempts < 10) {
			RetrieveItemSchema();
			return Plugin_Stop;
		} else {
			Call_StartForward(g_hOnPluginEnd);
			Call_Finish();
			SetFailState("Item schema is corrupted, failed after %d attempts. \nCheck: %s", g_iSchemaDownloadAttempts, SCHEMAURL);
		}
	}
	
	if (hRequest != null) {
		CloseHandle(hRequest);
	}
	
	if (hSchemaFile != null) {
		CloseHandle(hSchemaFile);
	}
	
	if (hSchemaFileNew != null) {
		CloseHandle(hSchemaFileNew);
	}
	
	g_bSchemaDownloading = false;
	g_iSchemaDownloadAttempts = 0;
	
	LogMessage("Item Schema successfully processed, syncing item data.");
	
	SyncItemData();
	
	return Plugin_Stop;
}

public void SyncItemData()
{
	g_bItemsSyncing = true;
	g_iPaintCount = 0;
	g_iWeaponCount = 0;
	g_iMusicKitCount = 0;
	
	g_hItemsKv = CreateKeyValues("items_game");
	
	if (!FileToKeyValues(g_hItemsKv, "scripts/items/items_game_fixed.txt")) {
		Call_StartForward(g_hOnPluginEnd);
		Call_Finish();
		LogError("Unable to Process Item Schema");
		SetFailState("Unable to Process Item Schema");
	} KvRewind(g_hItemsKv);
	
	if (!KvJumpToKey(g_hItemsKv, "items") || !KvGotoFirstSubKey(g_hItemsKv, false)) {
		Call_StartForward(g_hOnPluginEnd);
		Call_Finish();
		LogError("Unable to find Item keyvalues");
		SetFailState("Unable to find Item keyvalues");
	}
	
	char szBuffer[48]; char szBuffer2[48]; char szBuffer3[48][48];
	
	do {
		KvGetString(g_hItemsKv, "name", szBuffer2, 48);
		KvGetString(g_hItemsKv, "prefab", szBuffer, 48);
		
		if (StrContains(szBuffer, "hands_paintable") == -1 && StrContains(szBuffer, "hands") == -1) {
			if (!IsValidWeaponClassName(szBuffer2)) {
				continue;
			}
			
			KvGetSectionName(g_hItemsKv, g_szWeaponInfo[g_iWeaponCount][DEFINDEX], 48);
			strcopy(g_szWeaponInfo[g_iWeaponCount][CLASSNAME], 48, szBuffer2);
			
			if (StrEqual(g_szWeaponInfo[g_iWeaponCount][CLASSNAME], "weapon_c4", false)) {
				g_szWeaponInfo[g_iWeaponCount][TEAM] = "2";
			}
			
			if (StrContains(szBuffer, "melee") != -1) {
				g_bIsDefIndexKnife[StringToInt(g_szWeaponInfo[g_iWeaponCount][DEFINDEX])] = true;
				
				if (StrContains(szBuffer, "unusual") != -1) {
					g_bIsDefIndexSkinnable[StringToInt(g_szWeaponInfo[g_iWeaponCount][DEFINDEX])] = true;
					g_szWeaponInfo[g_iWeaponCount][SLOT] = "melee";
				}
			}
			
			int iKillAward = -1;
			bool bKillAwardFound = GetWeaponKillAward(g_szWeaponInfo[g_iWeaponCount][CLASSNAME], g_szWeaponInfo[g_iWeaponCount][KILLAWARD], 48);
			
			if (bKillAwardFound) {
				iKillAward = StringToInt(g_szWeaponInfo[g_iWeaponCount][KILLAWARD]);
			}
			
			float fSpread = 0.0;
			bool bSpreadFound = GetWeaponSpread(g_szWeaponInfo[g_iWeaponCount][CLASSNAME], g_szWeaponInfo[g_iWeaponCount][SPREAD], 48);
			
			if (bSpreadFound) {
				fSpread = StringToFloat(g_szWeaponInfo[g_iWeaponCount][SPREAD]);
			}
			
			float fCycleTime = 0.0;
			bool bCycleTimeFound = GetWeaponCycleTime(g_szWeaponInfo[g_iWeaponCount][CLASSNAME], g_szWeaponInfo[g_iWeaponCount][CYCLETIME], 48);
			
			if (bCycleTimeFound) {
				fCycleTime = StringToFloat(g_szWeaponInfo[g_iWeaponCount][CYCLETIME]);
			}
			
			if (IsSpecialPrefab(szBuffer)) {
				KvGetString(g_hItemsKv, "item_name", szBuffer, 48);
				KvGetString(g_hItemsKv, "model_player", g_szWeaponInfo[g_iWeaponCount][VIEWMODEL], 48);
				KvGetString(g_hItemsKv, "model_world", g_szWeaponInfo[g_iWeaponCount][WORLDMODEL], 48);
			} else {
				KvGoBack(g_hItemsKv); KvGoBack(g_hItemsKv);
				
				if (KvJumpToKey(g_hItemsKv, "prefabs")) {
					
					if (KvJumpToKey(g_hItemsKv, szBuffer)) {
						KvGetString(g_hItemsKv, "prefab", g_szWeaponInfo[g_iWeaponCount][TYPE], 48);
						KvGetString(g_hItemsKv, "item_name", szBuffer, 48);
						KvGetString(g_hItemsKv, "model_player", g_szWeaponInfo[g_iWeaponCount][VIEWMODEL], 48);
						KvGetString(g_hItemsKv, "model_world", g_szWeaponInfo[g_iWeaponCount][WORLDMODEL], 48);
					}
					
					if (KvJumpToKey(g_hItemsKv, "used_by_classes")) {
						bool bTerrorist = KvGetNum(g_hItemsKv, "terrorists") == 1;
						bool bCounterTerrorist = KvGetNum(g_hItemsKv, "counter-terrorists") == 1;
						bool bBothTeams = bTerrorist && bCounterTerrorist;
						
						if (bBothTeams) {
							g_szWeaponInfo[g_iWeaponCount][TEAM] = "0";
						}
						
						else if (bTerrorist) {
							g_szWeaponInfo[g_iWeaponCount][TEAM] = "2";
						}
						
						else if (bCounterTerrorist) {
							g_szWeaponInfo[g_iWeaponCount][TEAM] = "3";
						}
						
						KvGoBack(g_hItemsKv);
					} else {
						g_szWeaponInfo[g_iWeaponCount][TEAM] = "0";
					}
					
					if (KvJumpToKey(g_hItemsKv, "attributes")) {
						int iClipAmmo = KvGetNum(g_hItemsKv, "primary clip size", -1);
						int iReserveAmmo = KvGetNum(g_hItemsKv, "primary reserve ammo max", -1);
						
						if (iKillAward <= -1 || !bKillAwardFound) {
							iKillAward = KvGetNum(g_hItemsKv, "kill award", -1);
						}
						
						if (fSpread <= 0.0 || !bSpreadFound) {
							fSpread = KvGetFloat(g_hItemsKv, "spread", 0.0);
						}
						
						if (fCycleTime <= 0.0 || !bCycleTimeFound) {
							fCycleTime = KvGetFloat(g_hItemsKv, "cycletime", 0.0);
						}
						
						if (iClipAmmo > 0) {
							IntToString(iClipAmmo, g_szWeaponInfo[g_iWeaponCount][CLIPAMMO], 48);
						} else {
							GetWeaponClip(g_szWeaponInfo[g_iWeaponCount][CLASSNAME], g_szWeaponInfo[g_iWeaponCount][CLIPAMMO], 48);
						}
						
						IntToString(iReserveAmmo, g_szWeaponInfo[g_iWeaponCount][RESERVEAMMO], 48);
						KvGoBack(g_hItemsKv);
					}
					
					KvGoBack(g_hItemsKv); KvGoBack(g_hItemsKv);
					
					if (KvJumpToKey(g_hItemsKv, "items")) {
						KvJumpToKey(g_hItemsKv, g_szWeaponInfo[g_iWeaponCount][DEFINDEX]);
					}
				}
			}
			
			if (iKillAward <= 0) {
				IntToString(300, g_szWeaponInfo[g_iWeaponCount][KILLAWARD], 48);
			} else {
				IntToString(iKillAward, g_szWeaponInfo[g_iWeaponCount][KILLAWARD], 48);
			}
			
			if (fSpread <= 0.0) {
				FloatToString(0.0, g_szWeaponInfo[g_iWeaponCount][SPREAD], 48);
			} else {
				FloatToString(fSpread, g_szWeaponInfo[g_iWeaponCount][SPREAD], 48);
			}
			
			if (fCycleTime <= 0.0) {
				FloatToString(0.0, g_szWeaponInfo[g_iWeaponCount][CYCLETIME], 48);
			} else {
				FloatToString(fCycleTime, g_szWeaponInfo[g_iWeaponCount][CYCLETIME], 48);
			}
			
			if (StrEqual(g_szWeaponInfo[g_iWeaponCount][CLIPAMMO], "", false)) {
				strcopy(g_szWeaponInfo[g_iWeaponCount][CLIPAMMO], 4, "-1");
			}
			
			if (StrEqual(g_szWeaponInfo[g_iWeaponCount][RESERVEAMMO], "", false)) {
				strcopy(g_szWeaponInfo[g_iWeaponCount][RESERVEAMMO], 4, "-1");
			}
			
			GetItemName(szBuffer, g_szWeaponInfo[g_iWeaponCount][DISPLAYNAME], 48);
			KvGetString(g_hItemsKv, "item_sub_position", szBuffer, 48);
			
			if (StrContains(szBuffer, "grenade") == -1 && StrContains(szBuffer, "equipment") == -1 && !StrEqual(szBuffer, "", false) && StrContains(szBuffer, "melee") == -1) {
				g_bIsDefIndexSkinnable[StringToInt(g_szWeaponInfo[g_iWeaponCount][DEFINDEX])] = true;
			}
			
			if (!StrEqual(szBuffer, "", false)) {
				strcopy(g_szWeaponInfo[g_iWeaponCount][SLOT], 48, szBuffer);
			}
			
			g_iWeaponCount++;
		} else {
			KvGetSectionName(g_hItemsKv, g_chGlovesInfo[g_iGlovesCount][DEFINDEX], 48);
			strcopy(g_chGlovesInfo[g_iGlovesCount][CLASSNAME], 48, szBuffer2);
			
			KvGetString(g_hItemsKv, "item_name", szBuffer, 48);
			GetItemName(szBuffer, g_chGlovesInfo[g_iGlovesCount][DISPLAYNAME], 48);
			KvGetString(g_hItemsKv, "model_player", g_chGlovesInfo[g_iGlovesCount][VIEWMODEL], 96);
			KvGetString(g_hItemsKv, "model_world", g_chGlovesInfo[g_iGlovesCount][WORLDMODEL], 96);
			
			g_iGlovesCount++;
		}
	} while (KvGotoNextKey(g_hItemsKv)); KvRewind(g_hItemsKv);
	
	if (!KvJumpToKey(g_hItemsKv, "paint_kits") || !KvGotoFirstSubKey(g_hItemsKv, false)) {
		Call_StartForward(g_hOnPluginEnd);
		Call_Finish();
		SetFailState("Unable to find Paintkit keyvalues");
	}
	
	do {
		KvGetSectionName(g_hItemsKv, szBuffer, 48); int iSkinDefIndex = StringToInt(szBuffer);
		
		if (iSkinDefIndex == 9001) {
			strcopy(szBuffer, 48, "1");
			iSkinDefIndex = 1;
		}
		
		strcopy(g_chPaintInfo[g_iPaintCount][DEFINDEX], 48, szBuffer);
		
		if (iSkinDefIndex == 0) {
			strcopy(g_chPaintInfo[g_iPaintCount][DISPLAYNAME], 48, "Default");
		} else if (iSkinDefIndex == 1) {
			strcopy(g_chPaintInfo[g_iPaintCount][DISPLAYNAME], 48, "Vanilla");
		} else {
			KvGetString(g_hItemsKv, "name", g_chPaintInfo[g_iPaintCount][ITEMNAME], 48);
			KvGetString(g_hItemsKv, "description_tag", szBuffer, 48);
			GetItemName(szBuffer, g_chPaintInfo[g_iPaintCount][DISPLAYNAME], 48);
		}
		
		KvGetString(g_hItemsKv, "vmt_path", g_chPaintInfo[g_iPaintCount][VMTPATH], 96);
		PrecacheMaterial(g_chPaintInfo[g_iPaintCount][VMTPATH]);
		
		g_bSkinNumGloveApplicable[g_iPaintCount] = StrContains(g_chPaintInfo[g_iPaintCount][VMTPATH], "paints_gloves", false) != -1;
		
		if (g_bSkinNumGloveApplicable[g_iPaintCount]) {
			g_iGlovesPaintCount++;
		}
		
		g_iPaintCount++;
		
	} while (KvGotoNextKey(g_hItemsKv)); KvRewind(g_hItemsKv);
	
	if (!KvJumpToKey(g_hItemsKv, "music_definitions") || !KvGotoFirstSubKey(g_hItemsKv, false)) {
		Call_StartForward(g_hOnPluginEnd);
		Call_Finish();
		SetFailState("Unable to find Music Kit keyvalues");
	}
	
	do {
		KvGetSectionName(g_hItemsKv, szBuffer, 48);
		int iMusicDefIndex = StringToInt(szBuffer);
		
		if (iMusicDefIndex < 3) {
			continue;
		}
		
		strcopy(g_chMusicKitInfo[g_iMusicKitCount][DEFINDEX], 48, szBuffer);
		KvGetString(g_hItemsKv, "loc_name", szBuffer2, 48);
		GetItemName(szBuffer2, g_chMusicKitInfo[g_iMusicKitCount][DISPLAYNAME], 48);
		
		g_iMusicKitCount++;
	} while (KvGotoNextKey(g_hItemsKv)); KvRewind(g_hItemsKv);
	
	if (!KvJumpToKey(g_hItemsKv, "item_sets") || !KvGotoFirstSubKey(g_hItemsKv, false)) {
		Call_StartForward(g_hOnPluginEnd);
		Call_Finish();
		SetFailState("Unable to find Item Sets keyvalues");
	}
	
	do {
		KvGetString(g_hItemsKv, "name", g_chItemSetInfo[g_iItemSetCount][CLASSNAME], 48);
		GetItemName(g_chItemSetInfo[g_iItemSetCount][CLASSNAME], g_chItemSetInfo[g_iItemSetCount][DISPLAYNAME], 48);
		
		if (KvJumpToKey(g_hItemsKv, "items")) {
			if (KvGotoFirstSubKey(g_hItemsKv, false)) {
				do {
					KvGetSectionName(g_hItemsKv, szBuffer, 48);
					ExplodeString(szBuffer, "]", szBuffer3, 48, 48); ReplaceString(szBuffer3[0], 48, "[", ""); ReplaceString(szBuffer3[1], 48, "]", "");
					
					CSGOItems_LoopSkins(iSkin) {
						if (StrEqual(szBuffer3[0], g_chPaintInfo[iSkin][ITEMNAME])) {
							g_bIsSkinInSet[g_iItemSetCount][iSkin] = true;
						}
					}
				}
				while (KvGotoNextKey(g_hItemsKv, false));
				KvGoBack(g_hItemsKv);
			}
		}
		KvGoBack(g_hItemsKv);
		g_iItemSetCount++;
	} while (KvGotoNextKey(g_hItemsKv)); KvRewind(g_hItemsKv);
	
	if (!KvJumpToKey(g_hItemsKv, "sticker_kits") || !KvGotoFirstSubKey(g_hItemsKv, false)) {
		Call_StartForward(g_hOnPluginEnd);
		Call_Finish();
		SetFailState("Unable to find Stickerkit keyvalues");
	}
	
	do {
		KvGetString(g_hItemsKv, "name", szBuffer, 48);
		
		if (StrContains(szBuffer, "spray", false) == -1) {
			continue;
		}
		
		KvGetString(g_hItemsKv, "sticker_material", szBuffer, 48);
		
		Format(g_chSprayInfo[g_iSprayCount][VTFPATH], PLATFORM_MAX_PATH, "decals/sprays/%s.vtf", szBuffer);
		
		KvGetString(g_hItemsKv, "item_name", szBuffer2, 48);
		
		if (StrEqual(szBuffer2, "#StickerKit_comm01_rekt", false)) {
			strcopy(g_chSprayInfo[g_iSprayCount][DISPLAYNAME], 48, "Rekt");
		} else {
			GetItemName(szBuffer2, g_chSprayInfo[g_iSprayCount][DISPLAYNAME], 48);
		}
		
		KvGetSectionName(g_hItemsKv, szBuffer2, 48);
		strcopy(g_chSprayInfo[g_iSprayCount][DEFINDEX], 48, szBuffer2);
		
		char szExplode[2][64]; ExplodeString(szBuffer, "/", szExplode, 2, 64);
		
		CreateSprayVMT(g_iSprayCount, szExplode[0], szExplode[1], g_chSprayInfo[g_iSprayCount][VTFPATH]);
		SafePrecacheDecal(g_chSprayInfo[g_iSprayCount][VTFPATH]);
		
		g_iSprayCount++;
		
	} while (KvGotoNextKey(g_hItemsKv)); CloseHandle(g_hItemsKv);
	
	CSGOItems_LoopSkins(iSkinNum) {
		CSGOItems_LoopGloves(iGlovesNum) {
			strcopy(szBuffer, 64, g_chGlovesInfo[iGlovesNum][CLASSNAME]);
			
			if (StrEqual(szBuffer, "leather_handwraps", false)) {
				strcopy(szBuffer, 64, "handwrap");
			} else {
				ReplaceString(szBuffer, 64, "_gloves", "", false);
				ReplaceString(szBuffer, 64, "studded_", "", false);
			}
			
			if (strlen(szBuffer) < 4) {
				continue;
			}
			
			if (StrContains(g_chPaintInfo[iSkinNum][ITEMNAME], szBuffer, false) != -1) {
				g_bIsNativeSkin[iSkinNum][iGlovesNum] = true;
			}
		}
	}
	
	Call_StartForward(g_hOnItemsSynced);
	Call_Finish();
	
	g_bItemsSynced = true;
	g_bItemsSyncing = false;
}

stock bool CreateSprayVMT(int iSprayNum, const char[] szDirectory, const char[] szFile, const char[] szTexturePath)
{
	char szFullDirectory[PLATFORM_MAX_PATH]; Format(szFullDirectory, PLATFORM_MAX_PATH, "materials/csgoitemsv2/sprays/%s", szDirectory);
	char szFullFile[PLATFORM_MAX_PATH]; Format(szFullFile, PLATFORM_MAX_PATH, "%s/%s.vmt", szFullDirectory, szFile);
	char szPieces[32][PLATFORM_MAX_PATH];
	char szPath[PLATFORM_MAX_PATH];
	char szTexturePathFormat[128];
	//char szOutFile[PLATFORM_MAX_PATH];
	
	int iNumPieces = ExplodeString(szFullDirectory, "/", szPieces, sizeof(szPieces), sizeof(szPieces[]));
	
	for (int i = 0; i < iNumPieces; i++) {
		Format(szPath, sizeof(szPath), "%s/%s", szPath, szPieces[i]);
		
		if (DirExists(szPath)) {
			continue;
		}
		
		CreateDirectory(szPath, 777);
	}
	
	if (!FileExists(szFullFile)) {
		File fFile = OpenFile(szFullFile, "w+");
		
		if (fFile == null) {
			return false;
		}
		
		Format(szTexturePathFormat, 128, "\"$basetexture\"	\"%s\"", szTexturePath);
		ReplaceString(szTexturePathFormat, 128, ".vtf", "", false);
		
		fFile.WriteLine("LightmappedGeneric");
		fFile.WriteLine("{");
		fFile.WriteLine(szTexturePathFormat);
		fFile.WriteLine("	\"$translucent\" \"1\"");
		fFile.WriteLine("	\"$decal\" \"1\"");
		fFile.WriteLine("	\"$mappingwidth\" \"48\"");
		fFile.WriteLine("	\"$mappingheight\" \"48\"");
		fFile.WriteLine("}");
		
		/*
		Format(szOutFile, PLATFORM_MAX_PATH, "%s.bz2", szFullFile);
		
		DataPack dPack = CreateDataPack();
		dPack.WriteString(szDirectory);
		dPack.Reset();
		
		BZ2_CompressFile(szFullFile, szOutFile, 9, Compressed_File);  
		*/
		CloseHandle(fFile);
	}
	
	Format(g_chSprayInfo[iSprayNum][VMTPATH], PLATFORM_MAX_PATH, szFullFile);
	
	return true;
}

/*
public int Compressed_File(BZ_Error iError, const char[] sIn, const char[] sOut, DataPack dPack) 
{
	dPack.Reset(); char szDirectory[PLATFORM_MAX_PATH]; dPack.ReadString(szDirectory, PLATFORM_MAX_PATH);
	delete dPack;
	
	if(iError == BZ_OK) {
		LogMessage("%s successfully compressed", sIn);
		EasyFTP_UploadFile("csgoitems", sOut, szDirectory, Uploaded_File);  
	} else {
		LogBZ2Error(iError);
	}
}

public int Uploaded_File(const char[] sTarget, const char[] sLocalFile, const char[] sRemoteFile, int iErrorCode, any data) 
{ 
    if(iErrorCode == 0) { 
        LogMessage("%s successfully uploaded", sLocalFile); 
    } else { 
        LogMessage("%s failed uploading", sLocalFile);   
    } 
}
*/

public void OnConfigsExecuted() {
	g_bSpraysEnabled = g_hCvarSpraysEnabled.BoolValue;
}

public void OnMapStart()
{
	if (!g_bItemsSynced || g_bItemsSyncing) {
		return;
	}
	
	CSGOItems_LoopSkins(iSkinNum) {
		PrecacheMaterial(g_chPaintInfo[iSkinNum][VMTPATH]);
	}
	
	if (g_bSpraysEnabled) {
		CSGOItems_LoopSprays(iSprayNum) {
			AddFileToDownloadsTable(g_chSprayInfo[iSprayNum][VMTPATH]);
			
			char szBuffer[PLATFORM_MAX_PATH]; strcopy(szBuffer, PLATFORM_MAX_PATH, g_chSprayInfo[iSprayNum][VMTPATH]);
			
			ReplaceString(szBuffer, PLATFORM_MAX_PATH, "materials/", "", false);
			ReplaceString(szBuffer, PLATFORM_MAX_PATH, ".vmt", "", false);
			
			PrecacheDecal(szBuffer);
			PrecacheMaterial(szBuffer);
		}
	}
}

public Action Event_PlayerDeath(Handle hEvent, const char[] szName, bool bDontBroadcast)
{
	int iClient = GetClientOfUserId(GetEventInt(hEvent, "userid"));
	
	g_bGivingWeapon[iClient] = false;
	
	return Plugin_Continue;
}

public void OnClientPutInServer(int iClient)
{
	SDKHook(iClient, SDKHook_WeaponEquip, OnWeaponEquip_Pre);
	SDKHook(iClient, SDKHook_WeaponEquipPost, OnWeaponEquip_Post);
}

public Action OnWeaponEquip_Pre(int iClient, int iWeapon)
{
	return Plugin_Continue;
}

public Action OnWeaponEquip_Post(int iClient, int iWeapon)
{
	return Plugin_Continue;
}

stock void GetItemName(char[] chPhrase, char[] szBuffer, int iLength)
{
	int iPos = StrContains(g_chLangPhrases, chPhrase[1], false);
	
	if (iPos == -1) {
		strcopy(szBuffer, iLength, "");
		return;
	}
	
	int iLen = strlen(chPhrase);
	
	iPos += iLen + 1;
	iPos += StrContains(g_chLangPhrases[iPos], "\"") + 1;
	iLen = StrContains(g_chLangPhrases[iPos], "\"") + 1;
	
	strcopy(szBuffer, iLen, g_chLangPhrases[iPos]);
}

stock void GetWeaponClip(char[] szClassName, char[] chReturn, int iLength)
{
	char szBuffer[128]; Format(szBuffer, 64, "scripts/%s.txt", szClassName);
	
	Handle hFile = OpenFile(szBuffer, "r");
	
	if (hFile == null) {
		strcopy(chReturn, iLength, "-1");
		return;
	}
	
	while (ReadFileLine(hFile, szBuffer, 128) && !IsEndOfFile(hFile)) {
		if (StrContains(szBuffer, "clip_size", false) != -1 && StrContains(szBuffer, "default", false) == -1) {
			ReplaceString(szBuffer, 128, "clip_size", "", false); ReplaceString(szBuffer, 128, "\"", "", false);
			TrimString(szBuffer); StripQuotes(szBuffer);
			strcopy(chReturn, iLength, szBuffer);
			break;
		}
	}
	
	if (StrEqual(chReturn, "", false) || StrEqual(chReturn, "0", false)) {
		strcopy(chReturn, iLength, "-1");
	}
	
	CloseHandle(hFile);
}

stock bool GetWeaponKillAward(char[] szClassName, char[] chReturn, int iLength)
{
	char szBuffer[128];
	
	if (CSGOItems_IsDefIndexKnife(CSGOItems_GetWeaponDefIndexByClassName(szClassName))) {
		Format(szBuffer, 64, "scripts/weapon_knife.txt", szClassName);
	} else {
		Format(szBuffer, 64, "scripts/%s.txt", szClassName);
	}
	
	Handle hFile = OpenFile(szBuffer, "r");
	
	if (hFile == null) {
		strcopy(chReturn, iLength, "-1");
		return false;
	}
	
	while (ReadFileLine(hFile, szBuffer, 128) && !IsEndOfFile(hFile)) {
		if (StrContains(szBuffer, "KillAward", false) != -1 && StrContains(szBuffer, "Weapon", false) == -1) {
			ReplaceString(szBuffer, 128, "KillAward", "", false); ReplaceString(szBuffer, 128, "\"", "", false);
			TrimString(szBuffer); StripQuotes(szBuffer);
			strcopy(chReturn, iLength, szBuffer);
			break;
		}
	}
	
	if (StrEqual(chReturn, "", false) || StrEqual(chReturn, "0", false)) {
		strcopy(chReturn, iLength, "-1");
		return false;
	}
	
	CloseHandle(hFile);
	return true;
}

stock bool GetWeaponSpread(char[] szClassName, char[] chReturn, int iLength)
{
	char szBuffer[128];
	
	if (CSGOItems_IsDefIndexKnife(CSGOItems_GetWeaponDefIndexByClassName(szClassName))) {
		Format(szBuffer, 64, "scripts/weapon_knife.txt", szClassName);
	} else {
		Format(szBuffer, 64, "scripts/%s.txt", szClassName);
	}
	
	Handle hFile = OpenFile(szBuffer, "r");
	
	if (hFile == null) {
		strcopy(chReturn, iLength, "0.0");
		return false;
	}
	
	while (ReadFileLine(hFile, szBuffer, 128) && !IsEndOfFile(hFile)) {
		if (StrContains(szBuffer, "Spread", false) != -1 && StrContains(szBuffer, "InaccuracyCrouch", false) == -1) {
			ReplaceString(szBuffer, 128, "Spread", "", false); ReplaceString(szBuffer, 128, "\"", "", false);
			TrimString(szBuffer); StripQuotes(szBuffer);
			strcopy(chReturn, iLength, szBuffer);
			break;
		}
	}
	
	if (StrEqual(chReturn, "", false) || StrEqual(chReturn, "0", false)) {
		strcopy(chReturn, iLength, "0.0");
		return false;
	}
	
	CloseHandle(hFile);
	return true;
}

stock bool GetWeaponCycleTime(char[] szClassName, char[] chReturn, int iLength)
{
	char szBuffer[128];
	
	if (CSGOItems_IsDefIndexKnife(CSGOItems_GetWeaponDefIndexByClassName(szClassName))) {
		Format(szBuffer, 64, "scripts/weapon_knife.txt", szClassName);
	} else {
		Format(szBuffer, 64, "scripts/%s.txt", szClassName);
	}
	
	Handle hFile = OpenFile(szBuffer, "r");
	
	if (hFile == null) {
		strcopy(chReturn, iLength, "0.0");
		return false;
	}
	
	while (ReadFileLine(hFile, szBuffer, 128) && !IsEndOfFile(hFile)) {
		if (StrContains(szBuffer, "CycleTime", false) != -1 && StrContains(szBuffer, "TimeToIdle", false) == -1) {
			ReplaceString(szBuffer, 128, "CycleTime", "", false); ReplaceString(szBuffer, 128, "\"", "", false);
			TrimString(szBuffer); StripQuotes(szBuffer);
			strcopy(chReturn, iLength, szBuffer);
			break;
		}
	}
	
	if (StrEqual(chReturn, "", false) || StrEqual(chReturn, "0", false)) {
		strcopy(chReturn, iLength, "0.0");
		return false;
	}
	
	CloseHandle(hFile);
	return true;
}

stock bool IsValidWeaponClassName(char[] szClassName)
{
	return StrContains(szClassName, "weapon_") != -1 && StrContains(szClassName, "base") == -1 && StrContains(szClassName, "case") == -1;
}

stock bool IsSpecialPrefab(char[] chPrefabName)
{
	return StrContains(chPrefabName, "_prefab") == -1;
}

stock bool IsValidClient(int iClient)
{
	if (iClient <= 0 || iClient > MaxClients) {
		return false;
	}
	
	return IsClientInGame(iClient);
}

stock int SlotNameToNum(const char[] chSlotName)
{
	if (StrContains(chSlotName, "rifle") != -1 || StrContains(chSlotName, "heavy") != -1 || StrContains(chSlotName, "smg") != -1) {
		return CS_SLOT_PRIMARY;
	}
	
	else if (StrContains(chSlotName, "secondary") != -1) {
		return CS_SLOT_SECONDARY;
	}
	
	else if (StrContains(chSlotName, "c4") != -1) {
		return CS_SLOT_C4;
	}
	
	else if (StrContains(chSlotName, "melee") != -1) {
		return CS_SLOT_KNIFE;
	}
	
	else if (StrContains(chSlotName, "grenade") != -1) {
		return CS_SLOT_GRENADE;
	}
	
	return -1;
}

public int Native_GetWeaponCount(Handle hPlugin, int iNumParams) {
	return g_iWeaponCount;
}

public int Native_GetSkinCount(Handle hPlugin, int iNumParams) {
	return g_iPaintCount;
}

public int Native_GetGlovesCount(Handle hPlugin, int iNumParams) {
	return g_iGlovesCount;
}

public int Native_GetSprayCount(Handle hPlugin, int iNumParams) {
	return g_iSprayCount;
}

public int Native_GetGlovesPaintCount(Handle hPlugin, int iNumParams) {
	return g_iGlovesPaintCount;
}

public int Native_GetMusicKitCount(Handle hPlugin, int iNumParams) {
	return g_iMusicKitCount;
}

public int Native_GetItemSetCount(Handle hPlugin, int iNumParams) {
	return g_iItemSetCount;
}

public int Native_GetWeaponNumByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return iWeaponNum;
		}
	}
	
	return -1;
}

public int Native_GetWeaponTeamByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][TEAM]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponTeamByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][TEAM]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponViewModelByWeaponNum(Handle hPlugin, int iNumParams)
{
	int iIndex = GetNativeCell(1);
	
	if (iIndex < 0 || iIndex > g_iWeaponCount) {
		return false;
	}
	
	if (StrEqual(g_szWeaponInfo[iIndex][VIEWMODEL], "", false)) {
		return false;
	}
	
	return SetNativeString(2, g_szWeaponInfo[iIndex][VIEWMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetWeaponViewModelByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			
			if (StrEqual(g_szWeaponInfo[iWeaponNum][VIEWMODEL], "", false)) {
				return false;
			}
			
			return SetNativeString(2, g_szWeaponInfo[iWeaponNum][VIEWMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetGlovesViewModelByGlovesNum(Handle hPlugin, int iNumParams)
{
	int iIndex = GetNativeCell(1);
	
	if (iIndex < 0 || iIndex > g_iGlovesCount) {
		return false;
	}
	
	if (StrEqual(g_chGlovesInfo[iIndex][VIEWMODEL], "", false)) {
		return false;
	}
	
	return SetNativeString(2, g_chGlovesInfo[iIndex][VIEWMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetGlovesViewModelByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopGloves(iGlovesNum) {
		if (StringToInt(g_chGlovesInfo[iGlovesNum][DEFINDEX]) == iDefIndex) {
			
			if (StrEqual(g_chGlovesInfo[iGlovesNum][VIEWMODEL], "", false)) {
				return false;
			}
			
			return SetNativeString(2, g_chGlovesInfo[iGlovesNum][VIEWMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetGlovesWorldModelByGlovesNum(Handle hPlugin, int iNumParams)
{
	int iIndex = GetNativeCell(1);
	
	if (iIndex < 0 || iIndex > g_iGlovesCount) {
		return false;
	}
	
	if (StrEqual(g_chGlovesInfo[iIndex][WORLDMODEL], "", false)) {
		return false;
	}
	
	return SetNativeString(2, g_chGlovesInfo[iIndex][WORLDMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetGlovesWorldModelByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopGloves(iGlovesNum) {
		if (StringToInt(g_chGlovesInfo[iGlovesNum][DEFINDEX]) == iDefIndex) {
			
			if (StrEqual(g_chGlovesInfo[iGlovesNum][WORLDMODEL], "", false)) {
				return false;
			}
			
			return SetNativeString(2, g_chGlovesInfo[iGlovesNum][WORLDMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetWeaponViewModelByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			
			if (StrEqual(g_szWeaponInfo[iWeaponNum][VIEWMODEL], "", false)) {
				return false;
			}
			
			return StringToInt(g_szWeaponInfo[iWeaponNum][VIEWMODEL]);
		}
	}
	
	return false;
}

public int Native_GetWeaponWorldModelByWeaponNum(Handle hPlugin, int iNumParams)
{
	int iIndex = GetNativeCell(1);
	
	if (iIndex < 0 || iIndex > g_iWeaponCount) {
		return false;
	}
	
	if (StrEqual(g_szWeaponInfo[iIndex][WORLDMODEL], "", false)) {
		return false;
	}
	
	return SetNativeString(2, g_szWeaponInfo[iIndex][WORLDMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetWeaponWorldModelByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			
			if (StrEqual(g_szWeaponInfo[iWeaponNum][WORLDMODEL], "", false)) {
				return false;
			}
			
			return SetNativeString(2, g_szWeaponInfo[iWeaponNum][WORLDMODEL], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetWeaponWorldModelByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			
			if (StrEqual(g_szWeaponInfo[iWeaponNum][WORLDMODEL], "", false)) {
				return false;
			}
			
			return StringToInt(g_szWeaponInfo[iWeaponNum][WORLDMODEL]);
		}
	}
	
	return false;
}

public int Native_GetWeaponTeamByWeaponNum(Handle hPlugin, int iNumParams)
{
	int iWeaponNum = GetNativeCell(1);
	
	return StringToInt(g_szWeaponInfo[iWeaponNum][TEAM]);
}

public int Native_GetWeaponClipAmmoByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][CLIPAMMO]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponClipAmmoByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][CLIPAMMO]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponClipAmmoByWeaponNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_szWeaponInfo[GetNativeCell(1)][CLIPAMMO]);
}

public int Native_GetWeaponKillAwardByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][KILLAWARD]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponKillAwardByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][KILLAWARD]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponKillAwardByWeaponNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_szWeaponInfo[GetNativeCell(1)][KILLAWARD]);
}

public int Native_GetWeaponSpreadByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return view_as<int>(StringToFloat(g_szWeaponInfo[iWeaponNum][SPREAD]));
		}
	}
	
	return view_as<int>(0.0);
}

public int Native_GetWeaponSpreadByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return view_as<int>(StringToFloat(g_szWeaponInfo[iWeaponNum][SPREAD]));
		}
	}
	
	return view_as<int>(0.0);
}

public int Native_GetWeaponSpreadByWeaponNum(Handle hPlugin, int iNumParams) {
	return view_as<int>(StringToFloat(g_szWeaponInfo[GetNativeCell(1)][SPREAD]));
}

public int Native_GetWeaponCycleTimeByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return view_as<int>(StringToFloat(g_szWeaponInfo[iWeaponNum][CYCLETIME]));
		}
	}
	
	return view_as<int>(0.0);
}

public int Native_GetWeaponCycleTimeByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return view_as<int>(StringToFloat(g_szWeaponInfo[iWeaponNum][CYCLETIME]));
		}
	}
	
	return view_as<int>(0.0);
}

public int Native_GetWeaponCycleTimeByWeaponNum(Handle hPlugin, int iNumParams) {
	return view_as<int>(StringToFloat(g_szWeaponInfo[GetNativeCell(1)][CYCLETIME]));
}

public int Native_GetWeaponReserveAmmoByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][RESERVEAMMO]);
		}
	}
	
	return view_as<int>(0.0);
}

public int Native_GetWeaponReserveAmmoByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][RESERVEAMMO]);
		}
	}
	
	return view_as<int>(0.0);
}

public int Native_GetWeaponReserveAmmoByWeaponNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_szWeaponInfo[GetNativeCell(1)][RESERVEAMMO]);
}

public int Native_SetWeaponAmmo(Handle hPlugin, int iNumParams)
{
	int iWeapon = GetNativeCell(1);
	int iReserveAmmo = GetNativeCell(2);
	int iClipAmmo = GetNativeCell(3);
	
	if (iReserveAmmo == -1 && iClipAmmo == -1) {
		return false;
	}
	
	if (!CSGOItems_IsValidWeapon(iWeapon)) {
		return false;
	}
	
	if (iReserveAmmo > -1) {
		SetEntProp(iWeapon, Prop_Send, "m_iPrimaryReserveAmmoCount", iReserveAmmo);
	}
	
	if (iClipAmmo > -1) {
		SetEntProp(iWeapon, Prop_Send, "m_iClip1", iClipAmmo);
	}
	
	return true;
}

public int Native_RefillClipAmmo(Handle hPlugin, int iNumParams)
{
	int iWeapon = GetNativeCell(1);
	int iDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			int iClipAmmo = StringToInt(g_szWeaponInfo[iWeaponNum][CLIPAMMO]);
			CSGOItems_SetWeaponAmmo(iWeapon, -1, iClipAmmo > 0 ? iClipAmmo : -1);
			return true;
		}
	}
	
	return false;
}

public int Native_RefillReserveAmmo(Handle hPlugin, int iNumParams)
{
	int iWeapon = GetNativeCell(1);
	int iDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			int iReserveAmmo = StringToInt(g_szWeaponInfo[iWeaponNum][RESERVEAMMO]);
			CSGOItems_SetWeaponAmmo(iWeapon, iReserveAmmo > 0 ? iReserveAmmo : -1, -1);
			return true;
		}
	}
	
	return false;
}

public int Native_GetWeaponNumByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return iWeaponNum;
		}
	}
	
	return -1;
}

public int Native_GetGlovesNumByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopGloves(iGlovesNum) {
		if (StrEqual(g_chGlovesInfo[iGlovesNum][CLASSNAME], szClassName, false)) {
			return iGlovesNum;
		}
	}
	
	return -1;
}

public int Native_GetSkinNumByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopSkins(iSkinNum) {
		if (StringToInt(g_chPaintInfo[iSkinNum][DEFINDEX]) == iDefIndex) {
			return iSkinNum;
		}
	}
	
	return -1;
}

public int Native_GetGlovesNumByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopGloves(iGlovesNum) {
		if (StringToInt(g_chGlovesInfo[iGlovesNum][DEFINDEX]) == iDefIndex) {
			return iGlovesNum;
		}
	}
	
	return -1;
}

public int Native_GetSprayNumByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopSprays(iSprayNum) {
		if (StringToInt(g_chSprayInfo[iSprayNum][DEFINDEX]) == iDefIndex) {
			return iSprayNum;
		}
	}
	
	return -1;
}

public int Native_GetMusicKitNumByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopMusicKits(iMusicKitNum) {
		if (StringToInt(g_chMusicKitInfo[iMusicKitNum][DEFINDEX]) == iDefIndex) {
			return iMusicKitNum;
		}
	}
	
	return -1;
}

public int Native_GetItemSetNumByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopItemSets(iSetNum) {
		if (StrEqual(g_chItemSetInfo[iSetNum][CLASSNAME], szClassName, false)) {
			return iSetNum;
		}
	}
	
	return -1;
}

public int Native_GetWeaponDefIndexByWeaponNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_szWeaponInfo[GetNativeCell(1)][DEFINDEX]);
}

public int Native_GetWeaponDefIndexByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]);
		}
	}
	
	return -1;
}

public int Native_GetSkinDefIndexBySkinNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_chPaintInfo[GetNativeCell(1)][DEFINDEX]);
}

public int Native_GetGlovesDefIndexByGlovesNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_chGlovesInfo[GetNativeCell(1)][DEFINDEX]);
}

public int Native_GetSprayDefIndexBySprayNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_chSprayInfo[GetNativeCell(1)][DEFINDEX]);
}

public int Native_GetMusicKitDefIndexByMusicKitNum(Handle hPlugin, int iNumParams) {
	return StringToInt(g_chMusicKitInfo[GetNativeCell(1)][DEFINDEX]);
}

public int Native_GetWeaponClassNameByWeaponNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_szWeaponInfo[GetNativeCell(1)][CLASSNAME], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetWeaponClassNameByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_szWeaponInfo[iWeaponNum][CLASSNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetWeaponDisplayNameByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_szWeaponInfo[iWeaponNum][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetSkinDisplayNameByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopSkins(iSkinNum) {
		if (StringToInt(g_chPaintInfo[iSkinNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_chPaintInfo[iSkinNum][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetSprayDisplayNameByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopSprays(iSprayNum) {
		if (StringToInt(g_chSprayInfo[iSprayNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_chSprayInfo[iSprayNum][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetSprayVMTByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopSprays(iSprayNum) {
		if (StringToInt(g_chSprayInfo[iSprayNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_chSprayInfo[iSprayNum][VMTPATH], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetSprayVTFByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopSprays(iSprayNum) {
		if (StringToInt(g_chSprayInfo[iSprayNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_chSprayInfo[iSprayNum][VTFPATH], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetSprayDisplayNameBySprayNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chSprayInfo[GetNativeCell(1)][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetSprayVMTBySprayNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chSprayInfo[GetNativeCell(1)][VMTPATH], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetSprayCacheIndexBySprayNum(Handle hPlugin, int iNumParams)
{
	char szBuffer[PLATFORM_MAX_PATH];
	strcopy(szBuffer, PLATFORM_MAX_PATH, g_chSprayInfo[GetNativeCell(1)][VMTPATH]);
	
	ReplaceString(szBuffer, PLATFORM_MAX_PATH, "materials/", "", false);
	ReplaceString(szBuffer, PLATFORM_MAX_PATH, ".vmt", "", false);
	
	PrecacheMaterial(szBuffer);
	return SafePrecacheDecal(szBuffer);
}

public int Native_GetSprayVTFBySprayNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chSprayInfo[GetNativeCell(1)][VTFPATH], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetSprayCacheIndexByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopSprays(iSprayNum) {
		if (StringToInt(g_chSprayInfo[iSprayNum][DEFINDEX]) == iDefIndex) {
			char szBuffer[PLATFORM_MAX_PATH]; strcopy(szBuffer, PLATFORM_MAX_PATH, g_chSprayInfo[iSprayNum][VMTPATH]);
			
			ReplaceString(szBuffer, PLATFORM_MAX_PATH, "materials/", "", false);
			ReplaceString(szBuffer, PLATFORM_MAX_PATH, ".vmt", "", false);
			
			PrecacheMaterial(szBuffer);
			return SafePrecacheDecal(szBuffer);
		}
	}
	
	return -1;
}

public int Native_GetGlovesDisplayNameByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopGloves(iGlovesNum) {
		if (StringToInt(g_chGlovesInfo[iGlovesNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_chGlovesInfo[iGlovesNum][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetWeaponDisplayNameByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return SetNativeString(2, g_szWeaponInfo[iWeaponNum][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetMusicKitDisplayNameByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopMusicKits(iMusicKitNum) {
		if (StringToInt(g_chMusicKitInfo[iMusicKitNum][DEFINDEX]) == iDefIndex) {
			return SetNativeString(2, g_chMusicKitInfo[iMusicKitNum][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetItemSetDisplayNameByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopItemSets(iSetNum) {
		if (StrEqual(g_chItemSetInfo[iSetNum][CLASSNAME], szClassName, false)) {
			return SetNativeString(2, g_chItemSetInfo[iSetNum][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
		}
	}
	
	return false;
}

public int Native_GetWeaponDisplayNameByWeaponNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_szWeaponInfo[GetNativeCell(1)][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetSkinDisplayNameBySkinNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chPaintInfo[GetNativeCell(1)][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetSkinVmtPathBySkinNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chPaintInfo[GetNativeCell(1)][VMTPATH], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_IsNativeSkin(Handle hPlugin, int iNumParams)
{
	int iSkinNum = GetNativeCell(1);
	int iItemNum = GetNativeCell(2);
	
	return g_bIsNativeSkin[iSkinNum][iItemNum];
}

public int Native_GetGlovesDisplayNameByGlovesNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chGlovesInfo[GetNativeCell(1)][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetMusicKitDisplayNameByMusicKitNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chMusicKitInfo[GetNativeCell(1)][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_GetItemSetDisplayNameByItemSetNum(Handle hPlugin, int iNumParams) {
	return SetNativeString(2, g_chItemSetInfo[GetNativeCell(1)][DISPLAYNAME], GetNativeCell(3)) == SP_ERROR_NONE;
}

public int Native_IsDefIndexKnife(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	if (iDefIndex <= -1 || iDefIndex > 700) {
		if (iDefIndex > 700) {
			LogError("Warning: DefIndxes may be going higher than 700 now.");
		}
		
		return false;
	}
	
	return g_bIsDefIndexKnife[iDefIndex];
}

public int Native_GetActiveClassName(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	int iWeaponDefIndex = CSGOItems_GetActiveWeaponDefIndex(iClient);
	
	char szWeaponClassName[48];
	
	if (CSGOItems_GetWeaponClassNameByDefIndex(iWeaponDefIndex, szWeaponClassName, 48)) {
		return SetNativeString(2, szWeaponClassName, GetNativeCell(3)) == SP_ERROR_NONE;
	}
	
	return false;
}

public int Native_GetActiveWeaponDefIndex(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	
	if (!IsPlayerAlive(iClient)) {
		return -1;
	}
	
	int iActiveWeapon = CSGOItems_GetActiveWeapon(iClient);
	
	return CSGOItems_GetWeaponDefIndexByWeapon(iActiveWeapon);
}

public int Native_GetActiveWeaponNum(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	int iActiveWeaponDefIndex = CSGOItems_GetActiveWeaponDefIndex(iClient);
	
	return CSGOItems_GetWeaponNumByDefIndex(iActiveWeaponDefIndex);
}

public int Native_GetActiveWeapon(Handle hPlugin, int iNumParams) {
	return GetEntPropEnt(GetNativeCell(1), Prop_Send, "m_hActiveWeapon");
}

public int Native_GetWeaponDefIndexByWeapon(Handle hPlugin, int iNumParams)
{
	int iWeapon = GetNativeCell(1);
	
	if (!CSGOItems_IsValidWeapon(iWeapon)) {
		return -1;
	}
	
	return GetEntProp(iWeapon, Prop_Send, "m_iItemDefinitionIndex");
}

public int Native_IsSkinnableDefIndex(Handle hPlugin, int iNumParams) {
	int iWeaponDefIndex = GetNativeCell(1);
	
	if (iWeaponDefIndex <= -1 || iWeaponDefIndex > 700) {
		
		if (iWeaponDefIndex > 700) {
			LogError("Warning: DefIndxes may be going higher than 700 now.");
		}
		
		return false;
	}
	
	return g_bIsDefIndexSkinnable[iWeaponDefIndex];
}

public int Native_IsSkinNumGloveApplicable(Handle hPlugin, int iNumParams) {
	return g_bSkinNumGloveApplicable[GetNativeCell(1)];
}

public int Native_FindWeaponByClassName(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	char szClassName[48]; GetNativeString(2, szClassName, sizeof(szClassName));
	char szBuffer[48]; char szBuffer2[48];
	
	int iOriginalDefIndex = CSGOItems_GetWeaponDefIndexByClassName(szClassName);
	int iDefIndex2 = 0;
	int iDefIndex3 = 0;
	
	int iWeaponArraySize = GetEntPropArraySize(iClient, Prop_Send, "m_hMyWeapons");
	
	for (int i = 0; i < iWeaponArraySize; i++) {
		int iWeapon = GetEntPropEnt(iClient, Prop_Send, "m_hMyWeapons", i);
		
		if (!CSGOItems_IsValidWeapon(iWeapon)) {
			continue;
		}
		
		CSGOItems_GetWeaponClassNameByWeapon(iWeapon, szBuffer, 48); iDefIndex2 = CSGOItems_GetWeaponDefIndexByClassName(szBuffer);
		GetEntityClassname(iWeapon, szBuffer2, 48); iDefIndex3 = CSGOItems_GetWeaponDefIndexByClassName(szBuffer2);
		
		if (CSGOItems_IsDefIndexKnife(iOriginalDefIndex) && (CSGOItems_IsDefIndexKnife(iDefIndex2) || CSGOItems_IsDefIndexKnife(iDefIndex3))) {
			return iWeapon;
		}
		
		if (StrEqual(szClassName, szBuffer, false) || StrEqual(szClassName, szBuffer2, false)) {
			return iWeapon;
		}
	}
	
	return -1;
}

public int Native_GetWeaponSlotByWeaponNum(Handle hPlugin, int iNumParams) {
	return SlotNameToNum(g_szWeaponInfo[GetNativeCell(1)][SLOT]);
}

public int Native_GetWeaponSlotByDefIndex(Handle hPlugin, int iNumParams)
{
	int iDefIndex = GetNativeCell(1);
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StringToInt(g_szWeaponInfo[iWeaponNum][DEFINDEX]) == iDefIndex) {
			return SlotNameToNum(g_szWeaponInfo[iWeaponNum][SLOT]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponSlotByClassName(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	CSGOItems_LoopWeapons(iWeaponNum) {
		if (StrEqual(g_szWeaponInfo[iWeaponNum][CLASSNAME], szClassName, false)) {
			return SlotNameToNum(g_szWeaponInfo[iWeaponNum][SLOT]);
		}
	}
	
	return -1;
}

public int Native_GetWeaponClassNameByWeapon(Handle hPlugin, int iNumParams)
{
	int iWeapon = GetNativeCell(1);
	
	if (!CSGOItems_IsValidWeapon(iWeapon)) {
		return false;
	}
	
	int iWeaponDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
	char szWeaponClassName[48];
	
	if (CSGOItems_GetWeaponClassNameByDefIndex(iWeaponDefIndex, szWeaponClassName, 48)) {
		return SetNativeString(2, szWeaponClassName, GetNativeCell(3)) == SP_ERROR_NONE;
	}
	
	return false;
}

public int Native_IsValidWeapon(Handle hPlugin, int iNumParams)
{
	int iWeapon = GetNativeCell(1);
	
	if (!IsValidEntity(iWeapon) || !IsValidEdict(iWeapon) || iWeapon == -1) {
		return false;
	}
	
	if (!HasEntProp(iWeapon, Prop_Send, "m_hOwnerEntity")) {
		return false;
	}
	
	char szWeapon[48]; GetEdictClassname(iWeapon, szWeapon, sizeof(szWeapon));
	
	return IsValidWeaponClassName(szWeapon);
}

public int Native_GiveWeapon(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	
	char szClassName[48]; GetNativeString(2, szClassName, sizeof(szClassName));
	
	int iReserveAmmo = GetNativeCell(3);
	int iClipAmmo = GetNativeCell(4);
	int iSwitchTo = GetNativeCell(5);
	
	int iClientTeam = GetClientTeam(iClient);
	
	if (iClientTeam < 2 || iClientTeam > 3 || !IsPlayerAlive(iClient)) {
		return -1;
	}
	
	int iViewSequence = GetEntProp(GetEntPropEnt(iClient, Prop_Send, "m_hViewModel"), Prop_Send, "m_nSequence");
	
	if (!IsValidWeaponClassName(szClassName)) {
		return -1;
	}
	
	int iWeaponTeam = CSGOItems_GetWeaponTeamByClassName(szClassName);
	int iWeaponNum = CSGOItems_GetWeaponNumByClassName(szClassName);
	int iWeaponDefIndex = -1;
	int iLookingAtWeapon = GetEntProp(iClient, Prop_Send, "m_bIsLookingAtWeapon");
	int iHoldingLookAtWeapon = GetEntProp(iClient, Prop_Send, "m_bIsHoldingLookAtWeapon");
	int iReloadVisuallyComplete = -1;
	int iWeaponSilencer = -1;
	int iWeaponMode = -1;
	int iRecoilIndex = -1;
	int iIronSightMode = -1;
	int iZoomLevel = -1;
	int iCurrentWeapon = GetPlayerWeaponSlot(iClient, CSGOItems_GetWeaponSlotByClassName(szClassName));
	int iHudFlags = GetEntProp(iClient, Prop_Send, "m_iHideHUD");
	
	float fNextPlayerAttackTime = GetEntPropFloat(iClient, Prop_Send, "m_flNextAttack");
	float fDoneSwitchingSilencer = 0.0;
	float fNextPrimaryAttack = 0.0;
	float fNextSecondaryAttack = 0.0;
	float fTimeWeaponIdle = 0.0;
	float fAccuracyPenalty = 0.0;
	float fLastShotTime = 0.0;
	
	char szCurrentClassName[48];
	bool bKnife = false;
	
	if (CSGOItems_IsValidWeapon(iCurrentWeapon)) {
		CSGOItems_GetWeaponClassNameByWeapon(iCurrentWeapon, szCurrentClassName, 48);
		iWeaponDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iCurrentWeapon);
		
		if (HasEntProp(iCurrentWeapon, Prop_Send, "m_flNextPrimaryAttack")) {
			fNextPrimaryAttack = GetEntPropFloat(iCurrentWeapon, Prop_Send, "m_flNextPrimaryAttack");
		}
		
		if (HasEntProp(iCurrentWeapon, Prop_Send, "m_flNextSecondaryAttack")) {
			fNextSecondaryAttack = GetEntPropFloat(iCurrentWeapon, Prop_Send, "m_flNextSecondaryAttack");
		}
		
		if (HasEntProp(iCurrentWeapon, Prop_Send, "m_flTimeWeaponIdle")) {
			fTimeWeaponIdle = GetEntPropFloat(iCurrentWeapon, Prop_Send, "m_flTimeWeaponIdle");
		}
		
		if (HasEntProp(iCurrentWeapon, Prop_Send, "m_fAccuracyPenalty")) {
			fAccuracyPenalty = GetEntPropFloat(iCurrentWeapon, Prop_Send, "m_fAccuracyPenalty");
		}
		
		bKnife = CSGOItems_IsDefIndexKnife(iWeaponDefIndex);
		
		if (!bKnife) {
			if (HasEntProp(iCurrentWeapon, Prop_Send, "m_bReloadVisuallyComplete")) {
				iReloadVisuallyComplete = GetEntProp(iCurrentWeapon, Prop_Send, "m_bReloadVisuallyComplete");
			}
			if (HasEntProp(iCurrentWeapon, Prop_Send, "m_bSilencerOn")) {
				iWeaponSilencer = GetEntProp(iCurrentWeapon, Prop_Send, "m_bSilencerOn");
			}
			if (HasEntProp(iCurrentWeapon, Prop_Send, "m_weaponMode")) {
				iWeaponMode = GetEntProp(iCurrentWeapon, Prop_Send, "m_weaponMode");
			}
			if (HasEntProp(iCurrentWeapon, Prop_Send, "m_iRecoilIndex")) {
				iRecoilIndex = GetEntProp(iCurrentWeapon, Prop_Send, "m_iRecoilIndex");
			}
			if (HasEntProp(iCurrentWeapon, Prop_Send, "m_iIronSightMode")) {
				iIronSightMode = GetEntProp(iCurrentWeapon, Prop_Send, "m_iIronSightMode");
			}
			if (HasEntProp(iCurrentWeapon, Prop_Send, "m_flDoneSwitchingSilencer")) {
				fDoneSwitchingSilencer = GetEntPropFloat(iCurrentWeapon, Prop_Send, "m_flDoneSwitchingSilencer");
			}
			if (HasEntProp(iCurrentWeapon, Prop_Send, "m_fLastShotTime")) {
				fLastShotTime = GetEntPropFloat(iCurrentWeapon, Prop_Send, "m_fLastShotTime");
			}
			
			if (StrEqual(g_szWeaponInfo[CSGOItems_GetWeaponNumByClassName(szCurrentClassName)][TYPE], "sniper_rifle", false) && HasEntProp(iCurrentWeapon, Prop_Send, "m_zoomLevel")) {
				iZoomLevel = GetEntProp(iCurrentWeapon, Prop_Send, "m_zoomLevel");
			}
			
			if (!CSGOItems_RemoveWeapon(iClient, iCurrentWeapon)) {
				g_bGivingWeapon[iClient] = false;
				return -1;
			}
		} else if (!CSGOItems_RemoveKnife(iClient)) {
			g_bGivingWeapon[iClient] = false;
			return -1;
		}
	} else {
		bKnife = CSGOItems_IsDefIndexKnife(CSGOItems_GetWeaponDefIndexByClassName(szClassName));
	}
	
	if (iClientTeam != iWeaponTeam && iWeaponTeam > 1) {
		SetEntProp(iClient, Prop_Send, "m_iTeamNum", iWeaponTeam);
	}
	
	g_bGivingWeapon[iClient] = true;
	
	int iWeapon = -1;
	
	if (bKnife) {
		if (iClientTeam == CS_TEAM_T) {
			strcopy(szClassName, 48, "weapon_knife_t");
		} else if (iClientTeam == CS_TEAM_CT) {
			strcopy(szClassName, 48, "weapon_knife");
		}
	}
	
	iWeapon = GivePlayerItem(iClient, szClassName);
	
	if (!CSGOItems_IsValidWeapon(iWeapon)) {
		g_bGivingWeapon[iClient] = false;
		
		if (iWeapon != -1 && IsValidEdict(iWeapon) && IsValidEntity(iWeapon)) {
			int iWorldModel = GetEntPropEnt(iWeapon, Prop_Send, "m_hWeaponWorldModel");
			
			if (iWorldModel != -1 && IsValidEdict(iWorldModel) && IsValidEntity(iWorldModel)) {
				if (!AcceptEntityInput(iWorldModel, "Kill")) {
					return -1;
				}
			}
			
			if (!AcceptEntityInput(iWeapon, "Kill")) {
				return -1;
			}
		}
		
		return -1;
	}
	
	iWeaponDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
	iWeaponNum = CSGOItems_GetWeaponNumByDefIndex(iWeaponDefIndex);
	
	bool bSniper = StrEqual(g_szWeaponInfo[iWeaponNum][TYPE], "sniper_rifle", false);
	
	if (bKnife) {
		EquipPlayerWeapon(iClient, iWeapon);
	} else {
		CSGOItems_SetWeaponAmmo(iWeapon, iReserveAmmo, iClipAmmo);
	}
	
	int iSwitchWeapon = -1;
	
	if (iSwitchTo > -1 && iSwitchTo <= 4) {
		iSwitchWeapon = GetPlayerWeaponSlot(iClient, iSwitchTo);
		
		if (CSGOItems_IsValidWeapon(iSwitchWeapon)) {
			CSGOItems_SetActiveWeapon(iClient, iSwitchWeapon);
		}
	}
	
	if (iWeaponTeam > 1 && GetClientTeam(iClient) != iClientTeam) {
		SetEntProp(iClient, Prop_Send, "m_iTeamNum", iClientTeam);
	}
	
	int iActiveWeapon = CSGOItems_GetActiveWeapon(iClient);
	
	if (StrEqual(szClassName, szCurrentClassName, false) && iActiveWeapon == iWeapon && iSwitchWeapon == iWeapon) {
		if (iLookingAtWeapon > -1) {
			SetEntProp(iClient, Prop_Send, "m_bIsLookingAtWeapon", iLookingAtWeapon);
		}
		
		if (iHoldingLookAtWeapon > -1) {
			SetEntProp(iClient, Prop_Send, "m_bIsHoldingLookAtWeapon", iHoldingLookAtWeapon);
		}
		
		if (fNextPlayerAttackTime > 0.0) {
			SetEntPropFloat(iClient, Prop_Send, "m_flNextAttack", fNextPlayerAttackTime);
		}
		
		if (fNextPrimaryAttack > 0.0) {
			SetEntPropFloat(iWeapon, Prop_Send, "m_flNextPrimaryAttack", fNextPrimaryAttack);
		}
		
		if (fNextSecondaryAttack > 0.0) {
			SetEntPropFloat(iWeapon, Prop_Send, "m_flNextSecondaryAttack", fNextSecondaryAttack);
		}
		
		if (fTimeWeaponIdle > 0.0) {
			SetEntPropFloat(iWeapon, Prop_Send, "m_flTimeWeaponIdle", fTimeWeaponIdle);
		}
		
		if (fAccuracyPenalty > 0.0) {
			SetEntPropFloat(iWeapon, Prop_Send, "m_fAccuracyPenalty", fAccuracyPenalty);
		}
		
		if (fDoneSwitchingSilencer > 0.0) {
			SetEntPropFloat(iWeapon, Prop_Send, "m_flDoneSwitchingSilencer", fDoneSwitchingSilencer);
		}
		
		if (fLastShotTime > 0.0) {
			SetEntPropFloat(iWeapon, Prop_Send, "m_fLastShotTime", fLastShotTime);
		}
		
		if (iReloadVisuallyComplete > -1) {
			SetEntProp(iWeapon, Prop_Send, "m_bReloadVisuallyComplete", iReloadVisuallyComplete);
		}
		
		if (iWeaponSilencer > -1) {
			SetEntProp(iWeapon, Prop_Send, "m_bSilencerOn", iWeaponSilencer);
		}
		
		if (iWeaponMode > -1) {
			SetEntProp(iWeapon, Prop_Send, "m_weaponMode", iWeaponMode);
		}
		
		if (iRecoilIndex > -1) {
			SetEntProp(iWeapon, Prop_Send, "m_iRecoilIndex", iRecoilIndex);
		}
		
		if (iIronSightMode > -1) {
			SetEntProp(iWeapon, Prop_Send, "m_iIronSightMode", iIronSightMode);
		}
		
		if (iZoomLevel > -1 && bSniper) {
			SetEntProp(iWeapon, Prop_Send, "m_zoomLevel", iZoomLevel);
		}
	}
	
	else if (iActiveWeapon == iWeapon && iSwitchWeapon == iWeapon) {
		if (bKnife) {
			iViewSequence = 2;
		} else {
			iViewSequence = 0;
		}
		
		int iViewSequences = sizeof(g_chViewSequence1);
		
		for (int i = 0; i < iViewSequences; i++) {
			if (!StrEqual(szClassName, g_chViewSequence1[i], false)) {
				continue;
			}
			
			iViewSequence = 1;
			break;
		}
	}
	
	if (iActiveWeapon == iWeapon) {
		SetEntProp(GetEntPropEnt(iClient, Prop_Send, "m_hViewModel"), Prop_Send, "m_nSequence", iViewSequence);
	}
	
	SetEntProp(iClient, Prop_Send, "m_iHideHUD", iHudFlags);
	
	g_bGivingWeapon[iClient] = false;
	
	Call_StartForward(g_hOnWeaponGiven);
	Call_PushCell(iClient);
	Call_PushCell(iWeapon);
	Call_PushString(szClassName);
	Call_PushCell(iWeaponDefIndex);
	Call_PushCell(CSGOItems_GetWeaponSlotByDefIndex(iWeaponDefIndex));
	Call_PushCell(CSGOItems_IsSkinnableDefIndex(iWeaponDefIndex));
	Call_PushCell(bKnife);
	Call_Finish();
	
	return iWeapon;
}

public int Native_RemoveWeapon(Handle hPlugin, int iNumParams)
{
	if (g_bRoundEnd) {
		return false;
	}
	
	int iClient = GetNativeCell(1);
	int iWeapon = GetNativeCell(2);
	
	if (!CSGOItems_IsValidWeapon(iWeapon) || !IsPlayerAlive(iClient)) {
		return false;
	}
	
	if (g_bGivingWeapon[iClient]) {
		return false;
	}
	
	int iDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
	int iWeaponSlot = CSGOItems_GetWeaponSlotByDefIndex(iDefIndex);
	
	if (HasEntProp(iWeapon, Prop_Send, "m_bInitialized")) {
		if (GetEntProp(iWeapon, Prop_Send, "m_bInitialized") == 0) {
			return false;
		}
	}
	
	if (HasEntProp(iWeapon, Prop_Send, "m_bStartedArming")) {
		if (GetEntSendPropOffs(iWeapon, "m_bStartedArming") != -1) {
			return false;
		}
	}
	
	if (GetPlayerWeaponSlot(iClient, iWeaponSlot) != iWeapon) {
		return false;
	}
	
	// int iWeaponArraySize = GetEntPropArraySize(iClient, Prop_Send, "m_hMyWeapons");
	
	if (!CSGOItems_DropWeapon(iClient, iWeapon)) {
		return false;
		/*
		for (int i = 0; i < iWeaponArraySize; i++) {
			if(iWeapon == GetEntPropEnt(iClient, Prop_Send, "m_hMyWeapons", i)) {
				SetEntPropEnt(iClient, Prop_Send, "m_hMyWeapons", -1, i);
				break;
			}
		} */
	}
	
	int iWorldModel = GetEntPropEnt(iWeapon, Prop_Send, "m_hWeaponWorldModel");
	
	if (IsValidEdict(iWorldModel) && IsValidEntity(iWorldModel)) {
		if (!AcceptEntityInput(iWorldModel, "Kill")) {
			return false;
		}
	}
	
	if (!AcceptEntityInput(iWeapon, "Kill")) {
		return false;
	}
	
	return true;
}

public int Native_DropWeapon(Handle hPlugin, int iNumParams)
{
	if (g_bRoundEnd) {
		return false;
	}
	
	int iClient = GetNativeCell(1);
	int iWeapon = GetNativeCell(2);
	
	if (!CSGOItems_IsValidWeapon(iWeapon) || !IsPlayerAlive(iClient)) {
		return false;
	}
	
	if (g_bGivingWeapon[iClient]) {
		return false;
	}
	
	int iDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
	int iWeaponSlot = CSGOItems_GetWeaponSlotByDefIndex(iDefIndex);
	
	if (HasEntProp(iWeapon, Prop_Send, "m_bInitialized")) {
		if (GetEntProp(iWeapon, Prop_Send, "m_bInitialized") == 0) {
			return false;
		}
	}
	
	if (HasEntProp(iWeapon, Prop_Send, "m_bStartedArming")) {
		if (GetEntSendPropOffs(iWeapon, "m_bStartedArming") != -1) {
			return false;
		}
	}
	
	if (GetPlayerWeaponSlot(iClient, iWeaponSlot) != iWeapon) {
		return false;
	}
	
	int iHudFlags = GetEntProp(iClient, Prop_Send, "m_iHideHUD");
	int iOwnerEntity = GetEntPropEnt(iWeapon, Prop_Send, "m_hOwnerEntity");
	
	if (iOwnerEntity != iClient) {
		SetEntPropEnt(iWeapon, Prop_Send, "m_hOwnerEntity", iClient);
	}
	
	CS_DropWeapon(iClient, iWeapon, false);
	
	if (iOwnerEntity != iClient) {
		SetEntPropEnt(iWeapon, Prop_Send, "m_hOwnerEntity", iOwnerEntity);
	}
	
	SetEntProp(iClient, Prop_Send, "m_iHideHUD", iHudFlags);
	
	return true;
}

public int Native_RemoveAllWeapons(Handle hPlugin, int iNumParams)
{
	if (g_bRoundEnd) {
		return false;
	}
	
	int iClient = GetNativeCell(1);
	int iSkipSlot = GetNativeCell(2);
	
	int iRemovedWeapons = 0;
	int iWeaponArraySize = GetEntPropArraySize(iClient, Prop_Send, "m_hMyWeapons");
	
	for (int i = 0; i < iWeaponArraySize; i++) {
		int iWeapon = GetEntPropEnt(iClient, Prop_Send, "m_hMyWeapons", i);
		
		if (!CSGOItems_IsValidWeapon(iWeapon)) {
			continue;
		}
		
		int iDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
		int iWeaponSlot = CSGOItems_GetWeaponSlotByDefIndex(iDefIndex);
		
		if (iWeaponSlot == iSkipSlot && iSkipSlot != -1) {
			continue;
		}
		
		if (CSGOItems_RemoveWeapon(iClient, iWeapon)) {
			iRemovedWeapons++;
		}
	}
	
	return iRemovedWeapons;
}

public int Native_SetActiveWeapon(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	int iWeapon = GetNativeCell(2);
	
	if (!CSGOItems_IsValidWeapon(iWeapon) || !IsPlayerAlive(iClient)) {
		return false;
	}
	
	int iDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
	int iWeaponSlot = CSGOItems_GetWeaponSlotByDefIndex(iDefIndex);
	
	if (GetPlayerWeaponSlot(iClient, iWeaponSlot) != iWeapon) {
		return false;
	}
	
	int iHudFlags = GetEntProp(iClient, Prop_Send, "m_iHideHUD");
	
	char szWeapon[48]; GetEntityClassname(iWeapon, szWeapon, 48);
	
	FakeClientCommandEx(iClient, "use %s", szWeapon);
	SDKCall(g_hSwitchWeaponCall, iClient, iWeapon, 0);
	SetEntPropEnt(iClient, Prop_Send, "m_hActiveWeapon", iWeapon);
	SetEntProp(iClient, Prop_Send, "m_iHideHUD", iHudFlags);
	
	return true;
}

public int Native_AreItemsSynced(Handle hPlugin, int iNumParams) {
	return g_bItemsSynced;
}

public int Native_AreItemsSyncing(Handle hPlugin, int iNumParams) {
	return g_bItemsSyncing;
}

public int Native_Resync(Handle hPlugin, int iNumParams) {
	return RetrieveLanguage();
}

public int Native_GetActiveWeaponSlot(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	
	if (!IsPlayerAlive(iClient)) {
		return -1;
	}
	
	CSGOItems_LoopWeaponSlots(iSlot) {
		if (GetPlayerWeaponSlot(iClient, iSlot) == CSGOItems_GetActiveWeapon(iClient)) {
			return iSlot;
		}
	}
	
	return -1;
}

public int Native_RemoveKnife(Handle hPlugin, int iNumParams)
{
	int iClient = GetNativeCell(1);
	
	int iWeaponArraySize = GetEntPropArraySize(iClient, Prop_Send, "m_hMyWeapons");
	
	for (int i = 0; i < iWeaponArraySize; i++) {
		int iWeapon = GetEntPropEnt(iClient, Prop_Send, "m_hMyWeapons", i);
		
		if (!CSGOItems_IsValidWeapon(iWeapon)) {
			continue;
		}
		
		int iDefIndex = CSGOItems_GetWeaponDefIndexByWeapon(iWeapon);
		
		if (!CSGOItems_IsDefIndexKnife(iDefIndex)) {
			continue;
		}
		
		return CSGOItems_RemoveWeapon(iClient, iWeapon);
	}
	
	return false;
}

public int Native_GetActiveWeaponCount(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	
	int iTeam = GetNativeCell(2);
	int iCount = 0;
	int iWeaponSlot = CSGOItems_GetWeaponSlotByClassName(szClassName);
	
	if (iWeaponSlot <= -1) {
		return 0;
	}
	
	CSGOItems_LoopValidClients(iClient) {
		if (iTeam < 2 || iTeam > 3 || GetClientTeam(iClient) != iTeam) {
			continue;
		}
		
		if (CSGOItems_FindWeaponByClassName(iClient, szClassName) == -1) {
			continue;
		}
		
		iCount++;
	}
	
	return iCount;
}

public int Native_SetAllWeaponsAmmo(Handle hPlugin, int iNumParams)
{
	char szClassName[48]; char szBuffer[48]; GetNativeString(1, szClassName, sizeof(szClassName));
	int iReserveAmmo = GetNativeCell(2);
	int iClipAmmo = GetNativeCell(3);
	
	CSGOItems_LoopValidWeapons(iWeapon) {
		CSGOItems_GetWeaponClassNameByWeapon(iWeapon, szBuffer, 48);
		
		if (!StrEqual(szClassName, szBuffer, false)) {
			continue;
		}
		
		CSGOItems_SetWeaponAmmo(iWeapon, iReserveAmmo, iClipAmmo);
	}
}

public int Native_GetRandomSkin(Handle hPlugin, int iNumParams) {
	return StringToInt(g_chPaintInfo[GetRandomInt(1, g_iPaintCount)][DEFINDEX]);
}

stock int PrecacheMaterial(const char[] szMaterial)
{
	if (StrEqual(szMaterial, "", false || strlen(szMaterial) <= 0)) {
		return INVALID_STRING_INDEX;
	}
	
	static int materialNames = INVALID_STRING_TABLE;
	
	if (materialNames == INVALID_STRING_TABLE) {
		if ((materialNames = FindStringTable("Materials")) == INVALID_STRING_TABLE) {
			return INVALID_STRING_INDEX;
		}
	}
	
	int index = FindStringIndex2(materialNames, szMaterial);
	
	if (index == INVALID_STRING_INDEX) {
		int numStrings = GetStringTableNumStrings(materialNames);
		
		if (numStrings >= GetStringTableMaxStrings(materialNames)) {
			return INVALID_STRING_INDEX;
		}
		
		AddToStringTable(materialNames, szMaterial);
		index = numStrings;
	}
	
	return index;
}

stock int SafePrecacheModel(char[] szModel, bool bPreLoad = false)
{
	TrimString(szModel); StripQuotes(szModel);
	
	if (StrEqual(szModel, "", false || strlen(szModel) <= 0)) {
		return -1;
	}
	
	return PrecacheModel(szModel, bPreLoad);
}

stock int SafePrecacheDecal(char[] szModel, bool bPreLoad = false)
{
	TrimString(szModel); StripQuotes(szModel);
	
	if (StrEqual(szModel, "", false || strlen(szModel) <= 0)) {
		return -1;
	}
	
	return PrecacheDecal(szModel, bPreLoad);
}

stock int FindStringIndex2(int tableidx, const char[] str)
{
	char buf[1024];
	
	int numStrings = GetStringTableNumStrings(tableidx);
	for (int i = 0; i < numStrings; i++) {
		ReadStringTable(tableidx, i, buf, sizeof(buf));
		
		if (StrEqual(buf, str)) {
			return i;
		}
	}
	
	return INVALID_STRING_INDEX;
} 