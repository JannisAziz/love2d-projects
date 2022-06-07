local suit = require 'libs.suit-master'

local CompGen = require 'ECS.ComponentGenerator'

local GUI = {}

function GUI:load()
	local font = love.graphics.newFont("libs/NotoSans-Regular.ttf", 15)
    love.graphics.setFont(font)
end

local input_name = { text = "name" }
local input_vars_count = 1
local input_vars = {
	{text = "var"},
}
local input_params = {
	{text = "param"},
}

local function comp_gen_panel(x, y, width, height)
	suit.Label("Create new component:", { align = "center" }, suit.layout:row(width, height))

	suit.Label("Name:", { align = "left" }, suit.layout:row())
    suit.Input(input_name, suit.layout:row())

	-- Add and Remove variable and parameters
	suit.Label("Variables: " .. input_vars_count , { align = "left" }, suit.layout:row())
	if suit.Button("+", suit.layout:row()).hit then 
		input_vars_count = input_vars_count + 1
		table.insert(input_vars, input_vars_count, { text = "new_var" } )
		table.insert(input_params, input_vars_count, { text = "" } )
	end
	if suit.Button("-", suit.layout:row()).hit then 
		table.remove(input_vars, input_vars_count)
		table.remove(input_params, input_vars_count)
		input_vars_count = math.max(input_vars_count - 1, 0)
	end

	for i = 1, input_vars_count do
		suit.Label("Var" .. i .. " - Value", { align = "left" }, suit.layout:row())
		suit.Input(input_vars[i], suit.layout:row(150))
		suit.Input(input_params[i], suit.layout:row(150))
	end

	suit.layout:row()
	if suit.Button("Generate", suit.layout:row()).hit then 
		local new_component_data = {}
		
		for i = 1, input_vars_count do
			local var = input_vars[i].text
			local param = input_params[i].text

			print(var.text, param.text)

			--table.insert(new_component_data, input_vars[i].text .. "Woop")
			new_component_data[var] = (param == "" and var or param)

		end

		CompGen.write_new_component(input_name.text, new_component_data)
	end
end

local comp_gen_panel_active = true

function GUI:update(dt)
	suit.layout:reset()

    if suit.Button("CompGemPanel", suit.layout:col(250, 30)).hit then comp_gen_panel_active = not comp_gen_panel_active end
	if comp_gen_panel_active then
		comp_gen_panel(0, 0, 250, 30)
	end




	-- CompGen.write_new_component("myName", 
	-- 	{
	-- 		myParameterVariable = "myParameterVariable",
	-- 		myDefaultStringVariable = "myDefaultStringValue",
	-- 		myDefaultNumberVariable = 4.44,
	-- 		myDefaultBoolVariable = true
	-- 	})

	
    -- -- put an empty cell that has the same size as the last cell (200x30 px)
    -- suit.layout:row()

    -- -- put a button of size 200x30 px in the cell below
    -- -- if the button is pressed, quit the game
    -- if suit.Button("Generate", suit.layout:row(250, 30)).hit then
	-- 
    -- end
    -- if suit.Button("Close", suit.layout:row(250, 30)).hit then
    --     love.event.quit()
    -- end
end

function GUI:draw()
    suit.draw()
end

function love.textedited(text, start, length)
    -- for IME input
    suit.textedited(text, start, length)
end

function love.textinput(t)
    -- forward text input to SUIT
    suit.textinput(t)
end

function love.keypressed(key)
    -- forward keypresses to SUIT
    suit.keypressed(key)
end

return GUI