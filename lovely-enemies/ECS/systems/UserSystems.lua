UserSystems = {}

function UserSystems:new_input_system()
	local system = System.new("input_system", {"input"})

	function system:update(dt, entity)
		local input = entity:get("input")

		input.x = love.keyboard.isDown("a") and -1 or love.keyboard.isDown("d") and 1 or 0
		input.y = love.keyboard.isDown("w") and -1 or love.keyboard.isDown("s") and 1 or 0

		input.mouse_x = love.mouse.getX()
		input.mouse_y = love.mouse.getY()
		input.mouse_left_down = love.mouse.isDown(1)
		input.mouse_right_down = love.mouse.isDown(2)

		if input.mouse_left_down then
			if not input.mouse_left_pressed and input.mouse_left_released then
				input.mouse_left_pressed = true
				input.mouse_left_released = false
			else
				input.mouse_left_pressed = false
			end
		else
			if not input.mouse_left_released then
				input.mouse_left_released = true
			end
		end
		-- Todo: released should only be true during the frame it was released

	end

	return system
end

function UserSystems:new_controller_system()
	local system = System.new("controller_system", {"player", "sprite", "position", "rotation", "velocity", "input"})
	
	local responsiveness_factor = 0.1
	local target_velocity_x = 0
	local target_velocity_y = 0

	function system:update(dt, entity)
		local player = entity:get("player")
		local sprite = entity:get("sprite")
		local position = entity:get("position")
		local rotation = entity:get("rotation")
		local velocity = entity:get("velocity")
		local input = entity:get("input")

		local mouse_dir_x = input.mouse_x - position.x
		local mouse_dir_y = input.mouse_y - position.y

		local len = math.sqrt(mouse_dir_x * mouse_dir_x + mouse_dir_y * mouse_dir_y)

		player.aim_direction_x = mouse_dir_x / len
		player.aim_direction_y = mouse_dir_y / len

		rotation.rot = math.atan2(input.mouse_y - position.y, input.mouse_x - position.x) + math.pi/-2

		target_velocity_x = Util.lerp(velocity.x, velocity.x + player.move_speed * input.x, responsiveness_factor)
		target_velocity_y = Util.lerp(velocity.y, velocity.y + player.move_speed * input.y, responsiveness_factor)

		velocity.x = Util.clamp(target_velocity_x, -player.max_speed, player.max_speed)
		velocity.y = Util.clamp(target_velocity_y, -player.max_speed, player.max_speed)

		if not player.has_input_drag then
			if velocity.has_drag and math.abs(input.x) > 0 and math.abs(input.y) > 0 then
				velocity.has_input_drag = false
			else
				velocity.has_input_drag = true
			end
		end
	end

	return system
end

return UserSystems
