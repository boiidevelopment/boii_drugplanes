----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

local notifications = config.resource_settings.notifications

--[[
    NOTIFICATIONS
]]

-- Function to send notifications
function notify(header, message, type, duration)

    if notifications == 'boii_ui' then
        exports['boii_ui']:notify(header, message, type, duration)
    else
        -- TO DO:
    end

end

--[[
    EVENTS
]]

-- Event to send notifications
RegisterNetEvent('boii_drugplanes:notify', function(header, message, type, duration)
    notify(header, message, type, duration)
end)