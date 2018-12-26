--Settings--
MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_license")

MySQL.createCommand("vRP/license_table","ALTER TABLE vrp_users ADD IF NOT EXISTS license VARCHAR(25) NOT NULL DEFAULT 'false'")
MySQL.createCommand("vRP/license_update","UPDATE vrp_users SET license='true' WHERE id=@id")
MySQL.createCommand("vRP/license_check","SELECT license FROM vrp_users WHERE id=@id")

MySQL.execute("vRP/license_table")

RegisterServerEvent('vrp:licensepaid')
AddEventHandler('vrp:licensepaid', function()
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	MySQL.query("vRP/license_check", {id = user_id}, function(rows,affected)
		license = rows[1].license
		if license == "true" then
		  TriggerClientEvent('haveit', player)
		else
		    if vRP.tryPayment({user_id,2500}) then
		      TriggerClientEvent('msg', player)
		      addLicense(user_id)
		    else
		      TriggerClientEvent('cantbuy', player)
		    end
		end
	end)
end)

function addLicense(user_id)
	MySQL.query("vRP/license_update", {id = user_id})
end

local choice_check_license = {function(player,choice)
    vRPclient.getNearestPlayer(player, {5}, function(nplayer)
	    local nuser_id = vRP.getUserId(nplayer)
	    if nuser_id ~= nil then
			MySQL.query("vRP/license_check", {id = nuser_id}, function(rows,affected)
				license = rows[1].license
				if license == "true" then
				  TriggerClientEvent('haveit', player)
				else
				  TriggerClientEvent('nohaveit', player)
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
    if vRP.hasPermission({user_id,"police.drag"}) then
      choices["Check license"] = choice_check_license
    end
    add(choices)
  end
end})