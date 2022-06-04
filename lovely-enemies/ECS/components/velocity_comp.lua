local Component = require('ECS.component')

return function(x, y, has_drag)
	local velocity = Component.new("velocity")
	velocity.x = x
	velocity.y = y
	velocity.drag = 0.05
	velocity.has_drag = has_drag
	velocity.has_input_drag = false
	return velocity
end