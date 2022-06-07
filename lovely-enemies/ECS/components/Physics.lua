Physics = {}

local Component = require('ECS.core.component')

function Physics:new_velocity(x, y, has_drag)
	local velocity = Component.new("velocity")
	velocity.x = x or 0
	velocity.y = y or 0
	velocity.drag = 0.05
	velocity.has_drag = has_drag or true
	velocity.has_input_drag = false
	return velocity
end

function Physics:new_collider(on_collision)
	local collider = Component.new("collider")
	collider.x = 0
	collider.y = 0
	collider.w = 0
	collider.h = 0
	collider.rot = 0
	collider.on_collision = on_collision or function(entity, other_entity) end
	return collider
end

return Physics