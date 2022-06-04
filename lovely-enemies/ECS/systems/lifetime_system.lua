local util = require "util"
local System = require "ECS.system"

return function()
	local lifetime_system = System.new("lifetime_system", {"lifetime"})
	
	function lifetime_system:update(dt, entity)
		local lifetime = entity:get("lifetime")
		
		lifetime.current = lifetime.current + dt
		
		if lifetime.current >= lifetime.max then
			entity.remove = true
		end
	end
	
	return lifetime_system
end