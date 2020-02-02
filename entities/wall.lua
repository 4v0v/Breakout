Wall = Entity:extend("Wall")

-------------------------------
-------------------------------

function Wall:new(x, y, w, h)
    self.__super.new(self, x, y, 1)
    self.w = w
    self.h = h
    self.spring_x = Spring(self.x)
    self.spring_y = Spring(self.y)
end

-------------------------------
-------------------------------

function Wall:update(dt)
    self.__super.update(self, dt)
    self.spring_x:update(dt)
    self.spring_y:update(dt)
end

function Wall:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(0,1,1)
    lg.rectangle("line", self.spring_x:value(), self.spring_y:value(), self.w, self.h)
    lg.setColor(r, g, b, a)
end