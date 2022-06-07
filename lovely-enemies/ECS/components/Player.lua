Player = {}

local Component = require('ECS.core.component')

function Player:new_player(move_speed, max_speed)
	local player = Component.new("player")
	player.move_speed = move_speed
	player.max_speed = max_speed
	player.has_input_drag = false

	player.aim_direction_x = 0
	player.aim_direction_y = 0

	player.projectile_speed = 350
	player.fire_rate = 0.1

	return player
end

return Player