/*

	TODO: Add spam protection (every X seconds X changes)
	TODO: Add config (Config Loader?)
	TODO: Add option to rename weapon
	
*/


#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <csgoitems>
#include <clientprefs>
#include <multicolors>

#pragma newdecls required

bool g_bDebug = true;
bool g_bFlagCheck = false;
bool g_bDontAddGloves = false;
bool g_bChangeC4 = false;
bool g_bChangeGrenade = false;
bool g_bShowAsOfficialDS = true;
bool g_bShowKnifeSeedMessage = true;

bool g_bReady[MAXPLAYERS + 1] =  { false, ... };

char g_sConfig[PLATFORM_MAX_PATH + 1] = "";

Database g_dDB = null;

KeyValues g_kvConf = null;

// int g_iWeaponPSite[MAXPLAYERS + 1] =  { 0, ... };

#define WP_COMMUNITYID 32
#define WP_CLASSNAME 32
#define WP_DISPLAY 128
#define WP_FLAG 18

#define DEFAULT_WEAR 0.0001
#define DEFAULT_SEED 0
#define DEFAULT_QUALITY 3
#define DEFAULT_FLAG ""

enum paintsCache
{
	String:pC_sCommunityID[32],
	String:pC_sClassName[32],
	pC_iDefIndex,
	Float:pC_fWear,
	pC_iSeed,
	pC_iQuality,
	String:pC_sFlag
};

int g_iCache[paintsCache];
ArrayList g_aCache = null;

#include "weaponPaints/sql.sp"
#include "weaponPaints/setSkin.sp"
#include "weaponPaints/current.sp"
#include "weaponPaints/weapon.sp"
#include "weaponPaints/wear.sp"
#include "weaponPaints/seed.sp"

public Plugin myinfo = 
{
	name = "Weapon Paints",
	author = "Bara",
	description = "",
	version = "1.0.0",
	url = "github.com/Bara20/weaponPaints"
};

public void OnPluginStart()
{
	BuildPath(Path_SM, g_sConfig, sizeof(g_sConfig), "configs/paints.cfg");
	
	g_kvConf = new KeyValues("Paints");
	
	if (!g_kvConf.ImportFromFile(g_sConfig))
	{
		ThrowError("Can' find or read the file %s...", g_sConfig);
		return;
	}
	
	RegConsoleCmd("sm_ws", Command_WS);
	
	if (g_aCache != null)
		g_aCache.Clear();
	
	g_aCache = new ArrayList(sizeof(g_iCache));
	
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientValid(i))
		{
			OnClientPutInServer(i);
		}
	}
	
	if (CSGOItems_AreItemsSynced())
	{
		UpdatePaintsConfig();
	}
}

public void OnConfigsExecuted()
{
	if (g_bShowAsOfficialDS)
	{
		GameRules_SetProp("m_bIsValveDS", 1); // But we can report the server as false inventory... 
		GameRules_SetProp("m_bIsQuestEligible", 1); // Do we need this?
	}
}

public void OnClientPutInServer(int client)
{
	SDKHook(client, SDKHook_WeaponEquipPost, OnWeaponEquipPost);
}

public void OnClientPostAdminCheck(int client)
{
	if(IsClientValid(client) && CSGOItems_AreItemsSynced())
	{
		LoadClientPaints(client);
	}
}

public void OnClientDisconnect(int client)
{
	if (g_aCache != null)
	{
		char sCommunityID[WP_COMMUNITYID];
		
		if (!GetClientAuthId(client, AuthId_SteamID64, sCommunityID, sizeof(sCommunityID)))
		{
			LogError("Auth failed for client index %d", client);
			return;
		}
		
		for (int i = 0; i < g_aCache.Length; i++)
		{
			int iCache[paintsCache];
			g_aCache.GetArray(i, iCache[0]);
			
			if (StrEqual(sCommunityID, iCache[pC_sCommunityID], true))
			{
				g_aCache.Erase(i);
			}
		}
	}
}

public void OnWeaponEquipPost(int client, int weapon)
{
	if (CSGOItems_IsValidWeapon(weapon))
	{
		int iDef = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex"); // TRIGGER BAN?
		
		char sClass[WP_CLASSNAME];
		CSGOItems_GetWeaponClassNameByDefIndex(iDef, sClass, sizeof(sClass));
		
		if (g_aCache != null)
		{
			for (int i = 0; i < g_aCache.Length; i++)
			{
				int iCache[paintsCache];
				g_aCache.GetArray(i, iCache[0]);
				
				char sCommunityID[WP_COMMUNITYID];
				
				if (!GetClientAuthId(client, AuthId_SteamID64, sCommunityID, sizeof(sCommunityID)))
				{
					LogError("Auth failed for client index %d", client);
					return;
				}
				
				if (StrEqual(sCommunityID, iCache[pC_sCommunityID], true) && StrEqual(sClass, iCache[pC_sClassName], true))
				{
					if (g_bDebug)
					{
						LogMessage("[OnWeaponEquipPost] Player: \"%L\" - CommunityID/cCommunityID: %s/%s - Classname/cClassname: %s/%s - DefIndex: %d - Wear: %.4f - Seed: %d - Quality: %d", client, sCommunityID, iCache[pC_sCommunityID], sClass, iCache[pC_sClassName], iCache[pC_iDefIndex], iCache[pC_fWear], iCache[pC_iSeed], iCache[pC_iQuality]);
					}
					
					if (g_bFlagCheck)
					{
						char sFlag[32], sdSkin[WP_DISPLAY], sdWeapon[WP_CLASSNAME];
						GetSkinFlag(iDef, sFlag, sizeof(sFlag));
						CSGOItems_GetWeaponDisplayNameByDefIndex(iDef, sdWeapon, sizeof(sdWeapon));
						CSGOItems_GetSkinDisplayNameByDefIndex(iCache[pC_iDefIndex], sdSkin, sizeof(sdSkin));
						
						if (!HasFlags(client, sFlag))
						{
							if (g_bDebug)
							{
								PrintToChat(client, "Sie haben für den Skin (%s | %s) nicht mehr die Berechtigung!", sdWeapon, sdSkin);
								break;
							}
						}
					}
					
					SetEntProp(weapon, Prop_Send, "m_iItemIDLow", -1);
					SetEntProp(weapon, Prop_Send, "m_nFallbackPaintKit", iCache[pC_iDefIndex]);
					SetEntPropFloat(weapon, Prop_Send, "m_flFallbackWear", iCache[pC_fWear]);
					SetEntProp(weapon, Prop_Send, "m_nFallbackSeed", iCache[pC_iSeed]);
					SetEntProp(weapon, Prop_Send, "m_iEntityQuality", iCache[pC_iQuality]);
					
					if (g_bDebug)
					{
						LogMessage("[OnWeaponEquipPost (Equal)] Player: \"%L\" - Skin Index: %d", client, iCache[pC_iDefIndex]);
					}
					
					break;
				}
			}
		}
	}
}

public void CSGOItems_OnItemsSynced()
{
	UpdatePaintsConfig();
}

public Action Command_WS(int client, int args)
{
	Menu menu = new Menu(Menu_PaintsMain);
	
	menu.SetTitle("Wähle eine Kategorie:");
	menu.AddItem("current", "Skin der aktuellen Waffe ändern");
	menu.AddItem("weapon", "Skin einer Waffe ändern");
	menu.AddItem("wear", "Wear anpassen");
	menu.AddItem("seed", "Seed anpassen");
	menu.ExitButton = true;
	
	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_PaintsMain(Menu menu, MenuAction action, int client, int param)
{
	if (action == MenuAction_Select)
	{
		char sParam[32];
		menu.GetItem(param, sParam, sizeof(sParam));
		
		if (StrEqual(sParam, "current", false))
		{
			ChooseCurrentWeapon(client);
		}
		else if (StrEqual(sParam, "weapon", false))
		{
			ChooseWeaponMenu(client);
		}
		else if (StrEqual(sParam, "wear", false))
		{
			ChangeWearMenu(client);
		}
		else if (StrEqual(sParam, "seed", false))
		{
			ChangeSeedMenu(client);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

void UpdatePaintsConfig()
{
	for (int i = 0; i <= CSGOItems_GetSkinCount(); i++)
	{
		int defIndex = CSGOItems_GetSkinDefIndexBySkinNum(i);
		
		if (!g_bDontAddGloves && defIndex >= 10000)
		{
			continue;
		}
		
		char sDisplay[WP_DISPLAY], sDefIndex[12];
		CSGOItems_GetSkinDisplayNameByDefIndex(defIndex, sDisplay, sizeof(sDisplay));
		IntToString(defIndex, sDefIndex, sizeof(sDefIndex));
		
		bool bFound = false;
		
		bFound = g_kvConf.JumpToKey(sDefIndex, false);
		
		if (!bFound)
		{
			g_kvConf.JumpToKey(sDefIndex, true);
			g_kvConf.SetString("name", sDisplay);
			
			LogMessage("Skin %s [%d] added!", sDisplay, defIndex);
		}
		
		g_kvConf.Rewind();
	}
	
	g_kvConf.ExportToFile(g_sConfig);
	
	if (SQL_CheckConfig("weaponPaints"))
	{
		SQL_TConnect(OnSQLConnect, "weaponPaints");
	}
	else
	{
		SetFailState("Can't find an entry in your databases.cfg with the name \"weaponPaints\"");
		return;
	}
}

bool IsClientValid(int client)
{
	if (client > 0 && client <= MaxClients)
	{
		if(IsClientInGame(client) && !IsFakeClient(client) && !IsClientSourceTV(client))
		{
			return true;
		}
	}
	
	return false;
}

bool HasFlags(int client, char[] flags)
{
	if(strlen(flags) == 0)
	{
		return true;
	}
	
	int iFlags = GetUserFlagBits(client);
	
	if (iFlags & ADMFLAG_ROOT)
	{
		return true;
	}
	
	AdminFlag aFlags[16];
	FlagBitsToArray(ReadFlagString(flags), aFlags, sizeof(aFlags));
	
	for (int i = 0; i < sizeof(aFlags); i++)
	{
		if (iFlags & FlagToBit(aFlags[i]))
		{
			return true;
		}
	}
	
	return false;
}

void UpdateClientMySQL(int client, const char[] sClass, int defIndex, float fWear, int iSeed, int iQuality)
{
	char sFlag[WP_FLAG];
	
	if(GetSkinFlag(defIndex, sFlag, sizeof(sFlag)))
	{
		if (g_aCache != null)
		{
			char sCommunityID[WP_COMMUNITYID];
			
			if (!GetClientAuthId(client, AuthId_SteamID64, sCommunityID, sizeof(sCommunityID)))
			{
				LogError("Auth failed for client index %d", client);
				return;
			}
			
			char sQuery[2048];
			Format(sQuery, sizeof(sQuery), "INSERT INTO weaponPaints (communityid, classname, defindex, wear, seed, quality, flag) VALUES (\"%s\", \"%s\", '%d', %.4f, '%d', '%d', \"%s\") ON DUPLICATE KEY UPDATE  defindex = '%d', wear = %.4f, seed = '%d', quality = '%d', flag = \"%s\";", sCommunityID, sClass, defIndex, fWear, iSeed, iQuality, sFlag, defIndex, fWear, iSeed, iQuality, sFlag);
			
			if (g_bDebug)
			{
				LogMessage(sQuery);
			}
			
			g_dDB.Query(OnUpdateClientArray, sQuery);
		}
	}
}

public void OnUpdateClientArray(Database db, DBResultSet results, const char[] error, any data)
{
	if (db == null || strlen(error) > 0)
	{
		SetFailState("(OnUpdateClientArray) Fail at Query: %s", error);
		return;
	}
}

void UpdateClientArray(int client, const char[] sClass, int defIndex, float fWear, int iSeed, int iQuality)
{
	char sFlag[WP_FLAG];
	
	if(GetSkinFlag(defIndex, sFlag, sizeof(sFlag)))
	{
		if (g_dDB != null)
		{
			char sCommunityID[WP_COMMUNITYID];
			
			if (!GetClientAuthId(client, AuthId_SteamID64, sCommunityID, sizeof(sCommunityID)))
			{
				LogError("Auth failed for client index %d", client);
				return;
			}
			
			// Remove current/old array entry
			for (int i = 0; i < g_aCache.Length; i++)
			{
				int iCache[paintsCache];
				g_aCache.GetArray(i, iCache[0]);
				
				if (StrEqual(sCommunityID, iCache[pC_sCommunityID], true) && StrEqual(sClass, iCache[pC_sClassName], true))
				{
					if (g_bDebug)
					{
						LogMessage("[UpdateClientArray] Player: \"%L\" - CommunityID: %s - Classname: %s - DefIndex: %d - Wear: %.4f - Seed: %d - Quality: %d", client, iCache[pC_sCommunityID], iCache[pC_sClassName], iCache[pC_iDefIndex], iCache[pC_fWear], iCache[pC_iSeed], iCache[pC_iQuality]);
					}
					
					g_aCache.Erase(i);
					break;
				}
			}
			
			// Insert new array entry
			int tmpCache[paintsCache];
			strcopy(tmpCache[pC_sCommunityID], WP_COMMUNITYID, sCommunityID);
			strcopy(tmpCache[pC_sClassName], WP_CLASSNAME, sClass);
			tmpCache[pC_iDefIndex] = defIndex;
			tmpCache[pC_fWear] = fWear;
			tmpCache[pC_iSeed] = iSeed;
			tmpCache[pC_iQuality] = iQuality;
			strcopy(tmpCache[pC_sFlag], WP_CLASSNAME, sFlag);
			g_aCache.PushArray(tmpCache[0]);
		}
	}
}

bool GetSkinFlag(int defIndex, char[] flag, int size)
{
	
	char sDefIndex[12];
	IntToString(defIndex, sDefIndex, sizeof(sDefIndex));
	
	bool bFound = false;
	
	bFound = g_kvConf.JumpToKey(sDefIndex, false);
	
	if (g_kvConf)
	{
		g_kvConf.GetString("flag", flag, size, DEFAULT_FLAG); // TODO: Add cvar for default flag
	}
	
	g_kvConf.Rewind();
	
	return bFound;
}

bool IsValidWeapon(int client, int defIndex, bool message = false)
{
	if (defIndex == 0)
	{
		return false;
	}
	else if (defIndex == 42 || defIndex == 59)
	{
		if (message)
		{
			PrintToChat(client, "You can't change the skin/seed for default knifes!");
		}
		
		return false;
	}
	else if (defIndex == 49)
	{
		if (!g_bChangeC4)
		{
			if (message)
			{
				PrintToChat(client, "You can't change the skin/seed for c4!");
			}
		
			return false;
		}
	}
	else if (defIndex >= 43 && defIndex <= 48)
	{
		if (!g_bChangeGrenade)
		{
			if (message)
			{
				PrintToChat(client, "You can't change the skin/seed for c4!");
			}
		
			return false;
		}
	}
	
	return true;
}

void AddWeaponSkinsToMenu(Menu menu, int client, int weapon = -1)
{
	for (int i = 0; i <= CSGOItems_GetSkinCount(); i++)
	{
		int defIndex = CSGOItems_GetSkinDefIndexBySkinNum(i);
		
		char sDefIndex[12], sDisplay[WP_DISPLAY], sFlag[WP_FLAG];
		IntToString(defIndex, sDefIndex, sizeof(sDefIndex));
		
		bool bFound = g_kvConf.JumpToKey(sDefIndex, false);
		
		if (bFound)
		{
			g_kvConf.GetString("name", sDisplay, sizeof(sDisplay));
			g_kvConf.GetString("flag", sFlag, sizeof(sFlag));
			
			int isDef = GetEntProp(weapon, Prop_Send, "m_nFallbackPaintKit");
			
			if(defIndex != isDef && (strlen(sFlag) == 0 || (strlen(sFlag) > 0 && HasFlags(client, sFlag))))
			{
				menu.AddItem(sDefIndex, sDisplay);
			}
			else
			{
				menu.AddItem(sDefIndex, sDisplay, ITEMDRAW_DISABLED);
			}
		}
		
		g_kvConf.Rewind();
	}
}
