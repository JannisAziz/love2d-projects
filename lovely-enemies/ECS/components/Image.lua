Image = {}

local Component = require('ECS.core.component')

function Image:new_sprite(source)
	local sprite = Component.new("sprite")
	sprite.img = love.graphics.newImage(source)
	sprite.w = sprite.img:getWidth()
	sprite.h = sprite.img:getHeight()
	sprite.rot = 0
	return sprite
end

return Image