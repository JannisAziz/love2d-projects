local Component = require('ECS.component')

return function()
	local input = Component.new("input")
	input.x = 0
	input.y = 0
	
	input.mouse_x = 0
	input.mouse_y = 0

	-- Mouse button held down
	input.mouse_left_down = false
	input.mouse_right_down = false
	
	-- Mouse button was pressed
	input.mouse_left_pressed = false
	input.mouse_right_pressed = false

	-- Todo: released should only be true during the frame it was released
	-- Mouse button was released
	input.mouse_left_released = true
	input.mouse_right_released = true
	return input
end
