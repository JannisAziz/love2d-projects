local util = require "util"
local System = require "ECS.system"

return function()
	local projectile_spawner_system = System.new("projectile_spawner_system", {"position", "input", "player"})
	
	local function spawn_projectile(player, position, input)
		local proj = World:create("Projectile")
		:madd(Components.new_position(position.x, position.y))
		:madd(Components.new_velocity(player.aim_direction_x * player.projectile_speed, player.aim_direction_y * player.projectile_speed, false))
		:madd(Components.new_image("Imgs/bulletBlue1.png"))
		:madd(Components.new_lifetime(5))
		:madd(Components.new_collider(
		function(entity, other_entity)
			if other_entity.tags[1] ~= "Bullet" then
				entity:destroy()
				other_entity:destroy() 
			end
		end))

		proj.tags = { "Bullet" }
		local velocity = proj:get("velocity")
		proj:get("image").rot = math.atan2(velocity.y, velocity.x) + math.pi/2
	end

	local cooldown = 0

	function projectile_spawner_system:update(dt, entity)
		local position = entity:get("position")
		local input = entity:get("input")
		local player = entity:get("player")

		cooldown = cooldown - dt

		if input.mouse_left_down then
			if cooldown <= 0 then
				spawn_projectile(player, position, input)
				cooldown = player.fire_rate
			end
		end
	end
	
	return projectile_spawner_system
end