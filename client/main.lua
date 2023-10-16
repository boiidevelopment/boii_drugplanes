local packages = {}
local package_type_associations = {}

--[[
    FUNCTIONS
]]

-- Function to request model 
local function request_model(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
      Wait(0)
    end
end

-- Function to request animation dictionary
local function request_anim(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

--[[
    EVENTS
]]

-- Event to spawn a plane
RegisterNetEvent('boii_drugplanes:cl:plane_spawn', function(plane, spawn_coords, max_items, packageTypes)
    local plane_model = GetHashKey(plane)
    request_model(plane_model)
    local plane = CreateVehicle(plane_model, spawn_coords.x, spawn_coords.y, spawn_coords.z, 0.0, true, false)
    ControlLandingGear(plane, 3)
    SetVehicleEngineHealth(plane, 0.0)
    SetEntityInvincible(plane, false)
    CreateThread(function()
        while true do
            Wait(1000)
            if not DoesEntityExist(plane) then
                if config.debug then
                    print(language.debug_prints['no_plane_exists'])
                end
                break
            end
            local plane_health = GetEntityHealth(plane)
            if plane_health <= 100 then
                for i = 1, max_items do
                    local random_package = math.random(1, #packageTypes)
                    local selected_package = packageTypes[random_package]
                    local package_prop = GetHashKey(selected_package.model_name)
                    request_model(package_prop)
                    local distance = math.random() * 10
                    local angle = math.random() * 360
                    local offeset_x = distance * math.cos(math.rad(angle))
                    local offeset_y = distance * math.sin(math.rad(angle))
                    local plane_coords = GetEntityCoords(plane)
                    local package_x = plane_coords.x + offeset_x
                    local package_y = plane_coords.y + offeset_y
                    local package_z = plane_coords.z + 1
                    local package = CreateObject(package_prop, package_x, package_y, package_z, true, false, true)
                    PlaceObjectOnGroundProperly(package)
                    packages[#packages + 1] = package
                    package_type_associations[package] = random_package
                    if config.debug then
                        print(string.format(language.debug_prints['spawning_packages'], package_x, package_y, package_z))
                    end
                end
                if config.debug then
                    print(language.debug_prints['spawned_packages'])
                end
                break
            end
        end
    end)
end)

-- Event to sync remove packages
RegisterNetEvent('boii_drugplanes:cl:remove_package', function(entity)
    for i, package in ipairs(packages) do
        if package == entity then
            DeleteEntity(package)
            table.remove(packages, i)
            break
        end
    end
end)

-- Event to receive and set map zones
RegisterNetEvent('boii_drugplanes:cl:receive_zones', function(received_zones)
    for _, zone in ipairs(received_zones) do
        if config.debug then
            local blip = AddBlipForRadius(zone.coords.x, zone.coords.y, zone.coords.z, zone.radius)
            SetBlipColour(blip, 1)
            SetBlipAlpha(blip, 128)
        end
    end
end)

--[[
    THREADS
]]

-- Thread to handle keypress and pickups
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, config.keypress) then
            local coords = GetEntityCoords(PlayerPedId())
            local nearest_package = nil
            local range_check = 2.0
            for _, package in ipairs(packages) do
                local package_coords = GetEntityCoords(package)
                local distance = #(coords - package_coords)
                if distance < range_check then
                    range_check = distance
                    nearest_package = package
                end
            end
            if nearest_package then
                local anim_config = config.animations.pick_up
                request_anim(anim_config.dict)
                TaskPlayAnim(PlayerPedId(), anim_config.dict, anim_config.anim, 8.0, -8.0, -1, anim_config.flags, 0, false, false, false)
                Wait(2000)
                local package_index = package_type_associations[nearest_package]
                TriggerServerEvent('boii_drugplanes:sv:remove_package', nearest_package, package_index)
                package_type_associations[nearest_package] = nil
            end
        end
    end
end)

--[[
    INIT
]]

local function request_zone_blips()
    TriggerServerEvent('boii_drugplanes:cl:request_zones')
end
request_zone_blips()