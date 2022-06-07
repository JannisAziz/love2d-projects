local level = {}

world = require 'ECS.core.world'

local function register_systems()
	world:register(CommonSystems:new_render_system())
	world:register(PhysicsSystems:new_movement_system())
	world:register(UserSystems:new_input_system())
	world:register(UserSystems:new_controller_system())
	world:register(CommonSystems:new_projectile_spawner_system())
	world:register(CommonSystems:new_lifetime_system())
	world:register(PhysicsSystems:new_collider_system())
end

function level:load()
	register_systems()

	-- Create objects	
	world:create("Barrel_1")
	:madd(Image:new_sprite("Imgs/barrelGreen_top.png"))
	:madd(Transform:new_position(100, 100))

	world:create("Barrel_2")
	:madd(Image:new_sprite("Imgs/barrelGreen_top.png"))
	:madd(Transform:new_position(300, 100))
	:madd(Physics:new_collider())
	
	world:create("Barrel_3")
	:madd(Image:new_sprite("Imgs/barrelGreen_top.png"))
	:madd(Transform:new_position(500, 100))
	:madd(Physics:new_collider())

	world:create("Player")
	:madd(Image:new_sprite("Imgs/tank_blue.png"))
	:madd(Transform:new_position(300, 300))
	:madd(Transform:new_rotation())
	:madd(Transform:new_scale(0.5))
	:madd(Physics:new_velocity())
	:madd(Input:new_input())
	:madd(Player:new_player(100, 100))
end

function level:unload()
	world = nil
end

function level:update(dt)
    world:update(dt)
end

function level:draw()
    world:draw()
end

return level