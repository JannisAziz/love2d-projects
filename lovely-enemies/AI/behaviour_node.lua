local behaviour_node = {}

local child_nodes = {}

local decorators = {
	conditions = {},
	on_enter = {},
	parallel = {},
	on_exit = {},
}

function behaviour_node:enter()

	-- Check conditional_decorators
	for i = 1, #decorators.conditions do
		if decorators.conditions[i] == false then
			-- short out of node here
			return "abort"
		end
	end

	-- Execute on_enter_decorators
	for i = 1, #decorators.on_enter do
		if decorators.on_enter[i] then
			-- call decorator on_enter functions
			decorators.on_enter[i]()
		end
	end
end

function behaviour_node:run(dt)

	-- Run parallel_decorators
	for i = 1, #decorators.parallel do
		if decorators.parallel[i] then
			-- call decorator parallel functions
			decorators.parallel[i]()
		end
	end

	if root_node:enter() ~= "abort" then
		local result = "running"
		
		-- keep updating node until result is not "running"
		repeat
			result = root_node:run()
		until result ~= "running"
		
		-- call exit on node
		root_node:exit()
	end
	
	-- Loop through nodes
	for _, current_node in child_nodes do
		-- Enter current_node, short circuit if enter returns "abort" (node conditions fail)
		if current_node:enter() ~= "abort" then
			-- set node state to "running"
			local result = "running"
			repeat
				result = current_node:run()
			until result ~= "running"
			current_node:exit(result)
		end
	end

end

function behaviour_node:exit(reason)
	
	-- Execute on_exit_decorators
	for i = 1, #decorators.on_exit do
		if decorators.on_exit[i] then
			-- call decorator on_exit functions
			decorators.on_exit[i](reason)
		end
	end

end

return behaviour_node