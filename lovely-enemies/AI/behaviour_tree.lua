--- Behaviour Trees are executors of decisions, they EXECUTE sequences of decisions

local BehaviourTree = {}

local __id = -1

local root_node = {}

local is_active = false

local active_node = {}

function BehaviourTree:init(id)
	__id = id
end

function BehaviourTree:enter()
	is_active = true

	-- Enter root_node, short circuits if it returns "abort" (node conditions fail)
	if root_node:enter() ~= "abort" then
		-- Set active_node to root_node
		active_node = root_node
	else
		return "abort"
	end
end


function BehaviourTree:run(dt)

	-- Update active_node
	local result = active_node:run(dt)

	-- If result "done" or "failed" exit node 
	if result == "done" or "failed" then
		return active_node:exit(result)
	end

	--[[ OLD
	-- Enter node, short circuit if enter returns "abort" (node conditions fail)
	if root_node:enter() ~= "abort" then
		-- set node state to "running"
		local result = "running"
		
		-- keep updating node until result is not "running"
		repeat
			result = root_node:run()
		until result ~= "running"
		
		-- call exit on node
		root_node:exit()
	end
	]]

end

function BehaviourTree:exit(reason)
	active_node = nil
	is_active = false
end

return BehaviourTree