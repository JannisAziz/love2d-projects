local Component = require('ECS.component')

return function(on_collision)
	local collider = Component.new("collider")
	collider.x = 0
	collider.y = 0
	collider.w = 0
	collider.h = 0
	collider.rot = 0
	collider.on_collision = on_collision or function(entity, other_entity) end
	return collider
end