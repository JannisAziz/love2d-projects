local Component = require('ECS.component')

return function(max) 
	local lifetime = Component.new("lifetime")
	lifetime.current = 0
	lifetime.max = max
	return lifetime
end
