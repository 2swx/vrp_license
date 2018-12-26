-- Set blip name
local license_positions = {
  ["police"] = {
    info = {['bname'] = "Police License",['context']= "police", ['x'] =, ['y'] =, ['z'] = },
  },
  ["law"] = {
    info = {['bname'] = "Lawyer License",['context']= "law", ['x'] =, ['y'] =, ['z'] = },
  },
  ["cpp"] = {
    info = {['bname'] = "C++ License",['context']= "cpp", ['x'] =, ['y'] =, ['z'] = },
  },
  ["java"] = {
    info = {['bname'] = "Java License",['context']= "java", ['x'] =, ['y'] =, ['z'] = },
  },
  ["medicine"] = {
    info = {['bname'] = "Medicine License",['context']= "medicine", ['x'] =, ['y'] =, ['z'] = },
  },
  ["transport"] = {
    info = {['bname'] = "Transport License",['context']= "transport", ['x'] =, ['y'] =, ['z'] = },
  },
  ["chemistry"] = {
    info = {['bname'] = "Chemistry License",['context']= "chemistry", ['x'] =, ['y'] =, ['z'] = },
  },
  ["heavywpn"] = {
    info = {['bname'] = "Heavy Weapons License",['context']= "heavy weapon", ['x'] =, ['y'] =, ['z'] = },
  },
  ["lowwpn"] = {
    info = {['bname'] = "Low Weapons License",['context']= "low weapon", ['x'] =, ['y'] =, ['z'] = },
  },
}
-- Display Map Blips
Citizen.CreateThread(function()
  if true then
      for k,v in pairs(license_positions)do
        local pos = v.info
        local blipname = v.info.bname
        local blip = AddBlipForCoord(pos.x, pos.y, pos.z) -- here u can set up ur position, this is a test position
        SetBlipSprite(blip, 181)
        SetBlipColour(blip, 1)
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