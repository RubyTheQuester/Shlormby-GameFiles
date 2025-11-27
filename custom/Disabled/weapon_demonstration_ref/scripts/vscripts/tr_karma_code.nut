//FUTURE IDEAS:
//Recharge Medigun
//Partner taunts
//Delete all packs
//Clear ragdolls check

//REMOVE CRIT PUMPKINS IN HALLOWEEN. Thanks to LizardofOz for the script: https://tf2maps.net/downloads/no-crit-pumpkins.15892/
CRUMPKIN_INDEX <- PrecacheModel("models/props_halloween/pumpkin_loot.mdl");
CRUMPKIN_COND <- Constants.ETFCond.TF_COND_CRITBOOSTED_PUMPKIN;
MAX_PLAYERS <- MaxClients().tointeger();
GetPropInt <- ::NetProps.GetPropInt.bindenv(::NetProps);
FindByClassname <- ::Entities.FindByClassname.bindenv(::Entities);

function Think()
{
    local crumpkins = [];

    for (local tf_ammo_pack = null; tf_ammo_pack = FindByClassname(tf_ammo_pack, "tf_ammo_pack");)
        if (GetPropInt(tf_ammo_pack, "m_nModelIndex") == CRUMPKIN_INDEX)
            crumpkins.push(tf_ammo_pack);

    foreach(crumpkin in crumpkins)
        crumpkin.Kill();

    for (local i = 1; i <= MAX_PLAYERS; i++)
    {
        local player = PlayerInstanceFromIndex(i);
        if (player)
            player.RemoveCond(CRUMPKIN_COND);
    }

    return 0;
}
//

//CONVARS FOR DEMONSTRATION PURPOSES
function demoConvars()
{
    Convars.SetValue("mp_autoteambalance",0)
    Convars.SetValue("mp_teams_unbalance_limit",0)
    Convars.SetValue("tf_tournament_hide_domination_icons",1)
    Convars.SetValue("tf_weapon_criticals",0)
    Convars.SetValue("tf_use_fixed_weaponspreads",1)
    Convars.SetValue("tf_fall_damage_disablespread",1)
    Convars.SetValue("mp_disable_respawn_times",1)
    Convars.SetValue("mp_timelimit",0)
    Convars.SetValue("mp_waitingforplayers_cancel",1)
    Convars.SetValue("mp_holiday_nogifts", 1) //No Smissmas/holiday gifts
}

ClearGameEventCallbacks()

function OnGameEvent_player_say(data)
{
    local ply = GetPlayerFromUserID(data.userid) //the player
	local plyname = NetProps.GetPropString(ply,"m_szNetname").tostring() //Name of the player
    ///////////////////////////////////////////////////
    ////////////// GENERAL COMMANDS ///////////////////
    ///////////////////////////////////////////////////
    ////Command help
    if (data.text.tolower() == "!help")
    {
        ClientPrint(ply, 3, "\x07FFFF66List of commands:")
        ClientPrint(ply, 3, "\x07FFFF66!demo   Enable demonstration server settings")
        ClientPrint(ply, 3, "\x07FFFF66!c      Toggle crits")
        ClientPrint(ply, 3, "\x07FFFF66!n      Toggle noclip")
        ClientPrint(ply, 3, "\x07FFFF66!r      Regenerate yourself")
        ClientPrint(ply, 3, "\x07FFFF66!p      Command to spawn ammo and health packs")
        ClientPrint(ply, 3, "\x07FFFF66!clear  Clear ragdolls and weapons on ground")
        return
    }      
    ////Enable demonstration settings. You should always enable this for demonst.
    if (data.text.tolower() == "!demo")
    {
        demoConvars()
        ClientPrint(null, 3, "\x07FFFF66Demonstrations server settings enabled")
        return
    }
    ////Noclip toggle
	if (data.text.tolower() == "!n")
	{
        if (ply.GetMoveType() != 8)
        {
            ply.SetMoveType(8, 0)
            ClientPrint(null, 3, "\x07FFFF66Noclip enabled for " + plyname)
            return
        }
        else
        {
            ply.SetMoveType(2, 0)
            ClientPrint(null, 3, "\x07FFFF66Noclip disabled for " + plyname)
            return
        }
    }
    ////Regenerate the player
    if (data.text.tolower() == "!r")
    {
        ply.Regenerate(true)
        printl("TR_KARMA: Regenerated")
        return
    }
    ////AMMO AND HEALTH PACKS
            ////Spawn large ammo pack
            if (data.text.tolower() == "!p al")
            {
                local tabletemp = {
                    start = ply.EyePosition()
                    end = ply.EyePosition() + ply.EyeAngles().Forward() * 8192.0
                    ignore = ply
                }
                TraceLineEx(tabletemp)
                local tabletemp2 = {
                    origin = tabletemp.pos
                }
                SpawnEntityFromTable("item_ammopack_full", tabletemp2)
                return
            }
            ////Spawn large health pack
            if (data.text.tolower() == "!p hl")
            {
                local tabletemp = {
                    start = ply.EyePosition()
                    end = ply.EyePosition() + ply.EyeAngles().Forward() * 8192.0
                    ignore = ply
                }
                TraceLineEx(tabletemp)
                local tabletemp2 = {
                    origin = tabletemp.pos
                }
                SpawnEntityFromTable("item_healthkit_full", tabletemp2)
                return
            }    
            ////Spawn medium ammo pack
            if (data.text.tolower() == "!p am")
            {
                local tabletemp = {
                    start = ply.EyePosition()
                    end = ply.EyePosition() + ply.EyeAngles().Forward() * 8192.0
                    ignore = ply
                }
                TraceLineEx(tabletemp)
                local tabletemp2 = {
                    origin = tabletemp.pos
                }
                SpawnEntityFromTable("item_ammopack_medium", tabletemp2)
                return
            }
            ////Spawn medium health pack
            if (data.text.tolower() == "!p hm")
            {
                local tabletemp = {
                    start = ply.EyePosition()
                    end = ply.EyePosition() + ply.EyeAngles().Forward() * 8192.0
                    ignore = ply
                }
                TraceLineEx(tabletemp)
                local tabletemp2 = {
                    origin = tabletemp.pos
                }
                SpawnEntityFromTable("item_healthkit_medium", tabletemp2)
                return
            }
            ////Spawn small ammo pack
            if (data.text.tolower() == "!p as")
            {
                local tabletemp = {
                    start = ply.EyePosition()
                    end = ply.EyePosition() + ply.EyeAngles().Forward() * 8192.0
                    ignore = ply
                }
                TraceLineEx(tabletemp)
                local tabletemp2 = {
                    origin = tabletemp.pos
                }
                SpawnEntityFromTable("item_ammopack_small", tabletemp2)
                return
            }
            ////Spawn small health pack
            if (data.text.tolower() == "!p hs")
            {
                local tabletemp = {
                    start = ply.EyePosition()
                    end = ply.EyePosition() + ply.EyeAngles().Forward() * 8192.0
                    ignore = ply
                }
                TraceLineEx(tabletemp)
                local tabletemp2 = {
                    origin = tabletemp.pos
                }
                SpawnEntityFromTable("item_healthkit_small", tabletemp2)
                return
            }
            ////Clear all packs
            if (data.text.tolower() == "!p clear")
            {
                EntFire("item_ammopack_small", "Kill", null, 0, null)
                EntFire("item_ammopack_medium", "Kill", null, 0, null)
                EntFire("item_ammopack_full", "Kill", null, 0, null)
                EntFire("item_healthkit_small", "Kill", null, 0, null)
                EntFire("item_healthkit_medium", "Kill", null, 0, null)
                EntFire("item_healthkit_full", "Kill", null, 0, null)
                printl("TR_KARMA: Deleted all ammo and health packs")
                return
            }
            if (data.text.tolower() == "!p")
            {
                ClientPrint(ply, 3, "\x07FFFF66Example: !p am for medium ammopack. !p hl for large healthkit. !p clear to delete all packs")
                return
            }            
    ////Toggle critical hits
    if (data.text.tolower() == "!c")
    {
        if (ply.InCond(11) == false)
        {
            ply.AddCond(11)
            ClientPrint(null, 3, "\x07FFFF66Crits enabled for " + plyname)
            return
        }
        else
        {
            ply.RemoveCond(11)
            ClientPrint(null, 3, "\x07FFFF66Crits disabled for " + plyname)
            return
        }
    }
    ////Clear ragdolls
    if (data.text.tolower() == "!clear")
    {
        EntFire("tf_ragdoll", "Kill", null, 0, null)
        EntFire("tf_dropped_weapon", "Kill", null, 0, null)
        printl("TR_KARMA: Deleted all ragdolls and weapons")
        return
    }   
    ////////////////////////////////////////////////////
    //// FOR PARTNER TAUNTS
    ////////////////////////////////////////////////////
    //Coming soon, maybe we can just use cfgs for this
    ////Scout
    //if (data.text.tolower() == "!pa")
    //{
        //local scouttable = {
        //    origin = Vector(297.659546,-982.671692,65.031311)
        //    angles = QAngle(0,180,0)
        //    classa = scout
        //}
        //SpawnEntityFromTable("bot_generator", scouttable)
        //botillo.AddEFlags(256) //Removes AI from the bot
    //    printl("finished scout")
    //    return
    //}
}

__CollectGameEventCallbacks(this)



