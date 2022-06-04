local util = require "util"
local System = require "ECS.system"

return function()
	local render_system = System.new("render_system", {"position", "image"})

	local draw_debug = false

	function render_system:draw(entity)
		local position = entity:get("position")
		local image = entity:get("image")

		love.graphics.draw(image.sprite, position.x, position.y, image.rot, 1, 1, image.w/2, image.h/2)

		local print1 = "X: " .. tostring(math.floor(position.x)) .. " Y: " .. tostring(math.floor(position.y))

		if draw_debug then
			love.graphics.print(print1, position.x, position.y)
		end			
	end

	return render_system
end