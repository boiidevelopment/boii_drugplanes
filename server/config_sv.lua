----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

config_sv = config_sv or {}

-- Script logic settings
config_sv.logic = {
    check_delay = 2, -- This is a timer in mins used to delay the thread which checks if a player is inside one of the zones below.
    max_planes = 10, -- This is the maximum number of planes that can be spawned in the server at any given time.
    max_packages = 10, -- This is the maximum number of packages a plane can spawn.
    pause_timer = 60, -- This is the pause timer in mins which will be activated once the max_planes threshold has been reached once timer is complete planes will be allowed to spawn again.
    zones = {
        --[[
            NOTES:

            These are the zones where players must be inside for the random event to trigger.
            A synced plane will be spawned for all players which will then fall to the ground exploding and leaving behind some packages for players to collect.
        ]]
        { coords = vector3(-1178.57, 3667.8, 366.09), radius = 650.0, spawn_chance = 0.001 },
        { coords = vector3(-2217.39, 1416.88, 304.01), radius = 750.0, spawn_chance = 0.002 },
        { coords = vector3(2126.4, 3137.92, 41.46), radius = 700.0, spawn_chance = 0.003 }
        -- Add more zones here if required
    },
    planes = {
        --[[
            NOTES:

            These are the types of planes that can be spawned.
            You can change the planes to spawn here or add additional.
        ]]
        'velum',
        'dodo',
        'cuban800',
        'mammatus'
        -- Add more vehicles here if required
    },
    packages = {
        --[[
            NOTES:

            These are the types of package that can be spawned by a crashed planed and the rewards given for collecting them.
        ]]
        {
            model_name = 'prop_drug_package',
            rewards = {
                {item = 'water', label = 'Water', quantity = math.random(1, 5)}
                -- Add more items if required
            }
        },
        {
            model_name = 'prop_mp_drug_pack_blue',
            rewards = {
                {item = 'burger', label = 'Burger', quantity = math.random(1, 5)} 
                -- Add more items if required 
            }
        },
        {
            model_name = 'prop_mp_drug_pack_red',
            rewards = {
                {item = 'sandwich', label = 'Sandwich', quantity = math.random(1, 5)}
                -- Add more items if required
            }
        }
        -- Add more package types if required
    }
}