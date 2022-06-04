local util = require 'util'

--[[	Generate new component code
	>	Genereate code as text from name and data
	>	Save to file (Every new component gets new file, existing components get overwritten)

	Usage:

	-- myName is for determining component and file name
	CompGen.write_new_component("myName", 
		{
			-- a string value with the same name as the variable 
			-- will be added as a parameter field
			myParameterVariable = "myParameterVariable",
			
			-- a value that is not a string value with the same name as the variable
			-- will be added as a default value
			myDefaultStringVariable = "woop", --defaultStringValue
			myDefaultNumberVariable = 4.44, --defaultNumberValue
			myDefaultBoolVariable = true --defaultBoolValue
		}

	-> Generated file "comp_myName.lua":
	local Component = require('ECS.component')

	return {
		new_myName = function(myParameterVariable)
			local myName = Component.new("myName")
			myName.myParameterVariable = myParameterVariable
			myName.myDefaultStringVariable = "myDefaultStringValue"
			myName.myDefaultNumberVariable = 4.44
			myName.myDefaultBoolVariable = true
			return myName
		end
	}	
]]

return {
	write_new_component = function(name, data)
		local file = "ECS\\components\\comp_" .. name .. ".lua"
		local f = io.open(file, "w")
		io.output(f)

		-- data_keys can be used for sorting and retrieving length of data
		local data_keys = {}
		for k,v in pairs(data) do
			table.insert(data_keys, k)
		end

		-- simpler way of getting length of data
		-- local data_length = 0
		-- for k,v in pairs(data) do
		-- 	data_length = data_length + 1
		-- end
		
		local params_str = ""
		local param_index = #data_keys
		for k,v in pairs(data) do
			if k == v then
				params_str = params_str .. (param_index ~= #data_keys and ", " or "") .. k 
				param_index = param_index - 1
			end
		end
		
		local vars_params_str = ""

		for k,v in pairs(data) do
			if tostring(k) == v then
				vars_params_str = vars_params_str .. "\t" .. name .. "." .. k .. " = " .. v .. "\n"
			elseif type(util.tobool[v]) == "boolean" then
				vars_params_str = vars_params_str .. "\t" .. name .. "." .. k .. " = " .. tostring(v) .. "\n"
			elseif type(tonumber(v)) == "number" then
				vars_params_str = vars_params_str .. "\t" .. name .. "." .. k .. " = " .. tostring(v) .. "\n"
			elseif type(v) == "string" then
				vars_params_str = vars_params_str .. "\t" .. name .. "." .. k .. " = \"" .. v .. "\"\n"
			end
		end
		
		local text = 
		string.format(
			"local Component = require('ECS.component')\n\n"..
			"return function(%s)\n"..
			"\tlocal %s = Component.new(\"%s\")\n"..
			"%s"..
			"\treturn %s\n"..
			"end\n"
			, params_str, name, name, vars_params_str, name)
				
		io.write(text)
		io.close(f)
	end
}
			
-- function write_new_component_old(name, params, vars)
	--     local file = "comp_" .. name .. ".lua"
	
	--     local f = io.open(file, "a")
	--     io.output(f)
	
	-- 	-- eg. "param1, param2, param3"
	-- 	local params_str = ""
	-- 	for i, param in ipairs(params) do
		-- 		if i < #params then
			-- 			params_str = params_str .. params[i] .. ", "
			-- 		else
				-- 			params_str = params_str .. params[i]
				-- 		end
				-- 	end
				
				-- 	--eg. "\t\tname.var1 = param1\n\t\tname.var2 = param3\n\t\tname.var3 = param3\n\t\tname.var4\n"
				-- 	local vars_params_str = ""
				-- 	for i, var in ipairs(vars) do
					-- 		vars_params_str = vars_params_str .. "\t\t" .. name .. "." .. var
					
					
					-- 		for i, param in ipairs(params) do
						-- 			if var == param then 
							-- 				vars_params_str = vars_params_str .. " = " .. param
							-- 			end
							-- 		end
							
							-- 		vars_params_str = vars_params_str .. "\n"
							-- 	end
							
							-- 	local text = 
							-- 	string.format(
								-- 	"local Component = require('ECS.component')\n\n"..
								-- 	"return {\n"..
								-- 	"\tnew_%s = function(%s)\n"..
									-- 	"\t\tlocal %s = Component.new(\"%s\")\n"..
									-- 	"%s"..
									-- 	"\t\treturn %s\n"..
									-- 	"\tend\n"..
									-- 	"}"
									-- 	, name, params_str, name, name, vars_params_str, name)
