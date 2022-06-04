local Component = require('ECS.component')

image_pool = {}

function getImage(source)
	-- if image is in pool, use it, else load new
	if image_pool[source] then
		return image_pool[source]
	else
		image_pool[source] = love.graphics.newImage(source)
		print("loaded new image")
		return image_pool[source]
	end
end

return function(source)
	local image = Component.new("image")
	image.source = source
	image.sprite = getImage(source)
	image.w = image.sprite:getWidth()
	image.h = image.sprite:getHeight()
	image.rot = 0
	return image
end