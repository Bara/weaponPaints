#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <csgoitems>
#include <clientprefs>

#include <multicolors>

#pragma newdecls required

#define KNIFE_LENGTH 128
#define KNIFE_FLAG 32

bool g_bDebug = true;

char g_sConfig[PLATFORM_MAX_PATH + 1] = "";

public Plugin myinfo = 
{
	name = "Knifes",
	author = "Bara",
	description = "",
	version = "1.0.0",
	url = "github.com/Bara20/weaponPaints"
};

public void OnPluginStart()
{
	BuildPath(Path_SM, g_sConfig, sizeof(g_sConfig), "configs/paints.cfg");
	
	if(CSGOItems_AreItemsSynced())
	{
		UpdatePaintsConfig();
	}
}

public void CSGOItems_OnItemsSynced()
{
	UpdatePaintsConfig();
}

void UpdatePaintsConfig()
{
	KeyValues kvConf = new KeyValues("Paints");
	
	if (!kvConf.ImportFromFile(g_sConfig))
	{
		ThrowError("Can' find or read the file %s...", g_sConfig);
		return;
	}
	
	for (int i = 0; i <= CSGOItems_GetSkinCount(); i++)
	{
		int defIndex = CSGOItems_GetSkinDefIndexBySkinNum(i);
		
		char sDisplay[KNIFE_LENGTH], sDefIndex[12];
		CSGOItems_GetSkinDisplayNameByDefIndex(defIndex, sDisplay, sizeof(sDisplay));
		IntToString(defIndex, sDefIndex, sizeof(sDefIndex));
		
		bool bFound = false;
		
		bFound = kvConf.JumpToKey(sDefIndex, false);
		
		if (g_bDebug && !bFound)
		{
			kvConf.JumpToKey(sDefIndex, true);
			kvConf.SetString("name", sDisplay);
			
			LogMessage("Skin %s [%d] added!", sDisplay, defIndex);
		}
		
		kvConf.Rewind();
	}
	
	kvConf.ExportToFile(g_sConfig);
	delete kvConf;
}
