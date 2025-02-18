return {
    descriptions = {
        Joker = {
            j_prism_exotic_card = {
                name = "Exotic Card",
                text = {"Retrigger all",
                    "played {C:attention}Enhanced{} cards"
                },
            },
            j_prism_razor_blade = {
                name = "Razor Blade",
                text = {"Destroy {C:attention}lowest{} played card and adds", 
                    "{C:attention}double{} its rank to mult",
                },
            },
            j_prism_harlequin = {
                name = "Harlequin",
                text = {"This Joker gains {X:mult,C:white} X#1# {} Mult",
                    "when the first played card",
                    "of each {C:attention}Suit{} is scored",
                    "{C:inactive}(Currently {X:mult,C:white}X#2# {C:inactive} Mult)",
                },
            },
            j_prism_medusa = {
                name = "Gorgon",
                text = {"All played {C:attention}face{} cards",
                    "become {C:attention}Stone{} cards",
                    "when scored",
                },
            },
            j_prism_rich_joker = {
                name = "Rich Joker",
                text = {"{C:green}#1# in #2#{} chance to earn",
                    "{C:money}$#3#{} for each card {C:attention}sold{}",
                },
            },
            j_prism_air_balloon = {
                name = "Hot Air Balloon",
                text = {"This joker gains Chips equal",
                    "to {C:attention}highest{} rank held in hand",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                },
            },
            j_prism_ghost = {
                name = "Occultist",
                text = {"{C:red}+#1#{} Mult per {C:spectral}Spectral{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:red}+#2#{C:inactive} Mult)",
                },
            },
            j_prism_prism = {
                name = "Prism",
                text = {"{C:attention}Numbered{} cards",
                    "count as every suit"
                },
            },
            j_prism_minstrel = {
                name = "Minstrel",
                text = {"Create a {C:myth}Myth{} card",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Must have room)",
                },
            },
            j_prism_geo_hammer = {
                name = "Geologist Hammer",
                text = {"When round begins, turn a",
                    "random card in hand into",
                    "a {C:attention}Crystal{} or {C:attention}Stone{} card",
                    "{C:inactive}(Ignores Enhanced cards)"
                },
            },
            j_prism_vaquero = {
                name = "Vaquero",
                text = {"Played {C:attention}Wild Crads{}",
                    "give {X:mult,C:white} X#1# {} Mult",
                    "when scored"
                },
            },
            j_prism_promotion = {
                name = "Promotion",
                text = {"If {C:attention}first hand{} of round",
                    "has only {C:attention}1{} card,",
                    "turn it into a {C:attention}Queen"
                },
            },
        },
        Enhanced = {
            m_prism_crystal = {
                name = "Crystal Card",
                text = {"{X:mult,C:white} X#1#{} Mult",
                    "Gains {X:mult,C:white} X#2#{} Mult if held in",
                    "hand at end of round"
                }

            },
            m_prism_burnt = {
                name = "Burnt Card",
                text = {"Draw {C:attention}#1#{} more",
                    "cards after this",
                    "card is {C:attention}discarted"
                }
            },
            m_prism_double = {
                name = "Double Card",
                text = {"Can turn into",
                    "{C:attention}#1#{}"
                }
            },
            m_prism_echo = {
                name = "Echo Card",
                text = {"{C:attention}Retrigger{} this card",
                    "for each other {C:attention}Echo",
                    "{C:attention}Card{} played or held"
                }
            },
        },
        Myth = {
            c_prism_myth_druid = {
                name = "Druid",
                text = {"Select {C:attention}#1#{} cards,",
                    "adds the {C:attention}right{} card's",
                    "{C:enhanced}Enhacement{}, {C:dark_edition}Edition{} and",
                    "{C:attention}Seal{} to the {C:attention}left{} card"
                }

            },
            c_prism_myth_dwarf = {
                name = "Dwarf",
                text = {"Enhances {C:attention}#1#{}",
                    " selected cards to",
                    "{C:attention}Crytsal Cards"
                }
            },
            c_prism_myth_siren = {
                name = "Siren",
                text = {"Enhances {C:attention}#1#{}",
                    " selected cards to",
                    "{C:attention}Echo Cards"
                }
            },
            c_prism_myth_dragon = {
                name = "Dragon",
                text = {"Enhances {C:attention}#1#{}",
                    " selected cards to",
                    "{C:attention}Burnt Cards"
                }
            },
            c_prism_myth_twin = {
                name = "Twin",
                text = {"Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Double Cards",
                    "{C:inactive}(Doubling each other)"
                }
            },
            c_prism_myth_wizard = {
                name = "Wizard",
                text = {"Converts up to {C:attention}#1#{}",
                    "selected cards to",
                    "the {C:attention}right{} card's {C:attention}Rank{}"
                }
            },
            c_prism_myth_gnome = {
                name = "Gnome",
                text = {"Earn {C:money}$#1#{}-{C:money}$#2#{}"
                }
            },
            c_prism_myth_mirror = {
                name = "Mirror",
                text = {"Add {C:dark_edition}Negative{}",
                    "to {C:attention}1{} random",
                    "card in hand"
                }
            },
            c_prism_myth_colossus = {
                name = "Colossus",
                text = {"Add a {C:moon}Moon Seal{}",
                    "to {C:attention}#1#{} selected",
                    "card in your hand"
                }
            },
            c_prism_myth_beast = {
                name = "Questing Beast",
                text = {"Create a random",
                    "{C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)"
                }
            },
            c_prism_myth_ooze = {
                name = "Ooze",
                text = {"Add a {C:green}Green Seal{}",
                    "to {C:attention}#1#{} selected",
                    "cards in your hand"
                }
            },
            c_prism_myth_roc = {
                name = "Roc",
                text = {"Create a random {C:attention}Tag"
                }
            },
            c_prism_myth_kraken = {
                name = "Kraken",
                text = {"Create a random {C:attention}Tag"
                }
            },
        },
        Voucher = {
            v_prism_myth_merchant = {
                name = "Myth Merchant",
                text = {
                    "{C:myth} Myth{} cards appear",
                    "{C:attention}2X{} more frequently",
                    "in the shop",
                },
            },
            v_prism_myth_tycoon = {
                name = "Myth Tycoon",
                text = {
                    "{C:myth} Myth{} cards appear",
                    "{C:attention}4X{} more frequently",
                    "in the shop",
                },
            },

        },
        Other = {
            p_prism_small_myth_1 = {
                name = "Legend Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:myth} Myth{} cards",
                },
            },
            p_prism_small_myth_2 = {
                name = "Legend Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:myth} Myth{} cards",
                },
            },
            p_prism_mid_myth = {
                name = "Jumbo Legend Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:myth} Myth{} cards",
                },
            },
            p_prism_large_myth = {
                name = "Mega Legend Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:myth} Myth{} cards",
                },
            },
            prism_green_seal = {
                name = "Green Seal",
                text = {"Always scores"
                },
            },
            prism_moon_seal = {
                name = "Moon Seal",
                text = {"{C:green}#1# in #2#{} chance to",
                    "upgrade level of played",
                    "{C:attention}poker hand{} when is",
                    "played and scoring"
                },
            },
        },
    },
    misc = {
        dictionary = {
            k_stone = "Stone",
            k_promoted = "Promoted!",
            k_prism_myth_pack = "Legend Pack",
        },
        labels = {
            prism_green_seal = "Green Seal",
            prism_moon_seal = "Moon Seal"
        }
    }
}

