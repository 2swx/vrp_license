-- Set blip name
local blipname = "NAME"

-- Display Map Blips
Citizen.CreateThread(function()
  if true then
      local blip = AddBlipForCoord(-1700.6760253906, -1091.7877197266, 13.152297019958) -- here u can set up ur position, this is a test position
      SetBlipSprite(blip, 181)
      SetBlipColour(blip, 1)
      SetBlipScale(blip, 0.8)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(blipname)
      EndTextCommandSetBlipName(blip)
  end
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(2)
      if GetDistanceBetweenCoords(-1700.6760253906, -1091.7877197266, 13.152297019958, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then -- here u can set up ur position, this is a test position
        license_text("Press ~INPUT_CONTEXT~ for buying a license!")
        if IsControlJustPressed(1, 51) then
          if IsInVehicle() then
            TriggerEvent('pedincar')
          else
          	TriggerServerEvent('vrp:licensepaid')
          end
        end
      end
  end
end)

function license_text(str)
  SetTextComponentFormat("STRING")
  AddTextComponentString(str)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

--Messages for bought license
  RegisterNetEvent('msg')
  AddEventHandler('msg', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You have now a license for [...]!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('pedincar')
  AddEventHandler('pedincar', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You can't buy a license in a car!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('cantbuy')
  AddEventHandler('cantbuy', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You don't have enough money!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('haveit')
  AddEventHandler('haveit', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You have this license!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('nohaveit')
  AddEventHandler('nohaveit', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You don't have this license!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)