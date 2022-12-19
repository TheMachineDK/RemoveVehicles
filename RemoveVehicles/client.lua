-- Declare variables
local vehicles = {} -- table to store the vehicles

-- Create a command to remove all unused vehicles within a specified radius
RegisterCommand("removevehicles", function(source, args, rawCommand)
  -- Check if the player has admin permissions
  if IsPlayerAceAllowed(source, "admin") then
    -- Get the player's position and radius
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
    local radius = tonumber(args[1])

    -- Get a list of all the vehicles currently spawned on the server
    vehicles = ESX.Game.GetVehicles()

    -- Loop through the list of vehicles
    for i = 1, #vehicles do
      -- Check if the vehicle is within the specified radius
      if GetDistanceBetweenCoords(x, y, z, GetEntityCoords(vehicles[i]), true) <= radius then
        -- Check if the vehicle is unused (no players inside)
        if not IsAnyPlayerNearVehicle(vehicles[i]) then
          -- Despawn the vehicle
          ESX.Game.DeleteVehicle(vehicles[i])
        end
      end
    end
  else
    -- Send a message to the player if they don't have admin permissions
    TriggerClientEvent("chat:addMessage", source, { args = {"^1Error: ^7Du har ikke adgang til denne kommando!"} })
  end
end, false)