--Settings--
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_license")

MySQL.createCommand("vRP/license_table","ALTER TABLE vrp_users ADD IF NOT EXISTS diploma_chemistry VARCHAR(25) NOT NULL DEFAULT 'false', ADD IF NOT EXISTS license_lwpn VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS license_hwpn VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_cpp VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_java VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_law VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_medicine VARCHAR(25) NOT NULL DEFAULT 'false',ADD IF NOT EXISTS diploma_nationalsecure VARCHAR(25) NOT NULL DEFAULT 'false'")
MySQL.createCommand("vRP/lowweapons_update","UPDATE vrp_users SET license_lwpn='true' WHERE id=@id")
MySQL.createCommand("vRP/heavyweapons_update","UPDATE vrp_users SET license_hwpn='true' WHERE id=@id")
MySQL.createCommand("vRP/cpp_update","UPDATE vrp_users SET diploma_cpp='true' WHERE id=@id")
MySQL.createCommand("vRP/java_update","UPDATE vrp_users SET diploma_java='true' WHERE id=@id")
MySQL.createCommand("vRP/law_update","UPDATE vrp_users SET diploma_law='true' WHERE id=@id")
MySQL.createCommand("vRP/medicine_update","UPDATE vrp_users SET diploma_medicine='true' WHERE id=@id")
MySQL.createCommand("vRP/police_update","UPDATE vrp_users SET diploma_nationalsecure='true' WHERE id=@id")
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


RegisterServerEvent('vrp:stopmission')
AddEventHandler('vrp:stopmission', function()
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	MySQL.query("vRP/licenses_check", {id = user_id}, function(rows,affected)
		cpp =  rows[1].diploma_cpp
		java =  rows[1].diploma_java
		law =  rows[1].diploma_law
		transport =  rows[1].license_transport
		police =  rows[1].diploma_nationalsecure
		medicine =  rows[1].diploma_medicine
		chemistry =  rows[1].diploma_chemistry
		if cpp == "false" and vRP.hasPermission({user_id,"licensecpp.check"}) and vRP.hasMission({player}) then
			vRP.stopMission({player})
		    TriggerClientEvent('msg:noteligible', player)
		elseif java == "false" and vRP.hasPermission({user_id,"licensejava.check"}) and vRP.hasMission({player}) then
			vRP.stopMission({player})
		    TriggerClientEvent('msg:noteligible', player)
		elseif law == "false" and vRP.hasPermission({user_id,"licenselaw.check"}) and vRP.hasMission({player}) then
			vRP.stopMission({player})
		    TriggerClientEvent('msg:noteligible', player)
		elseif police == "false" and vRP.hasPermission({user_id,"licensecop.check"}) and vRP.hasMission({player}) then
			vRP.stopMission({player})
		    TriggerClientEvent('msg:noteligible', player)
		elseif medicine == "false" and vRP.hasPermission({user_id,"licensemed.check"}) and vRP.hasMission({player}) then
			vRP.stopMission({player})
		    TriggerClientEvent('msg:noteligible', player)
		elseif transport == "false" and vRP.hasPermission({user_id,"licensetransport.check"}) and vRP.hasMission({player}) then
			vRP.stopMission({player})
		    TriggerClientEvent('msg:noteligible', player)
		elseif chemistry == "false" and vRP.hasPermission({user_id,"licensechemistry.check"}) and vRP.hasMission({player}) then
			vRP.stopMission({player})
		    TriggerClientEvent('msg:noteligible', player)
		end
	end)
end)

local choice_check_license_hwpn = {function(player,choice)
    vRPclient.getNearestPlayer(player, {5}, function(nplayer)
	    local nuser_id = vRP.getUserId(nplayer)
	    if nuser_id ~= nil then
			MySQL.query("vRP/licenses_check", {id = nuser_id}, function(rows,affected)
				license_hwpn = rows[1].heavyweapons
				license_lwpn = rows[1].lowweapons
				if license_lwpn == "false" and license_hwpn == "true" then
					TriggerClientEvent('chatMessage', player, '^3[ Check licenses ]', {255, 0, 0}, "^4Mhmmm...He doesn't have license for small weapons..." )
					TriggerClientEvent('chatMessage', nplayer, '^3[ You ]', {255, 0, 0}, "^4I am fucked up..." )
				elseif license_hwpn == "false" and license_lwpn == "true" then
					TriggerClientEvent('chatMessage', player, '^3[ Check licenses ]', {255, 0, 0}, "^4Oh...Seriously, not for big weapons?! I will jail him..." )
					TriggerClientEvent('chatMessage', nplayer, '^3[ You ]', {255, 0, 0}, "^4I go to jail...bye life..." )
				elseif license_hwpn == license_lwpn == "true" then
					TriggerClientEvent('chatMessage', player, '^3[ Check licenses ]', {255, 0, 0}, "^4Oh...He's clean..." )
					TriggerClientEvent('chatMessage', nplayer, '^3[ You ]', {255, 0, 0}, "^4YESSSS, I am not going to jail." )
				elseif license_hwpn == license_lwpn == "false" then
					TriggerClientEvent('chatMessage', player, '^3[ Check licenses ]', {255, 0, 0}, "^4NOOOO, YOU BIG MURDER...GET IN THE CAR!NOOW!" )
					TriggerClientEvent('chatMessage', nplayer, '^3[ You ]', {255, 0, 0}, "^4NO, he wanna jail me..." )
				end
			end)
			vRP.openMenu({player, menu})
		else
			TriggerClientEvent('chatMessage', player, '^3[ Check licenses ]', {255, 0, 0}, "^4Oh...I can't check the air...STUPID ME!" )
		end
    end)
end}

vRP.registerMenuBuilder({"police", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
    if vRP.hasPermission({user_id,"police.check"}) then
      choices["Check Weapons Licenses"] = choice_check_license_hwpn
    end
    add(choices)
  end
end})