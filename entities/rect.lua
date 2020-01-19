Rect = Entity:extend()

-------------------------------
-------------------------------
-------------------------------

function Rect:new(room, tag, x, y, z)
    self.super.new(self, room, tag, x, y, z)
    
    self.rect1 = { x = 10, y = 10, w = 100, h = 100 }
    self.rect2 = { x = 10, y = 10, w = 100, h = 100 }
    self.rect3 = { x = 10, y = 10, w = 100, h = 100 }
    
    self.timer:every(8.1, function()
        self.timer:script(function(wait)
            self.timer:tween(2, self.rect1, {x = lg.getWidth() - 110}, "out-quad")
            wait(2)
            self.timer:tween(2, self.rect1, {x = 10, y = lg.getHeight() - 110}, "in-quad")
            wait(2)
            self.timer:tween(2, self.rect1, {x = lg.getWidth() - 110}, "in-out-quad")
            wait(2)
            self.timer:tween(2, self.rect1, {x = 10, y = 10 }, "linear")
        end)
    end)

    self.timer:after(0.1, function() 
        self.timer:every(8.1, function()
            self.timer:script(function(wait)
                self.timer:tween(2, self.rect2, {x = lg.getWidth() - 110}, "out-quad")
                wait(2)
                self.timer:tween(2, self.rect2, {x = 10, y = lg.getHeight() - 110}, "in-quad")
                wait(2)
                self.timer:tween(2, self.rect2, {x = lg.getWidth() - 110}, "in-out-quad")
                wait(2)
                self.timer:tween(2, self.rect2, {x = 10, y = 10 }, "linear")
            end)
        end)
    end)

    self.timer:after(0.2, function() 
        self.timer:every(8.1, function()
            self.timer:script(function(wait)
                self.timer:tween(2, self.rect3, {x = lg.getWidth() - 110}, "out-quad")
                wait(2)
                self.timer:tween(2, self.rect3, {x = 10, y = lg.getHeight() - 110}, "in-quad")
                wait(2)
                self.timer:tween(2, self.rect3, {x = lg.getWidth() - 110}, "in-out-quad")
                wait(2)
                self.timer:tween(2, self.rect3, {x = 10, y = 10 }, "linear")
            end)
        end)
    end)
end

function Rect:update(dt)
    self.super.update(self, dt)
end

function Rect:draw()
    self.super.draw(self)

    local r, g, b, a = love.graphics.getColor();
    love.graphics.setColor(1,1,1,1)
    lg.rectangle("fill", self.rect1.x, self.rect1.y, self.rect1.w, self.rect1.h)
    love.graphics.setColor(1,1,1,0.6)
    lg.rectangle("fill", self.rect2.x, self.rect2.y, self.rect2.w, self.rect2.h)
    love.graphics.setColor(1,1,1,0.4)
    lg.rectangle("fill", self.rect3.x, self.rect3.y, self.rect3.w, self.rect3.h)
    love.graphics.setColor(r, g, b, a)
end