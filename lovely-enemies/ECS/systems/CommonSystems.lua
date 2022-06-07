CommonSystems = {}

function CommonSystems:new_render_system()
	local system = System.new("render_system", {"position", "sprite"})

	local draw_debug = true

	function system:draw(entity)
		local position = entity:get("position")
		local rotation = entity:get("rotation")
		local scale = entity:get("scale")

		local sprite = entity:get("sprite")

		love.graphics.draw(sprite.img, position.x, position.y, rotation and rotation.rot or 0, scale and scale.x or 1, scale and scale.y or 1, sprite.w/2, sprite.h/2)

		if draw_debug then
			local print1 = "X: " .. tostring(math.floor(position.x)) .. " Y: " .. tostring(math.floor(position.y))
			love.graphics.print(print1, position.x, position.y)
		end			
	end

	return system
end

function CommonSystems:new_projectile_spawner_system()

	local system = System.new("projectile_spawner_system", {"position", "input", "player"})
	
	local function spawn_projectile(player, position, input)
		local proj = world:create("Projectile")
		:madd(Transform:new_position(position.x, position.y))
		:madd(Transform:new_rotation())
		:madd(Physics:new_velocity(player.aim_direction_x * player.projectile_speed, player.aim_direction_y * player.projectile_speed, false))
		:madd(Image:new_sprite("Imgs/bulletBlue1.png"))
		:madd(Health:new_lifetime(5))
		:madd(Physics.new_collider(
		function(entity, other_entity)
			if other_entity.tags[1] ~= "Bullet" then
				entity:destroy()
				other_entity:destroy() 
			end
		end))

		proj.tags = { "Bullet" }
		local velocity = proj:get("velocity")
		proj:get("rotation").rot = math.atan2(velocity.y, velocity.x) + math.pi/2
	end

	local cooldown = 0

	function system:update(dt, entity)
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
	
	return system
end

function CommonSystems:new_lifetime_system()
	local system = System.new("lifetime_system", {"lifetime"})
	
	function system:update(dt, entity)
		local lifetime = entity:get("lifetime")
		
		lifetime.current = lifetime.current + dt
		
		if lifetime.current >= lifetime.maximum then
			entity.remove = true
		end
	end
	
	return system
end

function CommonSystems:new_functional_system()
	local system = System.new("functional", {})
	
	function system:update(dt, entity)
		local func = entity:get("functional").func
		func(dt, entity)
	end
	
	return system
end

return CommonSystems