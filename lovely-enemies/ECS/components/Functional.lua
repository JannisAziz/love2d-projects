Functional = {}

local Component = require('ECS.core.component')

function Functional:new_functional(func)
	local functional = Component.new("functional")
	functional = func
	return functional
end

return Functional