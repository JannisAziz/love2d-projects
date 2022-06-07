return {
    new = function(id, requires)
        assert(id, "System param #1 needs an id")
        assert(type(requires) == 'table', "System param #2 needs type of table")
        local system = {
            __id = id,
            requires = requires
        }

        print(system.__id .. " registered with " .. #requires .. " components")

        function system:match(entity)
            for i = 1, #self.requires do
                if entity:get(self.requires[i]) == nil then
                    return false
                end
            end
            return true
        end

        -- Override functions
        function system:load(entity)
        end
        function system:update(dt, entity)
        end
        function system:draw(entity)
        end
        function system:ui_draw(entity)
        end
        function system:destroy(entity)
        end
        -- ]

        function system:print_data(entity)
            local comps = ""

            for i = 1, #self.requires do
                local comp = entity:get(self.requires[i])
                if comp then
                    comps = comps .. comp
                end
            end

            print("System_" .. self.__id .. " | Requires{" .. comps .. "}")
        end

        return system
    end
}
