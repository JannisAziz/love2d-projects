local util = require "util"
local System = require "ECS.system"

return function()
	local AI_system = System.new("AI_system", {})
	
	function AI_system:update(dt, entity)
		
	end
	
	return AI_system
end