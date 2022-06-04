local Component = require('ECS.component')

return {
    new_position = function(x, y)
        local position = Component.new("position")
        position.x = x
        position.y = y
        return position
    end,

    new_rotation = function(rad)
        local rotation = Component.new("rotation")
        rotation.rad = rad
        return rotation
    end,

    new_velocity = function(x, y, has_drag)
        local velocity = Component.new("velocity")
        velocity.x = x
        velocity.y = y
        velocity.has_drag = has_drag
        velocity.input_has_drag = false
        velocity.drag = 0.05
        return velocity
    end,

    new_input = function()
        local input = Component.new("input")
        input.x = 0
        input.y = 0
        input.fire_down = false
        return input
    end,

    new_player = function()
        local player = Component.new("player")
        player.move_speed = 10
        return player
    end,

    new_projectile_launcher = function()
        local projectile_launcher = Component.new("projectile_launcher")
        projectile_launcher.fire_rate = 0.15
        projectile_launcher.time_since_last_shot = 0

        projectile_launcher.projectile_type = "projectile_bullet"
        projectile_launcher.fire_direction = {}
        projectile_launcher.fire_direction.x = 0
        projectile_launcher.fire_direction.y = 0
        return projectile_launcher
    end,

    new_projectile = function()
        local projectile = Component.new("projectile")
        projectile.speed = 500
        projectile.life_time = 0
        projectile.life_time_max = 1
        return projectile
    end,

    new_projectile_bullet = function()
        local projectile = Component.new("projectile_bullet")
        projectile.speed = 2000
        return projectile
    end,

    new_controller = function()
        local controller = Component.new("controller")
        return controller
    end,

    new_image_component = function(file_path)
        local image = Component.new("image")
        image.sprite = love.graphics.newImage(file_path)

        if image.sprite == nil then
            print("error loading image, sprite == nil")
        end

        print("image loaded " .. file_path)
        return image
    end,

    functional = function(fn)
        local functional = Component.new("functional")
        functional.fn = fn
        return functional
    end
}
