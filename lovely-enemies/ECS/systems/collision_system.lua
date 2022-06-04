local util = require "util"
local System = require "ECS.system"

return function()
	local collision_system = System.new("collision_system", {"position", "image", "collider"})

	local tolerance = 30

	local function check_bounding_box(col_a, col_b)
		local within_bounds_x = (col_a.x - col_a.w /2) + col_a.w > (col_b.x - col_b.w /2) and (col_a.x - col_a.w /2) < (col_b.x - col_b.w /2) + col_b.w
		local within_bounds_y = (col_a.y - col_a.h /2) + col_a.h > (col_b.y - col_b.h /2) and (col_a.y - col_a.h /2) < (col_b.y - col_b.h /2) + col_b.h

		return within_bounds_x and within_bounds_y
	end

	local function get_rotated_bounds(collider)
		local rx_1, ry_1 = util.rotate_point(-collider.w/2, -collider.h/2, collider.rot, collider.x, collider.y)
		local rx_2, ry_2 = util.rotate_point(collider.w/2, -collider.h/2, collider.rot, collider.x, collider.y)
		local rx_3, ry_3 = util.rotate_point(collider.w/2, collider.h/2, collider.rot, collider.x, collider.y)
		local rx_4, ry_4 = util.rotate_point(-collider.w/2, collider.h/2, collider.rot, collider.x, collider.y)

		local rotated_bounds = { rx_1, ry_1, rx_2, ry_2, rx_3, ry_3, rx_4, ry_4 }
		
		return rotated_bounds
	end

	local function is_colliding(entity, other_entity)
		local result = false

		local col_a = entity:get("collider")
		local col_b = other_entity:get("collider")

		-- point collision (with error tolerance)
		--if math.abs(pos_a.x - pos_b.x) < tolerance and math.abs(pos_a.y - pos_b.y) < tolerance then
		
		result = check_bounding_box(col_a, col_b)

		return result
	end

	--function collision_system:update(dt, entity)
	function collision_system:update(dt, entity)
		local position = entity:get("position")
		local collider = entity:get("collider")
		local image = entity:get("image")

		collider.x = position.x
		collider.y = position.y
		collider.w = image.w
		collider.h = image.h
		collider.rot = image.rot

		local collider_entities = World:get_all_with_any({"collider"})

		for i = 1, #collider_entities do
			local other_entity = collider_entities[i]

			if entity ~= other_entity then
				if is_colliding(entity, other_entity) then

					collider.on_collision(entity, other_entity)
					other_entity:get("collider").on_collision(other_entity, entity)
				end
			end
		end
		
	end

	-- function collision_system:draw(entity)
		
	-- 	local collider = entity:get("collider")

	-- 	love.graphics.rectangle("line", collider.x - collider.w/2, collider.y - collider.h/2, collider.w, collider.h )

	-- 	love.graphics.polygon("line", get_rotated_bounds(collider))
	-- end

	return collision_system
end