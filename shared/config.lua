----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

config = config or {}

-- Debug
config.debug = false -- Toggle script debug mode. True will show debug prints and zone markers. False will disable these.

-- Resource settings
config.resource_settings = {
    framework = 'boii_base', -- Choose your framework here. Available options; 'boii_base', 'qb-core', 'ox_core', 'esx_legacy', 'custom'
    notifications = 'boii_ui', -- Choose your notifications here. Available options; 'boii_ui' -- additional options will be added 
}

-- Keypress
config.keypress = 38 -- [E] -- This is the keypress required to pick up packages

-- Animation settings
config.animations = {
    pick_up = {
        dict = 'pickup_object',
        anim = 'pickup_low',
        flags = 1
    }
}