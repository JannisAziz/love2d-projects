Transform = {}

local Component = require('ECS.core.component')

function Transform:new_position(x, y)
	local position = Component.new("position")
	position.x = x
	position.y = y
	return position
end

function Transform:new_rotation(rad)
	local rotation = Component.new("rotation")
	rotation.rad = rad or 0
	return rotation
end

function Transform:new_scale(x, y)
	local scale = Component.new("scale")
	scale.x = x or 1
	scale.y = y or x or 1
	return scale
end

return Transform