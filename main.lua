G.PRISM = {}
G.PRISM.C = {}
G.PRISM.FUNCS = {}
G.PRISM.C.myth_1 = HEX("ABB7A8")
G.PRISM.C.myth_2 = HEX("4A745A")
G.PRISM.PI = "3141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609433057270365759591953092186117381932611793105118548074462379962749567351885752724891227938183011949129833673362440656643086021394946395224737190702179860943702770539217176293176752384674818467669405132000568127145263560827785771342757789609173637178721468440901224953430146549585371050792279689258923542019956112129021960864034418159813629774771309960518707211349999998372978049951059731732816096318595024459455346908302642522308253344685035261931188171010003137838752886587533208381420617177669147303598253490428755468731159562863882353787593751957781857780532171226806613001927876611195909216420198938095257201065485863278865936153381827968230301952035301852968995773622599413891249721775283479131515574857242454150695950829533116861727855889075098381754637464939319255060400927701671139009848824012858361603563707660104710181942955596198946767837449448255379774726847104047534646208046684259069491293313677028989152104752162056966024058038150193511253382430035587640247496473263914199272604269922796782354781636009341721641219924586315030286182974555706749838505494588586926995690927210797509302955321165344987202755960236480665499119881834797753566369807426542527862551818417574672890977772793800081647060016145249192173217214772350141441973568548161361157352552133475741849468438523323907394143334547762416862518983569485562099219222184272550254256887671790494601653466804988627232791786085784383827967976681454100953883786360950680064225125205117392984896084128488626945604241965285022210661186306744278622039194945047123713786960956364371917287467764657573962413890865832645995813390478027590099465764078951269468398352595709825822620522489407726719478268482601476990902640136394437455305068203496252451749399651431429809190659250937221696461515709858387410597885959772975498930161753928468138268683868942774155991855925245953959431"
G.PRISM.config = SMODS.current_mod.config

SMODS.Atlas({
    key = 'modicon',
    path = 'modicon.png',
    px = '34',
    py = '34'
})

local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        lc()
    end
    G.ARGS.LOC_COLOURS.moon = HEX('86ADB3')
	G.ARGS.LOC_COLOURS.myth_light = HEX('80987A')
    return lc(_c, _default)
end


function SMODS.current_mod.reset_game_globals(run_start)
	if run_start then
		G.GAME.pool_flags.day_can_spawn = true
		G.GAME.pool_flags.night_can_spawn = false

		G.GAME.price_scaling = 0
		G.GAME.modifiers.extra_boosters = 0
		G.GAME.prism_start_deck_ranks = {}
		for i, v in pairs(G.playing_cards) do
			local already_added = false
			for _, k in pairs(G.GAME.prism_start_deck_ranks) do
				if not already_added and v.base.id == k then already_added = true end
			end
			if not already_added then table.insert(G.GAME.prism_start_deck_ranks,v.base.id) end
		end
    else
	end
	G.GAME.prism_extra_draw = 0
	G.GAME.prism_shop_legend = false
	if G.GAME.prism_fortune_cookie then
		G.GAME.prism_fortune_cookie = false
		for k, v in pairs(G.GAME.probabilities) do
			G.GAME.probabilities[k] = v / 9999
		end
	end
end

if G.PRISM.config.jokers_enabled then  SMODS.load_file('objects/jokers.lua')() end
if G.PRISM.config.myth_enabled then SMODS.load_file('objects/enhancements.lua')() end
if G.PRISM.config.myth_enabled then SMODS.load_file('objects/myth_cards.lua')() end
SMODS.load_file('objects/vouchers.lua')()
SMODS.load_file('objects/decks.lua')()
SMODS.load_file('objects/tags.lua')()
if G.PRISM.config.blinds_enabled then SMODS.load_file('objects/blinds.lua')() end
SMODS.load_file('objects/challenges.lua')()
SMODS.load_file('objects/stakes.lua')()
if CardSleeves then SMODS.load_file('objects/cardsleeves.lua')() end

SMODS.Sound({
	key = "myth_music",
	path = "myth_music.ogg",
	select_music_track = function()
		return G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.cards[1].ability.set == "Myth"
	end,
})

function G.PRISM.create_booster()
	G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
	if not G.GAME.current_round.used_packs[1] then
		G.GAME.current_round.used_packs[1] = get_pack('shop_pack').key
	end

	if G.GAME.current_round.used_packs[1] ~= 'USED' then 
		local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
		G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[1]], {bypass_discovery_center = true, bypass_discovery_ui = true})
		create_shop_card_ui(card, 'Booster', G.shop_booster)
		card.ability.booster_pos = 1
		card:start_materialize()
		G.shop_booster:emplace(card)
	end
end
--For Talisman Compatibility
function bignum(x)
	if Talisman then
		return to_big(x)
	else 
		return x
	end
end

SMODS.current_mod.config_tab = function()
	return {
	  n = G.UIT.ROOT,
	  config = { align = 'cm', padding = 0.07, emboss = 0.05, r = 0.1, colour = G.C.BLACK, minh = 4.5 ,minw = 7 },
	  nodes = {
		{
			n = G.UIT.R,
			config = { align = 'cm'},
			nodes = {
				{ n = G.UIT.T, config = { text = localize('prism_feature_enable'), colour = G.C.WHITE, scale = 0.5 }},
			}
		},
		{
			n = G.UIT.R,
			config = { align = 'cm', minh = 0.6 },
			nodes = {
				{ n = G.UIT.T, config = { text = localize('prism_requires_restart'), colour = G.C.RED, scale = 0.4 }},
			}
		},
		{
		  n = G.UIT.R,
		  nodes = {
			{
			  n = G.UIT.C,
			  nodes = {
				create_toggle {
				  label = localize('prism_jokers_enabled'),
				  ref_table = G.PRISM.config,
				  ref_value = 'jokers_enabled',
				},
				create_toggle {
					label = localize('prism_myth_enabled'),
					ref_table = G.PRISM.config,
					ref_value = 'myth_enabled',
				},
				create_toggle {
					label = localize('prism_blinds_enabled'),
					ref_table = G.PRISM.config,
					ref_value = 'blinds_enabled',
				  },
			  }
			},
		  }
		}
	  }
	}
  end