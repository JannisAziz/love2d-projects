require("lovely-enemies.util")

-- Global components
require("lovely-enemies.ECS.components.Transform")
require('lovely-enemies.ECS.components.Image')
require('lovely-enemies.ECS.components.Input')
require('lovely-enemies.ECS.components.Physics')
require('lovely-enemies.ECS.components.Player')
require('lovely-enemies.ECS.components.Health')

-- Global systems
System = require('lovely-enemies.ECS.core.system')
require("lovely-enemies.ECS.systems.CommonSystems")
require("lovely-enemies.ECS.systems.UserSystems")
require("lovely-enemies.ECS.systems.PhysicsSystems")

-- Global managers
require('lovely-enemies.level_manager')

-- local GUI = require 'UI.gui'

--[[ New E/C/S Templates
	New Entity Template:
		> local instance = World:Create( {Components} )

	New Component Template:
		>	common_components.lua
		>	new_comp = function( var1, var2, ... )
				local comp = Component.new("tag")
					comp.var1 = var1
					comp.var2 = var2
				return comp
			end,
	
	New System Template:
		>	common_systems.lua
		>	new_system = function(dt)
				local system = System.new({"tag1", "tag2"})
				function system:load(entity)
				end
				function system:update(dt, entity) -- OPTIONAL
					local comp1 = entity:get("tag1")
					comp1.var1 = comp1.var1 + dt

					local comp2 = entity:get("tag2")
					comp2.var1 = comp1.var2
				end
				function system:draw() -- OPTIONAL
				end
				return system
			end,
		>	main.lua => love.load() => World:register(System.new_system())

]]

function love.load()
	love.window.setFullscreen(true)

	Level_Manager:load_level("level_2")
	-- GUI:load()

--[[
	local meine_hedi = new_hedi("pretty")
	
    print("Hedi has '" .. meine_hedi.titten .. "' tiddies!!")
	
    World:register(Systems.new_render_system("render_system"))
	
    local cube = World:create("Cube"):madd(Components.new_image_component("Imgs/tileSand1.png")):madd(
		Components.new_position(250, 250)):madd(Components.new_rotation(0))
		
		--World:register(Systems.new_functional_system())
		--World:register(Systems.new_input_system())
		
		--World:register(Systems.new_movement_system())
		
		--World:register(Systems.new_player_controller_system())
		
		--World:register(Systems.new_projectile_system())
		--World:register(Systems.new_projectile_launcher_system())
		
		--New Entity Method 1
		local player = World:create("Player1")
		player:add(Components.new_image_component('Imgs/barrelGreen_top.png'))
		player:add(Components.new_position(100, 100))
		player:add(Components.new_velocity(0, 0, true))
		player:add(Components.new_input())
		player:add(Components.new_controller())
		player:add(Components.new_player())
		player:add(Components.new_projectile_launcher())
		
		--print("WOOP:" .. player:get_all_components())
		
		--player:print_data(player)
		
		local fire_function = Components.functional(function(self, dt)
			local launcher = self:get("projectile_launcher")
			local position = self:get("position")
			local input = self:get("input")
			
			launcher.time_since_last_shot = launcher.time_since_last_shot + dt
			
			if input.fire_down then
				if launcher.time_since_last_shot > launcher.fire_rate then
					launcher.time_since_last_shot = 0
					-- body
					
					local bullet = World:create()
					bullet:madd(Components.new_image_component('Imgs/bulletBlue1.png'), position.x, position.y)
					bullet:madd(Components.new_position(position.x, position.y))
					bullet:madd(Components.new_rotation(0))
					bullet:madd(Components.new_velocity(100, 0))
					bullet:madd(Components.new_projectile())
					
					bullet:print_data()
				end
			end
		end)
		
		--    player:madd(fire_function)
		
		
		--[[ New Entity Method 2
		local test2 = World:assemble({{Components.new_position, 300, 100},
		{Components.new_image_component, 'Imgs/barrelGreen_side.png'}})
		
		local functional_component = Components.functional(function(self, dt)
			local position = self:get("position")
			position.x = position.x + dt * 100
		end)
		
		test2:add(functional_component)
		-- ]]
		--[[
			write_new_component("durim", 
			{"eier", "gamerstuhl"}, 
			{"eier", "knoechel", "gamerstuhl"})
		]]
end

function love.update(dt)
	Level_Manager:update(dt)
	--GUI:update(dt)
end

function love.draw()
	Level_Manager:draw()
	--GUI:draw()
end
