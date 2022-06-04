local util = require "util"
local System = require "ECS.system"

return function()
	local controller_system = System.new("controller_system", {"velocity", "input", "player"})
	
	local responsiveness_factor = 0.1
	local target_velocity_x = 0
	local target_velocity_y = 0

	function controller_system:update(dt, entity)
		local velocity = entity:get("velocity")
		local input = entity:get("input")
		local player = entity:get("player")
		local image = entity:get("image")
		local position = entity:get("position")

		local mouse_dir_x = input.mouse_x - position.x
		local mouse_dir_y = input.mouse_y - position.y

		local len = math.sqrt(mouse_dir_x * mouse_dir_x + mouse_dir_y * mouse_dir_y)

		player.aim_direction_x = mouse_dir_x / len
		player.aim_direction_y = mouse_dir_y / len

		image.rot = math.atan2(input.mouse_y - position.y, input.mouse_x - position.x) + math.pi/-2

		target_velocity_x = util.lerp(velocity.x, velocity.x + player.move_speed * input.x, responsiveness_factor)
		target_velocity_y = util.lerp(velocity.y, velocity.y + player.move_speed * input.y, responsiveness_factor)

		velocity.x = util.clamp(target_velocity_x, -player.max_speed, player.max_speed)
		velocity.y = util.clamp(target_velocity_y, -player.max_speed, player.max_speed)

		if not player.has_input_drag then
			if velocity.has_drag and math.abs(input.x) > 0 and math.abs(input.y) > 0 then
				velocity.has_input_drag = false
			else
				velocity.has_input_drag = true
			end
		end
	end

	return controller_system
end