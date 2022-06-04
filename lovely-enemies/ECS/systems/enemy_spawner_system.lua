local util = require "util"
local System = require "ECS.system"

return function()
	local enemy_spawner_system = System.new("enemy_spawner_system", {})
	
	local function spawn_enemy_random(dt)
		
		local screen_x, screen_y, screen_w, screen_h = love.window.getSafeArea()

		local random_pos = {
			x = math.random(0, screen_w),
			y = math.random(0, screen_h),
		}
				
		local target_direction = {
			x = screen_w/2 - random_pos.x,
			y = screen_h/2 - random_pos.y
		}
		local len = math.sqrt(target_direction.x * target_direction.x + target_direction.y * target_direction.y)

		local move_speed = 100

		local target_velocity = {
			x = target_direction.x / len * move_speed,
			y = target_direction.y / len * move_speed,
		}


		local enemy = World:create("Enemy" .. math.random())
		:madd(Components.new_position(random_pos.x, random_pos.y))
		:madd(Components.new_velocity(target_velocity.x, target_velocity.y, false))
		:madd(Components.new_image("Imgs/tank_red.png"))
		:madd(Components.new_collider())
		:madd(Components.new_lifetime(10))
	end

	local spawn_cooldown = 0
	local spawn_frequency = 5

	function enemy_spawner_system:update(dt, entity)
		spawn_cooldown = spawn_cooldown - dt
		
		if spawn_cooldown <= 0 then
			spawn_cooldown = spawn_frequency

			spawn_enemy_random(dt)
		end
	end
	
	return enemy_spawner_system
end