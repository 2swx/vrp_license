-- Set blip name
local license_positions = {
  ["police"] = {
    info = {['bname'] = "Licenta Politie",['context']= "police", ['x'] =441.86703491211, ['y'] =-982.09912109375, ['z'] = 30.689605712891},
  },
  ["law"] = {
    info = {['bname'] = "Licenta Avocatura",['context']= "law", ['x'] =-1913.4498291016, ['y'] =-578.23413085938, ['z'] = 14.700349807739},
  },
  ["cpp"] = {
    info = {['bname'] = "Aptitudini C++",['context']= "cpp", ['x'] =705.81683349609, ['y'] =-964.90258789063, ['z'] = 30.395399093628},
  },
  ["java"] = {
    info = {['bname'] = "Aptitudini Java",['context']= "java", ['x'] =717.83355712891, ['y'] =-973.62866210938, ['z'] = 30.395320892334},
  },
  ["medicine"] = {
    info = {['bname'] = "Diploma Medicina",['context']= "medicine", ['x'] =240.126953125, ['y'] =-1380.1204833984, ['z'] = 33.741771697998},
  },
  ["transport"] = {
    info = {['bname'] = "Licenta de Transport",['context']= "transport", ['x'] =-269.44073486328, ['y'] =-955.83953857422, ['z'] = 31.22313117981},
  },
  ["chemistry"] = {
    info = {['bname'] = "Diploma Chimie",['context']= "chemistry", ['x'] =598.79302978516,['y']=147.6453704834,['z']=61.672721862793},
  },
  ["heavywpn"] = {
    info = {['bname'] = "Permis PORT-ARMA GREA",['context']= "heavy weapon", ['x'] =-455.51950073242, ['y'] =6008.0795898438, ['z'] = 31.490114212036},
  },
  ["lowwpn"] = {
    info = {['bname'] = "Permis PORT-ARMA USOARA",['context']= "low weapon", ['x'] =-438.83303833008, ['y'] =5978.3310546875, ['z'] = 31.490161895752},
  },
}
-- Display Map Blips
Citizen.CreateThread(function()
  if true then
      for k,v in pairs(license_positions)do
        local pos = v.info
        local blipname = v.info.bname
        local blip = AddBlipForCoord(pos.x, pos.y, pos.z) -- here u can set up ur position, this is a test position
        SetBlipSprite(blip, 498)
        SetBlipColour(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipname)
        EndTextCommandSetBlipName(blip)
      end
  end
end)

-- rainbow effect
local function curcubeu( frequency )
  local result = {}
  local curtime = GetGameTimer() / 4000

  result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
  result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
  result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
  
  return result
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2)
    local rainbow = curcubeu (1)
    for k,v in pairs(license_positions)do
      local pos = v.info
      DrawMarker(22, pos.x, pos.y, pos.z , 0, 0, 0, 0, 0, 0, 0.7001,0.7001,0.7001,rainbow.r, rainbow.g, rainbow.b, 150, 1, 1, 0, 1, 0, 0, 0)
      DrawMarker(6, pos.x, pos.y, pos.z , 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001,rainbow.r, rainbow.g, rainbow.b, 150, 1, 1, 0, 1, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(2)
      for k,v in pairs(license_positions)do
        local pos = v.info
        local context = v.info.context
        local chance = math.random(1,15)
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then -- here u can set up ur position, this is a test position
          license_text("Press ~INPUT_CONTEXT~ for buying a license!")
          if IsControlJustPressed(1, 51) then
            if IsInVehicle() then
              TriggerEvent('msg:pedincar')
            else
              if chance == 10 then
            	  TriggerServerEvent('vrp:licensepay', context)
              else
                TriggerEvent('msg:fail')
                Citizen.Wait(20000)
              end
            end
          end
        end
      end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2000)
    TriggerServerEvent('vrp:stopmission')
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

  RegisterNetEvent('msg:pedincar')
  AddEventHandler('msg:pedincar', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You can't buy a license from a car!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)
  RegisterNetEvent('msg:noteligible')
  AddEventHandler('msg:noteligible', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You can't take that mission, you need license for it or you'll be fired!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:fail')
  AddEventHandler('msg:fail', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You failed, so you need to take the test later!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:notenoughmoney')
  AddEventHandler('msg:notenoughmoney', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You don't have enough money!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youalreadyhaveit')
  AddEventHandler('msg:youalreadyhaveit', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You already have this license!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:donthaveit')
  AddEventHandler('msg:donthaveit', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You don't have this license!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicensehwpn')
  AddEventHandler('msg:youboughtlicensehwpn', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for heavy weapons!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicenselwpn')
  AddEventHandler('msg:youboughtlicenselwpn', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for low weapons!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicensecpp')
  AddEventHandler('msg:youboughtlicensecpp', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for C++!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicensejava')
  AddEventHandler('msg:youboughtlicensejava', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for JAVA!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicenselaw')
  AddEventHandler('msg:youboughtlicenselaw', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for law!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicensepolice')
  AddEventHandler('msg:youboughtlicensepolice', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for police!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicensetransport')
  AddEventHandler('msg:youboughtlicensetransport', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for transport!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicensemedicine')
  AddEventHandler('msg:youboughtlicensemedicine', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for medicine!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:youboughtlicensechemistry')
  AddEventHandler('msg:youboughtlicensechemistry', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Now you have license for chemistry!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:playerhavelwpn')
  AddEventHandler('msg:playerhavelwpn', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("This player has low weapon license!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('msg:playerhavehwpn')
  AddEventHandler('msg:playerhavehwpn', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("This player has heavy weapon license!")
      SetNotificationMessage("CHAR_MP_ARMY_CONTACT", "CHAR_MP_ARMY_CONTACT", true, 1, "License Sys")
      DrawNotification(false, true)
  end)