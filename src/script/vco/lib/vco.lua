local vco = {};

function vco:get_faction_keys()
    return ipairs(cm:get_human_factions());
end

function vco:trigger_faction_missions(mod_name, faction_key)
    local campaign_name = cm:get_campaign_name(); 

    local status, missions = pcall(require, "script/"..mod_name.."/factions/"..faction_key.."/campaigns/"..campaign_name.."/missions")
    if status then
        for _, mission in ipairs(missions) do
            if mission and mission ~= "" then
                cm:trigger_custom_mission_from_string(faction_key, mission);
            end
        end
    end
end

function vco:trigger_custom_missions(mod_name)
    if cm:is_new_game() then
        for _, faction_key in vco:get_faction_keys() do
            vco:trigger_faction_missions(mod_name, faction_key);
        end
    end
end

return vco;
