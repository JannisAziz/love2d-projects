local UIButton = {}

function UIButton.new()
    local self = {}

    self.img = love.graphics.newImage("UIButton.png")
    self.w = img:getWidth()
    self.h = img:getHeight()

    return self
end

function UIButton.draw()
    love.graphics.draw(img, w, h)
end
