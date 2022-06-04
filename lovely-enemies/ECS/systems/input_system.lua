local util = require "util"
local System = require "ECS.system"
local util = require "util"

return function()
	local input_system = System.new("input_system", {"input"})

	function input_system:update(dt, entity)
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
			input.mouse_left_released = true
		end

	end



	return input_system
end

--[[ OLD
		-- if input.mouse_left_down and not input.mouse_left_clicked then
		-- 	input.mouse_left_clicked = true
		-- end
		
		-- if input.mouse_right_down and not input.mouse_right_clicked then
		-- 	input.mouse_right_clicked = true
		-- end
		
		-- if love.keyboard.isDown("a") then
		-- 	-- input.x = -1
		-- 	input.x = util.lerp(input.x, -1, 0.5)
		-- elseif love.keyboard.isDown("d") then
		-- 	-- input.x = 1
		-- 	input.x = util.lerp(input.x, 1, 0.5)
		-- else
		-- 	-- input.x = 0
		-- 	input.x = util.lerp(input.x, 0, 0.7)
		-- end
		
		-- if love.keyboard.isDown("w") then
		-- 	-- input.y = -1
		-- 	input.y = util.lerp(input.y, -1, 0.5)
		-- elseif love.keyboard.isDown("s") then
		-- 	-- input.y = 1
		-- 	input.y = util.lerp(input.y, 1, 0.5)
		-- else
		-- 	-- input.y = 0
		-- 	input.y = util.lerp(input.y, 0, 0.7)
		-- end
		--]]