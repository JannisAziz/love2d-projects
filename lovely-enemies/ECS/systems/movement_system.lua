local util = require "util"
local System = require "ECS.system"

return function()
	local movement_system = System.new("movement_system", {"position", "velocity"})
	
	function movement_system:update(dt, entity)
		local position = entity:get("position")
		local velocity = entity:get("velocity")

		position.x = position.x + velocity.x * dt
		position.y = position.y + velocity.y * dt

		if velocity.has_drag and velocity.has_input_drag then
			velocity.x = util.lerp(velocity.x, 0, velocity.drag)
			velocity.y = util.lerp(velocity.y, 0, velocity.drag)
		end
	end
	
	return movement_system
end