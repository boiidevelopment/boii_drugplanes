local can_spawn_plane = true

GlobalState.plane_spawn_counter = 0

-- Function to get random coords to spawn plane in the zone
local function get_random_coords_in_zone(zone)
    local random_x = zone.radius * (math.random() - 0.5) * 2
    local random_y = zone.radius * (math.random() - 0.5) * 2
    return vector3(zone.coords.x + random_x, zone.coords.y + random_y, 1000.0)
end

-- Function to reward players based on the package they picked up
local function reward_player(_src, package_type_index)
    local package = config_sv.logic.packages[package_type_index]
    if package then
        for _, reward in ipairs(package.rewards) do
            print("[REWARD] Given to player " .. _src .. ": " .. reward.item .. " x" .. reward.quantity)
            add_items_to_player(_src, reward.item, reward.label, reward.quantity)
        end
    else
        print("[ERROR] Invalid package type index received: " .. tostring(package_type_index))
    end
end

--[[
    EVENTS
]]

-- Event to request zones for blips -- may remove
RegisterServerEvent('boii_drugplanes:cl:request_zones', function()
    local _src = source
    print('[DEBUG] Client ' .. _src .. ' requested zones.')
    TriggerClientEvent('boii_drugplanes:cl:receive_zones', _src, config_sv.logic.zones)
end)

-- Event to remove a package and trigger rewards function
RegisterNetEvent('boii_drugplanes:sv:remove_package', function(entity, package_type_index)
    local _src = source
    TriggerClientEvent('boii_drugplanes:cl:remove_package', -1, entity)
    reward_player(_src, package_type_index)
end)

--[[
    THREADS
]]

-- Thread to spawn planes
CreateThread(function()
    while true do
        local check_delay = config_sv.logic.check_delay * 60000
        Wait(check_delay)
        if not can_spawn_plane then
            if config.debug then
                print('[DEBUG] Plane spawning is paused.')
            end  
            return
        end
        local should_spawn_plane = false
        local spawn_zone = nil
        for _, player_id in ipairs(GetPlayers()) do
            local player_coords = GetEntityCoords(GetPlayerPed(player_id))
            for _, zone in ipairs(config_sv.logic.zones) do
                if #(player_coords - zone.coords) < zone.radius then
                    if math.random() < zone.spawn_chance then
                        should_spawn_plane = true
                        spawn_zone = zone
                        if config.debug then
                            print('[DEBUG] Decided to spawn a plane near player ' .. player_id)
                        end
                        break
                    end
                end
            end
            if should_spawn_plane then
                break
            end
        end
        if should_spawn_plane and spawn_zone then
            local selected_plane = config_sv.logic.planes[math.random(#config_sv.logic.planes)]
            GlobalState.plane_spawn_counter = GlobalState.plane_spawn_counter + 1
            local spawn_coords = get_random_coords_in_zone(spawn_zone)
            if config.debug then
                print('[DEBUG] Spawning plane at ' .. tostring(spawn_coords) .. '. Total planes spawned: ' .. GlobalState.plane_spawn_counter)
            end
            TriggerClientEvent('boii_drugplanes:cl:plane_spawn', -1, selected_plane, spawn_coords, config_sv.logic.max_packages, config_sv.logic.packages)
            if GlobalState.plane_spawn_counter >= config_sv.logic.max_planes then
                can_spawn_plane = false
                if config.debug then
                    print('[DEBUG] Hit max planes threshold. Pausing spawns for ' .. (config_sv.logic.pause_timer / 60000) .. ' minutes.')
                end
                local pause_timer = config_sv.logic.pause_timer * 60000
                SetTimeout(pause_timer, function()
                    GlobalState.plane_spawn_counter = 0
                    can_spawn_plane = true
                    if config.debug then
                        print('[DEBUG] Reset plane spawn counter. Resuming spawns.')
                    end
                end)
            end
        end
    end
end)