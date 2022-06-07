local util = require "util"
local System = require "ECS.system"

return function()
	local behaviour_tree_system = System.new("behaviour_tree_system", {})

	function behaviour_tree_system:update(entity)
	end
	return behaviour_tree_system
end