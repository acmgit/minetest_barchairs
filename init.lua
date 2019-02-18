--[[
	**********************************************
	***             Barchair                   ***
    ***                                        ***
    ***  Barchair is a Mod for Minetest        ***
    ***  and adds some simple Barchairs to     ***
    ***  the Game.                             ***
    ***                                        ***
    ***  License: GPL 3.0 by A.C.M.            ***
    ***                                        ***
	**********************************************
			
]]--

local mod
local mat
local burn

barchair = {}

barchair.modname = minetest.get_current_modname()
barchair.modpath = minetest.get_modpath(barchair.modname)
barchair.version = 1
barchair.revision = 1

local material = {}

-- Various default Wood
material = {
        -- Mod , Material, burnvalue
        {"default:", "wood", 15 },
        {"default:", "junglewood", 15 },
        {"default:", "aspen_wood", 15 },
        {"default:", "pine_wood", 15 },
        {"default:", "acacia_wood", 15 },
    
        --glasslike
        {"default:", "obsidian", 0 },
        {"default:", "ice", 0 },
        {"default:", "diamondblock", 0 },
        {"default:", "mese", 0 },
        -- trees
        {"default:", "aspen_tree", 17 },
        {"default:", "acacia_tree", 17 },
        {"default:", "pine_tree", 17 },
        {"default:", "jungletree", 17 },
        {"default:", "tree", 17 },
    
        -- other
        {"default:", "cactus", 12 },
        {"default:", "coral_skeleton", 0 },
    
        -- metal
        {"default:", "goldblock", 0 },
        {"default:", "bronzeblock", 0 },
        {"default:", "tinblock", 0 },
        {"default:", "copperblock", 0 },
        {"default:", "steelblock", 0 },
}

--[[
***************************************************************
                Function register_barchair()

mod = String of the current modname like "default:"
mat = Material, is the name of the node lide "dirt"
burnvalue = Is the Chair burnable? 0 = not burnable, >= how long takes it to burn
            If you don't give a valid Number, burnvalue = 0 and the chair is unburnable.

***************************************************************
]]--

function barchair.register_barchair(mod, mat, burnvalue)
    
    if(mod == "" or mod == nil) then
        return
        
    end -- if(mod ==
        
    if(mat == "" or mat == nil) then
        return
    
    end -- if(mat ==
        
    if(burnvalue == nil or burnvalue < 0) then 
        burnvalue = 0
        
    end -- if(burnvalue
    
    mod = string.match(mod, "%w+%:-")
    
    if(minetest.registered_nodes[mod ..":" .. mat] ~= nil) then 
                
        -- Barchair
        minetest.register_node(":" .. barchair.modname .. ":barchairs_plain_" .. mod .. "_" .. mat, {
            description = "Barchair plain " .. mod .. mat,
            tiles = minetest.registered_nodes[mod .. ":" .. mat].tiles,
            groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
            sounds = default.node_sound_wood_defaults(),
            drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = "facedir",
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.1875, 0.125, -0.25, 0.1875, 0.25, 0.1875}, -- Barchair
                    {-0.1875, -0.5, -0.25, -0.125, 0.25, -0.1875}, -- Bein_vl
                    {0.125, -0.5, 0.125, 0.1875, 0.25, 0.1875}, -- Bein_hr
                    {-0.1875, -0.5, 0.125, -0.125, 0.25, 0.1875}, -- Bein_hl
                    {0.125, -0.5, -0.25, 0.1875, 0.25, -0.1875}, -- Bein_vr
                    {-0.125, -0.3125, -0.25, 0.125, -0.25, -0.1875}, -- Quer_l
                    {-0.125, -0.3125, 0.125, 0.125, -0.25, 0.1875}, -- Quer_r
                    {-0.1875, -0.3125, -0.1875, -0.125, -0.25, 0.125}, -- Quer_h
                    {0.125, -0.3125, -0.1875, 0.1875, -0.25, 0.1875}, -- Quer_v
                }
            },
            on_place = minetest.rotate_node,
            on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                if not clicker:is_player() then
                    return itemstack
                end
                pos.y = pos.y-0.5
                clicker:setpos(pos)
                return itemstack
            end
                                                               
        }) -- minetest.register_node

    
        minetest.register_craft({
            output = barchair.modname .. ":barchairs_plain_" .. mod .. "_" .. mat .. " 2",
            recipe = {
                    {"",mod .. ":" .. mat,""},
                    {"default:stick","","default:stick"},
                    {"default:stick",mod .. ":" .. mat,"default:stick"}
            },
        }) -- minetest.register_craft
        
        if(burn > 0) then
                minetest.register_craft({
                    type = "fuel",
                    recipe = barchair.modname .. ":barchairs_plain_" .. mat,
                    burntime = burn,
                }) -- minetest.register_craft
                
        end -- if(burn

        -- Bar
            
        -- Bar Front
        minetest.register_node(":" .. barchair.modname .. ":bar_front_" .. mod .. "_" .. mat, {
            description = "Bar front " .. mod .. "_" .. mat,
            tiles = minetest.registered_nodes[mod .. ":" .. mat].tiles,
            groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
            sounds = default.node_sound_wood_defaults(),
            drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = "facedir",
            node_box = {
                type = "fixed",
                fixed = {
                            {0.0625, -0.5, -0.5, 0.1875, 0.5, 0.5}, -- Front
                            {0.0625, 0.375, -0.5, 0.5, 0.5, 0.5}, -- Top
                            {0, -0.5, 0.375, 0.0625, 0.5, 0.4375}, -- Deco_1
                            {0, -0.5, 0.125, 0.0625, 0.5, 0.1875}, -- Deco_2
                            {0, -0.5, -0.125, 0.0625, 0.5, -0.0625}, -- Deco_3
                            {0, -0.5, -0.375, 0.0625, 0.5, -0.3125}, -- Deco_4
                     
                        }
                    
                }, -- node_box
                                                             
            on_place = minetest.rotate_node,
                                           
        }) -- minetest.register_node

        -- Recipe
        minetest.register_craft({
            output = barchair.modname .. ":bar_front_" .. mod .. "_" .. mat .. " 2",
            recipe = {
                    {"",mod .. ":" .. mat,""},
                    {"default:stick","default:stick","default:stick"},
                    {"",mod .. ":" .. mat,""}
            },
        }) -- minetest.register_craft
        
        -- Recipe full
        if(burn > 0) then
                minetest.register_craft({
                    type = "fuel",
                    recipe = barchair.modname .. ":bar_front_" .. mod .. "_" .. mat,
                    burntime = burn + 2,
                }) -- minetest.register_craft
                
        end -- if(burn

        -- Bar Corner left
        minetest.register_node(":" .. barchair.modname .. ":bar_corner_left_" .. mod .. "_" .. mat, {
            description = "Bar corner left " .. mod .. "_" .. mat,
            tiles = minetest.registered_nodes[mod .. ":" .. mat].tiles,
            groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
            sounds = default.node_sound_wood_defaults(),
            drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = "facedir",
            node_box = {
                type = "fixed",
                fixed = {
                            {-0.5, -0.5, -0.1875, 0.5, 0.5, -0.0625}, -- Front
                            {-0.5, 0.375, -0.5, 0.5, 0.5, -0.0625}, -- Top
                            {-0.4375, -0.5, -0.0625, -0.375, 0.5, -0}, -- Deco_1
                            {-0.1875, -0.5, -0.0625, -0.125, 0.5, -0}, -- Deco_2
                            {0.0625, -0.5, -0.0625, 0.125, 0.5, -0}, -- Deco_3
                            {0.3125, -0.5, -0.0625, 0.375, 0.5, -0}, -- Deco_4
                            {-0.5, -0.5, -0.5, -0.375, 0.5, -0.125}, -- Side_r
                     
                        }
                    
                }, -- node_box
                                                             
            on_place = minetest.rotate_node,
                                           
        }) -- minetest.register_node
        
        -- Recipe
        minetest.register_craft({
            output = barchair.modname .. ":bar_corner_left_" .. mod .. "_" .. mat .. " 2",
            recipe = {
                    {mod .. ":" .. mat,"",""},
                    {"default:stick","default:stick","default:stick"},
                    {mod .. ":" .. mat, "",""}
            },
        }) -- minetest.register_craft
        
        -- Recipe full
        if(burn > 0) then
                minetest.register_craft({
                    type = "fuel",
                    recipe = barchair.modname .. ":bar_corner_left_" .. mod .. "_" .. mat,
                    burntime = burn + 2,
                }) -- minetest.register_craft
                
        end -- if(burn

        -- Bar Corner right
        minetest.register_node(":" .. barchair.modname .. ":bar_corner_right_" .. mod .. "_" .. mat, {
            description = "Bar corner right " .. mod .. "_" .. mat,
            tiles = minetest.registered_nodes[mod .. ":" .. mat].tiles,
            groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
            sounds = default.node_sound_wood_defaults(),
            drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = "facedir",
            node_box = {
                type = "fixed",
                fixed = {
                            {-0.5, -0.5, 0.0625, 0.5, 0.5, 0.1875}, -- Front
                            {-0.5, 0.375, 0.0625, 0.5, 0.5, 0.5}, -- Top
                            {-0.4375, -0.5, 0, -0.375, 0.5, 0.0625}, -- Deco_1
                            {-0.1875, -0.5, 0, -0.125, 0.5, 0.0625}, -- Deco_2
                            {0.0625, -0.5, 0, 0.125, 0.5, 0.0625}, -- Deco_3
                            {0.3125, -0.5, 0, 0.375, 0.5, 0.0625}, -- Deco_4
                            {-0.5, -0.5, 0.125, -0.375, 0.5, 0.5}, -- Side_r

                        }
                    
                }, -- node_box
                                                             
            on_place = minetest.rotate_node,
                                           
        }) -- minetest.register_node

        -- Recipe
        minetest.register_craft({
            output = barchair.modname .. ":bar_corner_right_" .. mod .. "_" .. mat .. " 2",
            recipe = {
                    {"", "", mod .. ":" .. mat},
                    {"default:stick","default:stick","default:stick"},
                    {"", "", mod .. ":" .. mat}
            },
        }) -- minetest.register_craft
        
        -- Recipe full
        if(burn > 0) then
                minetest.register_craft({
                    type = "fuel",
                    recipe = barchair.modname .. ":bar_corner_right_" .. mod .. "_" .. mat,
                    burntime = burn + 2,
                }) -- minetest.register_craft
                
        end -- if(burn

        -- Bar Side
        minetest.register_node(":" .. barchair.modname .. ":bar_side_" .. mod .. "_" .. mat, {
            description = "Bar side " .. mod .. "_" .. mat,
            tiles = minetest.registered_nodes[mod .. ":" .. mat].tiles,
            groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
            sounds = default.node_sound_wood_defaults(),
            drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = "facedir",
            node_box = {
                type = "fixed",
                fixed = {
                            {-0.5, -0.5, -0.4375, 0.5, 0.5, -0.3125}, -- Front
                            {-0.5, 0.375, -0.5, 0.5, 0.5, -0.0625}, -- Top
                            {0.375, -0.5, -0.5, 0.4375, 0.5, -0.4375}, -- Deco_1
                            {0.0625, -0.5, -0.5, 0.125, 0.5, -0.4375}, -- Deco_2
                            {-0.125, -0.5, -0.5, -0.0625, 0.5, -0.4375}, -- Deco_3
                            {-0.375, -0.5, -0.5, -0.3125, 0.5, -0.4375}, -- Deco_4
                     
                        }
                    
                }, -- node_box
                                                             
            on_place = minetest.rotate_node,
                                           
        }) -- minetest.register_node

        -- Recipe
        minetest.register_craft({
            output = barchair.modname .. ":bar_side_" .. mod .. "_" .. mat .. " 2",
            recipe = {
                    {"","default:stick",""},
                    {mod .. ":" .. mat,"default:stick",mod .. ":" .. mat},
                    {"","default:stick",""}
            },
        }) -- minetest.register_craft
        
        -- Recipe full
        if(burn > 0) then
                minetest.register_craft({
                    type = "fuel",
                    recipe = barchair.modname .. ":bar_side_" .. mod .. "_" .. mat,
                    burntime = burn + 2,
                }) -- minetest.register_craft
                
        end -- if(burn
            
        minetest.log("info", "[MOD] Barchairs: " .. mod .. ":" .. mat .. " registered.")
        
    else
        minetest.log("warning", "[MOD] Barchairs: " .. mod .. ":" .. mat .. " not found to register.")
        
    end -- if(minetest.registered_nodes

end -- function barchair.register_barchair(

for _,kind in pairs(material) do
    
    mod = kind[1]               -- Modname
    mat = kind[2]               -- Materialname (for the Textur)
    burn = kind[3]              -- Burnvalue > 0 = burnable
    -- print( mod, mat, burn)
    
    barchair.register_barchair(mod, mat, burn)
    
end -- for

--[[
minetest.register_chatcommand(modname .. "_version",{
    
    params = "<>",
    description = "Shows the current Version of " .. modname,
    func = function (name)
        
        minetest.chat_send_player(name, "Mod: " .. modname .. " v " .. version .. "." .. revision .. "\n")
        
    end -- function

}) -- chatcommand prospector_version
]]--
    
print("[MOD]" .. barchair.modname .. " Version " .. barchair.version .. "." .. barchair.revision .. " successfully loaded.")
