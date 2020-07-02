local vco = {};

function vco:get_faction_kes()
    return ipairs(cm:get_human_factions());
end

function vco:trigger_faction_missions(faction_key)
    local campaign_name = cm:get_campaign_name();
    local mission = require("script/victory_conditions/"..faction_key.."/"..campaign_name.."/vo.lua")

    if mission and mission ~= "" then
         cm:trigger_custom_mission_from_string(faction_key, mission)
     end
end

function vco:trigger_custom_missions()
    if cm:is_new_game() then
        for _, faction_key in vco:get_faction_kes() do
            vco:trigger_faction_missions(faction_key);
        end
    end
end

return vco;
