return {
    new = function(id)
        assert(id, "Component param #1 needs an id")
        local component = {
            __id = id
        }
        return component
    end
}
