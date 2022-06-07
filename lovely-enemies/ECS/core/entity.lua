return {
    new = function(id)
        local entity = {
            __id = id,
            components = {},
            tags = {},
            remove = false,
            loaded = false
        }

        function entity:get(id)
            return self.components[id]
        end

        function entity:add(component)
            assert(component.__id, "in 'entity:add()' component needs id")
            self.components[component.__id] = component
            return component
        end

        function entity:madd(component)
            self:add(component)
            return self
        end

        function entity:destroy()
            self.remove = true
        end

        return entity
    end
}
