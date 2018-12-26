--Settings--
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_license")

MySQL.createCommand("vRP/license_table","ALTER TABLE vrp_users ADD IF NOT EXISTS diploma_chemistry VARCHAR(25) NOT NULL DEFAULT 'false', ADD IF NOT EXISTS license_lwpn VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS license_hwpn VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_cpp VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_java VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_transport VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_law VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_medicine VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_nationalsecure VARCHAR(25) NOT NULL DEFAULT 'false'")
MySQL.createCommand("vRP/lowweapons_update","UPDATE vrp_users SET license_lwpn='true' WHERE id=@id")
MySQL.createCommand("vRP/heavyweapons_update","UPDATE vrp_users SET license_hwpn='true' WHERE id=@id")
MySQL.createCommand("vRP/cpp_update","UPDATE vrp_users SET diploma_cpp='true' WHERE id=@id")
MySQL.createCommand("vRP/java_update","UPDATE vrp_users SET diploma_java='true' WHERE id=@id")
MySQL.createCommand("vRP/law_update","UPDATE vrp_users SET diploma_law='true' WHERE id=@id")
MySQL.createCommand("vRP/medicine_update","UPDATE vrp_users SET diploma_medicine='true' WHERE id=@id")
MySQL.createCommand("vRP/police_update","UPDATE vrp_users SET diploma_nationalsecure='true' WHERE id=@id")
MySQL.createCommand("vRP/transport_update","UPDATE vrp_users SET diploma_transport='true' WHERE id=@id")
MySQL.createCommand("vRP/chemistry_update","UPDATE vrp_users SET diploma_chemistry='true' WHERE id=@id")
MySQL.createCommand("vRP/licenses_check","SELECT * FROM vrp_users WHERE id=@id")

MySQL.execute("vRP/license_table")

RegisterServerEvent('vrp:licensepay')
AddEventHandler('vrp:licensepay', function(context)
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	MySQL.query("vRP/licenses_check", {id = user_id}, function(rows,affected)
		lowweapons = rows[1].license_lwpn
		heavyweapons =  rows[1].license_hwpn
		cpp =  rows[1].diploma_cpp
		java =  rows[1].diploma_java
		law =  rows[1].diploma_law
		police =  rows[1].diploma_nationalsecure
		transport =  rows[1].diploma_transport
		medicine =  rows[1].diploma_medicine
		chemistry =  rows[1].diploma_chemistry
		if lowweapons == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif heavyweapons == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif cpp == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif java == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif law == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif police == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif transport == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif medicine == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif chemistry == "true" then
		    TriggerClientEvent('msg:youalreadyhaveit', player)
		elseif lowweapons == "false" and context == "low weapon" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicenselwpn', player)
			  MySQL.query("vRP/lowweapons_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif heavyweapons == "false" and context == "heavy weapon" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicensehwpn', player)
			  MySQL.query("vRP/heavyweapons_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif cpp == "false" and context == "cpp" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicensecpp', player)
			  MySQL.query("vRP/cpp_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif java == "false" and context == "java" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicensejava', player)
			  MySQL.query("vRP/java_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif law == "false" and context == "law" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicenselaw', player)
			  MySQL.query("vRP/law_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif police == "false" and context == "police" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicensepolice', player)
			  MySQL.query("vRP/police_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif transport == "false" and context == "transport" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicensetransport', player)
			  MySQL.query("vRP/transport_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif medicine == "false" and context == "medicine" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicensemedicine', player)
			  MySQL.query("vRP/medicine_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		elseif chemistry == "false" and context == "chemistry" then
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg:youboughtlicensechemistry', player)
			  MySQL.query("vRP/chemistry_update", {id = user_id})
		    else
		      TriggerClientEvent('msg:notenoughmoney', player)
		    end
		else
		    TriggerClientEvent('msg:nolicenseselected', player)
		end
	end)
end)

local choice_check_license_lwpn = {function(player,choice)
    vRPclient.getNearestPlayer(player, {5}, function(nplayer)
	    local nuser_id = vRP.getUserId(nplayer)
	    if nuser_id ~= nil then
			MySQL.query("vRP/licenses_check", {id = nuser_id}, function(rows,affected)
				license_lwpn = rows[1].lowweapons
				if license_lwpn == "true" then
				  TriggerClientEvent('msg:playerhavelwpn', player)
				else
				  TriggerClientEvent('msg:donthaveit', player)
				end
			end)
			vRP.openMenu({player, menu})
		end
    end)
end}

local choice_check_license_hwpn = {function(player,choice)
    vRPclient.getNearestPlayer(player, {5}, function(nplayer)
	    local nuser_id = vRP.getUserId(nplayer)
	    if nuser_id ~= nil then
			MySQL.query("vRP/licenses_check", {id = nuser_id}, function(rows,affected)
				license_hwpn = rows[1].heavyweapons
				if license_hwpn == "true" then
				  TriggerClientEvent('msg:playerhavehwpn', player)
				else
				  TriggerClientEvent('msg:donthaveit', player)
				end
			end)
			vRP.openMenu({player, menu})
		end
    end)
end}

vRP.registerMenuBuilder({"police", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
    if vRP.hasPermission({user_id,"police.check"}) then
      choices["Check Low Wpn license"] = choice_check_license_lwpn
      choices["Check Heavy Wpn license"] = choice_check_license_hwpn
    end
    add(choices)
  end
end})