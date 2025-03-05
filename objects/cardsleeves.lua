SMODS.Atlas {
    key = 'prismsleeves',
    path = "cardsleeves.png",
    px = 73,
    py = 95
}
CardSleeves.Sleeve({
    key = "ancientsleeve",
	atlas = "prismsleeves",
	pos = {x = 0, y = 0},
    unlocked = false,
    unlock_condition = {deck = "b_prism_ancient", stake = 5},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() ~= "b_prism_ancient" then
            key = self.key
            self.config = { vouchers = { "v_prism_myth_merchant","v_prism_booster_box"}}
        else
            key = self.key .. "_alt"
            self.config = { matching = true }
        end
        return {key = key}
    end,
    apply = function(self)
        if self.config.matching then G.GAME.modifiers.myth_always_in_shop = true end
        if self.config.vouchers then
            for k, v in pairs(self.config.vouchers) do
                G.GAME.used_vouchers[v ] = true
                G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        Card.apply_to_run(nil, G.P_CENTERS[v])
                        return true
                    end
                }))
            end
        end
    end,
})

local orig_get_pack = get_pack
function get_pack(_key, _type)
    if G.GAME.modifiers.myth_always_in_shop and not G.GAME.prism_shop_legend and G.GAME.first_shop_buffoon and not(
    G.GAME.banned_keys['p_prism_small_myth_1'] and
    G.GAME.banned_keys['p_prism_small_myth_2'] and
    G.GAME.banned_keys['p_prism_mid_myth'] and
    G.GAME.banned_keys['p_prism_large_myth']) then
        G.GAME.prism_shop_legend = true
        local cume, it, center = 0, 0, nil
	    local temp_in_pool = {}
        for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
            local add
            v.current_weight = v.get_weight and v:get_weight() or v.weight or 1
            if (v.kind == "Myth") then add = true end
            if v.in_pool and type(v.in_pool) == 'function' then
                local res, pool_opts = v:in_pool()
                pool_opts = pool_opts or {}
                add = res and (add or pool_opts.override_base_checks)
            end
            if add and not G.GAME.banned_keys[v.key] then cume = cume + (v.current_weight or 1); temp_in_pool[v.key] = true end
        end
        local poll = pseudorandom(pseudoseed((_key or 'pack_generic')..G.GAME.round_resets.ante))*cume
        for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
            if temp_in_pool[v.key] then
                it = it + (v.current_weight or 1)
                if it >= poll and it - (v.current_weight or 1) <= poll then center = v; break end
            end
        end
        return center
    end
    return orig_get_pack(_key, _type)
end

CardSleeves.Sleeve({
    key = "marketsleeve", 
	atlas = "prismsleeves",
	pos = {x = 1, y = 0},
    unlocked = false,
    unlock_condition = {deck = "b_prism_market", stake = 6},
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() ~= "b_prism_market" then
            key = self.key
            self.config = { vouchers = { "v_overstock_norm","v_reroll_surplus"}}
        else
            key = self.key .. "_alt"
            self.config = { voucher = 'v_prism_booster_box' }
        end
        return {key = key}
    end,
})