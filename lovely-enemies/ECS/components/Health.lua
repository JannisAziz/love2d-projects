Health = {}

local Component = require('ECS.core.component')

function Health:new_lifetime(maximum)
	local lifetime = Component.new("lifetime")
	lifetime.current = 0
	lifetime.maximum = maximum or 5
	return lifetime
end

return Health