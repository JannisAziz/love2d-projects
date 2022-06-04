local Component = require('ECS.component')

return function(x, y)
	local position = Component.new("position")
	position.x = x
	position.y = y
	return position
end