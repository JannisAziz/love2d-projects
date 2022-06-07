Level_Manager = {}

local loaded_level = nil
local loaded_level_id = ""

function Level_Manager:load_level(id)
	if loaded_level then
		error(id .. " is already loaded!")
		return
	end

	loaded_level = require('lovely-enemies.Scenes.'.. id)
	loaded_level_id = id
	loaded_level.load()
end

function Level_Manager:unload_level()
	if not loaded_level then
		error("No level is loaded!")
		return
	end
	
	loaded_level.unload()
	loaded_level = nil

	package.loaded['lovely-enemies.Scenes.'.. loaded_level_id] = nil
	loaded_level_id = nil
end

function Level_Manager:update(dt)
	if loaded_level then
		loaded_level:update(dt)
	end
end

function Level_Manager:draw()
	if loaded_level then
		loaded_level:draw()
	end
end

return Level_Manager