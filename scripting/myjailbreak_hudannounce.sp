#include <sourcemod>
#include <warden>
#include <mystocks>
#include <myjailbreak>
#include <hosties>
#include <lastrequest>

// CVARs to enable the HUD Options
Handle g_newhud_events_enable = INVALID_HANDLE;

#pragma newdecls required

public Plugin myinfo = 
{
	name = "[MyJailbreak] New HUD Announcer",
	author = "Hallucinogenic Troll",
	description = "Some bonus that can be given to an warden",
	version = "1.0",
	url = "http://PTFun.net/newsite/"
};

public void OnPluginStart()
{
	g_newhud_events_enable = CreateConVar("sm_newhud_events_enable", "1", "Enables the New HUD features to announce events", _, true, 0.0, true, 1.0);
	
	AutoExecConfig(true, "sm_newhud_events");
}

public void MyJailbreak_OnEventDayStart (char[] EventDayName)
{
	if(g_newhud_events_enable)
	{
		char Message[256];
		Format(Message, 256, "The %s is activated", EventDayName);
		for (int i = 0; i <= MaxClients; i++)
		{
			if(IsValidClient(i, false, true))
			{
				ShowNewHud(i, 0, 255, 0, Message);
			}
		}
	}
}

public void MyJailbreak_OnEventDayEnd (char[] EventDayName, int winner)
{
	if(g_newhud_events_enable)
	{
		char Message[256];
		Format(Message, 256, "The %s is desactivated", EventDayName);
		for (int i = 0; i <= MaxClients; i++)
		{
			if(IsValidClient(i, false, true))
			{
				ShowNewHud(i, 255, 0, 0, Message);
			}
		}
	}
}

stock void ShowNewHud(int client, int red, int green, int blue, char[] message) 
{ 
	SetHudTextParams(0.35, 0.125, 5.0, red, green, blue, 255, 0, 0.25, 1.5, 0.5);
	ShowHudText(client, 5, message);
}