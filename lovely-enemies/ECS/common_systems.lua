local System = require "ECS.system"
local util = require "util"

return {

    new_movement_system = function(dt)
        local mover = System.new({"position", "velocity"})
        function mover:load(entity)
        end
        function mover:update(dt, entity)
            local position = entity:get("position")
            local velocity = entity:get("velocity")
            position.x = position.x + velocity.x * dt
            position.y = position.y + velocity.y * dt

            if velocity.has_drag and not velocity.input_has_drag then
                velocity.x = util.lerp(velocity.x, 0, velocity.drag)
                velocity.y = util.lerp(velocity.y, 0, velocity.drag)
            end
        end

        return mover
    end,

    new_projectile_system = function(dt)
        local projectile = System.new({"image", "position", "rotation", "velocity", "projectile"})
        function projectile:load(entity)
            local velocity = entity:get("velocity")
            local projectile = entity:get("projectile")

            velocity.x = projectile.velocity_x
            velocity.y = projectile.velocity_y
        end
        function projectile:update(dt, entity)
            local velocity = entity:get("velocity")
            local projectile = entity:get("projectile")

            -- print(projectile.__id)
            -- print(projectile.life_time)

            projectile.life_time = projectile.life_time + dt
            if projectile.life_time > projectile.life_time_max then
                projectile:destroy(entity)
            end

            if velocity.has_drag then
                velocity.x = util.lerp(velocity.x, 0, projectile.drag)
                velocity.y = util.lerp(velocity.y, 0, projectile.drag)
            end
        end

        return projectile
    end,

    new_projectile_launcher_system = function(dt)
        local projectile_launcher = System.new({"projectile_launcher", "input"})
        function projectile_launcher:load(entity)
        end
        function projectile_launcher:update(dt, entity)
            -- local projectile_launcher = entity:get("projectile_launcher")
            -- local input = entity:get("input")

            -- if input.fire_down then

            -- end
        end

        return projectile_launcher
    end,

    -- new_player_system = function(dt)
    --     local player = System.new({"player"})
    --     function player:load(entity)
    --     end
    --     function player:update(dt, entity)

    --     end
    --     return player
    -- end,

    new_player_controller_system = function(dt)
        local controller = System.new({"velocity", "input", "controller", "player"})
        function controller:load(entity)
        end
        function controller:update(dt, entity)
            local velocity = entity:get("velocity")
            local input = entity:get("input")
            local player = entity:get("player")

            if (input.x ~= 0) then
                velocity.x = velocity.x + input.x * player.move_speed
            end
            if (input.y ~= 0) then
                velocity.y = velocity.y + input.y * player.move_speed
            end
        end
        return controller
    end,

    new_input_system = function()
        local input = System.new({"input"})
        function input:load(entity)
        end
        function input:update(dt, entity)
            local input = entity:get("input")
            if love.keyboard.isDown("a") then
                input.x = -1
            elseif love.keyboard.isDown("d") then
                input.x = 1
            else
                input.x = 0
            end
            if love.keyboard.isDown("s") then
                input.y = 1
            elseif love.keyboard.isDown("w") then
                input.y = -1
            else
                input.y = 0
            end

            input.fire_down = love.mouse.isDown(1)
        end
        return input
    end,

    new_functional_system = function(dt)
        local system = System.new({"functional"})
        function system:load(entity)
        end
        function system:update(dt, entity)
            local fn = entity:get("functional").fn
            fn(entity, dt)
        end
        return system
    end,

    new_render_system = function(id)
        local renderer = System.new(id, {"image", "position", "rotation"})
        function renderer:load(entity)
        end
        function renderer:draw(entity)
            local image = entity:get("image")
            local pos = entity:get("position")
            local rot = entity:get("rotation")

            entity:draw(image.sprite, pos.x, pos.y, rot.rad)
        end
        return renderer
    end

}
