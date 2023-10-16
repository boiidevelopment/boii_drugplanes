----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--[[
    FRAMEWORK 
]]

framework = config.resource_settings.framework

if framework == 'boii_base' then
    fw = exports['boii_base']:get_object()
elseif framework == 'qb-core' then
    fw = exports['qb-core']:GetCoreObject()
elseif framework == 'esx_legacy' then
    fw = exports['es_extended']:getSharedObject()
elseif framework == 'ox_core' then    
    local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
    local import = LoadResourceFile('ox_core', file)
    local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))
    chunk()
elseif framework == 'custom' then
    -- add code for your own framework here
end

--[[
    FUNCTIONS
]]

-- Function to get a player
function get_player(_src)
    if framework == 'boii_base' then
        player = fw.get_user(_src)
    elseif framework == 'qb-core' then
        player = fw.Functions.GetPlayer(_src)
    elseif framework == 'esx_legacy' then
        player = fw.GetPlayerFromId(_src)
    elseif framework == 'ox_core' then
        player = Ox.GetPlayer(_src)
    elseif framework == 'custom' then
        -- Add your own custom entry here.
    end
    return player
end

-- Function to add items to players
function add_items_to_player(_src, item, item_label, quantity)
    local player = get_player(_src)
    if not player then print('[DEBUG] - add_items_to_player() - player not found') return end

    if framework == 'boii_base' then
        player.modify_inventory(item, 'add', quantity)
    elseif framework == 'qb-core' then
        player.Functions.AddItem(item, quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, fw.Shared.Items[item], 'add', quantity)
    elseif framework == 'esx_legacy' then
        player.addInventoryItem(item, quantity)
    elseif framework == 'ox_core' then
        ox_inventory = exports.ox_inventory
        exports.ox_inventory:AddItem(_src, item, quantity)
    elseif framework == 'custom' then
        -- Add your own custom entry here.
    end
    TriggerClientEvent('boii_drugplanes:notify', _src, language.notifications['header'], string.format(language.notifications['add_item'], item, quantity), 'success', 4500)
end