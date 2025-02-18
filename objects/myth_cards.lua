SMODS.Atlas({
    key = 'prismmyth',
    path = 'myth.png',
    px = '71',
    py = '95'
})
SMODS.Atlas({
    key = 'prismboosters',
    path = 'boosters.png',
    px = '71',
    py = '95'
})
SMODS.ConsumableType({
    key = "Myth",
    primary_colour = G.PRISM.C.myth_1,
    secondary_colour = G.PRISM.C.myth_2,
    loc_txt = {
        name = "Myth Card",
        collection = "Myth Cards",
        undiscovered = {
            name = 'Unknown Myth Card',
            text = {
                'Find this card in an unseeded',
                'run to find out what it does'
            }
        }
    },
    collection_rows = {6, 5},
    shop_rate = 0.6,
    default = 'c_prism_myth_druid'
})
SMODS.UndiscoveredSprite({
    key = "Myth",
    atlas = "prismmyth",
    pos = { x = 0, y = 0 },
    no_overlay = true
})
SMODS.Consumable({
    key = 'myth_druid',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=0, y=1},
    discovered = false,
    config = {max_highlighted = 2},
    loc_vars = function(self, info_queue)
		return { vars = { self.config.max_highlighted } }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= 2
	end,
    use = function(self, card, area, copier)
        local rightmost = G.hand.highlighted[1]
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                local edition = rightmost.edition
                local enhancement = rightmost.config.center.key
                local seal = rightmost.seal
                if G.hand.highlighted[i] ~= rightmost then
                    local leftmost = G.hand.highlighted[i]
                    if not leftmost.edition then leftmost:set_edition(edition) end
                    if leftmost.config.center.key == "c_base" then leftmost:set_ability(G.P_CENTERS[enhancement]) end
                    if not leftmost.seal then leftmost:set_seal(seal) end
                end
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end}))
    end
}) 

SMODS.Consumable({
    key = 'myth_dwarf',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=1, y=0},
    discovered = false,
    config = {mod_conv = "m_prism_crystal", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
SMODS.Consumable({
    key = 'myth_twin',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=2, y=1},
    discovered = false,
    config = {mod_conv = "m_prism_double"},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = {2} }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted == 2
	end,
    use = function(self, card, area, copier)
        local _card_1 = G.hand.highlighted[1]
        local _card_2 = G.hand.highlighted[2]
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.8,func = function()
            for i=1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_prism_double)
            end
            _card_1.ability.extra.card = _card_2.config.card
            _card_2.ability.extra.card = _card_1.config.card
        return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end}))
    end

})
SMODS.Consumable({
    key = 'myth_dragon',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=2, y=0},
    discovered = false,
    config = {mod_conv = "m_prism_burnt", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
SMODS.Consumable({
    key = 'myth_siren',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=6, y=1},
    discovered = false,
    config = {mod_conv = "m_prism_echo", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
SMODS.Consumable({
    key = 'myth_gnome',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=3, y=0},
    discovered = false,
    config = {min_money = 3, max_money = 21},
    loc_vars = function(self, info_queue)
		return { vars = { self.config.min_money,self.config.max_money} }
    end,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        local option = pseudorandom(pseudoseed("gnome"), self.config.min_money, self.config.max_money)
		ease_dollars(option)
	end

})
SMODS.Consumable({
    key = 'myth_wizard',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=1, y=1},
    discovered = false,
    config = {max_highlighted = 3},
    loc_vars = function(self, info_queue)
		return { vars = { self.config.max_highlighted } }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= 2
	end,
    use = function(self, card, area, copier)
        local rightmost = G.hand.highlighted[1]
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        local rank = rightmost.base.id == 14 and 2 or math.min(rightmost.base.id, 14)
        if rank < 10 then rank = tostring(rank)
        elseif rank == 10 then rank = 'T'
        elseif rank == 11 then rank = 'J'
        elseif rank == 12 then rank = 'Q'
        elseif rank == 13 then rank = 'K'
        elseif rank == 14 then rank = 'A'
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                local suit = string.sub(G.hand.highlighted[i].base.suit, 1, 1)..'_'
                G.hand.highlighted[i]:set_base(G.P_CARDS[suit..rank])
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end}))
    end
}) 
SMODS.Consumable({
    key = 'myth_mirror',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=4, y=0},
    discovered = false,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
	end,
    can_use = function(self,card)
        return G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED 
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            local random_card = pseudorandom_element(G.hand.cards, pseudoseed('mirror'))
            if random_card then random_card:set_edition({negative = true}, true) end
        return true end }))
    end

})  
SMODS.Consumable({
    key = 'myth_colossus',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=4, y=1},
    discovered = false,
    config = {seal_conv = "prism_moon", max_highlighted = 1},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_SEALS[self.config.seal_conv]

		return { vars = {self.config.max_highlighted} }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            for i=1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_seal(self.config.seal_conv)
            end
        return true end }))
    end

}) 
SMODS.Consumable({
    key = 'myth_beast',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=3, y=1},
    discovered = false,
    can_use = function(self,card)
        return true 
    end,
    use = function(self, card, area, copier)
        if G.consumeables.config.card_limit > #G.consumeables.cards then
            play_sound('timpani')
            local _card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'beast')
            _card:add_to_deck()
            G.consumeables:emplace(_card)
            card:juice_up(0.3, 0.5)
        end
    end
})
SMODS.Consumable({
    key = 'myth_ooze',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=5, y=0},
    discovered = false,
    config = {seal_conv = "prism_green", max_highlighted = 2},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_SEALS[self.config.seal_conv]

		return { vars = {self.config.max_highlighted} }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            for i=1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_seal(self.config.seal_conv)
            end
        return true end }))
    end
})
SMODS.Consumable({
    key = 'myth_roc',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=6, y=0},
    discovered = false,
    can_use = function(self, card)
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            local tag = pseudorandom_element(G.P_TAGS, pseudoseed('roc')).key
            add_tag(Tag(tag))
        return true end }))
    end
})
SMODS.Consumable({
    key = 'myth_kraken',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=5, y=1},
    discovered = false,
    can_use = function(self, card)
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            local tag = pseudorandom_element(G.P_TAGS, pseudoseed('roc')).key
            add_tag(Tag(tag))
        return true end }))
    end
})

--Boosters
local small_boosters = {keys = {'small_myth_1','small_myth_2'}, info = {
    atlas = 'prismboosters',
    config = {choose = 1, extra = 3},
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Myth", G.pack_cards, nil, nil, true,  true, nil, "mythpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.PRISM.C.myth_1)
        ease_background_colour{new_colour = G.PRISM.C.myth_1, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_prism_myth_pack',
    draw_hand = true,
    cost = 4,
    weight = 1,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.PRISM.C.myth_1, lighten(G.PRISM.C.myth_1, 0.4), lighten(G.PRISM.C.myth_1, 0.2), darken(G.PRISM.C.myth_1, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}}
local mid_boosters = {keys = {'mid_myth'}, info = {
    atlas = 'prismboosters',
    config = {choose = 1, extra = 5},
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Myth", G.pack_cards, nil, nil, true,  true, nil, "mythpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.PRISM.C.myth_1)
        ease_background_colour{new_colour = G.PRISM.C.myth_1, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_prism_myth_pack',
    draw_hand = true,
    cost = 6,
    weight = 1,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.PRISM.C.myth_1, lighten(G.PRISM.C.myth_1, 0.4), lighten(G.PRISM.C.myth_1, 0.2), darken(G.PRISM.C.myth_1, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}}
local large_boosters = {keys = {'large_myth'}, info = {
    atlas = 'prismboosters',
    config = {choose = 2, extra = 5},
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Myth", G.pack_cards, nil, nil, true,  true, nil, "mythpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.PRISM.C.myth_1)
        ease_background_colour{new_colour = G.PRISM.C.myth_1, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_prism_myth_pack',
    draw_hand = true,
    cost = 8,
    weight = 0.25,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.PRISM.C.myth_1, lighten(G.PRISM.C.myth_1, 0.4), lighten(G.PRISM.C.myth_1, 0.2), darken(G.PRISM.C.myth_1, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}}
for i, key in ipairs(small_boosters.keys) do
    local booster_args = {}
    for k,v in pairs(small_boosters.info) do
        booster_args[k] = v
    end
    booster_args.key = key
    booster_args.pos = { x = i - 1, y = 0 }
    booster_args.ortalab_type = 'Myth'
    SMODS.Booster(booster_args)
end
for i, key in ipairs(mid_boosters.keys) do
    local booster_args = {}
    for k,v in pairs(mid_boosters.info) do
        booster_args[k] = v
    end
    booster_args.key = key
    booster_args.pos = { x = i + 1, y = 0 }
    booster_args.ortalab_type = 'Myth'
    SMODS.Booster(booster_args)
end
for i, key in ipairs(large_boosters.keys) do
    local booster_args = {}
    for k,v in pairs(large_boosters.info) do
        booster_args[k] = v
    end
    booster_args.key = key
    booster_args.pos = { x = i + 2, y = 0 }
    booster_args.ortalab_type = 'Myth'
    SMODS.Booster(booster_args)
end