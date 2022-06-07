
local level = {}

World = require 'ECS.world'

local Systems = {
	new_movement_system = require 'ECS.systems.movement_system',
	new_render_system = require 'ECS.systems.render_system',
	new_input_system = require 'ECS.systems.input_system',
	new_controller_system = require 'ECS.systems.controller_system',
	new_projectile_spawner_system = require 'ECS.systems.projectile_spawner_system',
	new_lifetime_system = require 'ECS.systems.lifetime_system',
	new_collision_system = require 'ECS.systems.collision_system',
	new_enemy_spawner_system = require 'ECS.systems.enemy_spawner_system',
	new_AI_system = require 'ECS.systems.AI_system',
}

Components = {
	new_position = require('ECS.components.position_comp'),
	new_velocity = require('ECS.components.velocity_comp'),
	new_image = require('ECS.components.image_comp'),
	new_input = require('ECS.components.input_comp'),
	new_player = require('ECS.components.player_comp'),
	new_lifetime = require('ECS.components.lifetime_comp'),
	new_collider = require('ECS.components.collider_comp'),
}

function level:load()
	
	-- Register world systems
	World:register(Systems.new_movement_system())
	World:register(Systems.new_render_system())

	World:register(Systems.new_input_system())
	World:register(Systems.new_controller_system())

	World:register(Systems.new_projectile_spawner_system())
	World:register(Systems.new_lifetime_system())
	World:register(Systems.new_collision_system())

	World:register(Systems.new_enemy_spawner_system())

	World:register(Systems.new_AI_system())

	local x, y, w, h =  love.window.getSafeArea()

	World:create("Player")
	:madd(Components.new_position(w / 2, h / 2))
	:madd(Components.new_velocity(0,0,true))
	:madd(Components.new_image("Imgs/tank_blue.png"))
	:madd(Components.new_input())
	:madd(Components.new_player(100, 100))

	World:create("Barrel")
	:madd(Components.new_position(w / 2 + 100, h / 2))
	:madd(Components.new_velocity(0,0))
	:madd(Components.new_image("Imgs/barrelGreen_top.png"))
	:madd(Components.new_collider())

	World:create("Barrel2")
	:madd(Components.new_position(w / 2 + 100, h / 2 + 100))
	:madd(Components.new_velocity(0,0))
	:madd(Components.new_image("Imgs/barrelRed_top.png"))
	:madd(Components.new_collider())
end

function level:update(dt)
    World:update(dt)
	
end

function level:draw()
    World:draw()
	local global_entities_count = #World.entities
	love.graphics.print(global_entities_count, 20, 20)
end

return level