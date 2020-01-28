Wall = Entity:extend("Wall")

-------------------------------
-------------------------------

function Wall:new(room, tag, x, y, w, h)
    self.__super.new(self, room, tag, x, y, 1)
    self.w = w
    self.h = h
end

function Wall:update(dt)
    self.__super.update(self, dt)
end

function Wall:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(0,1,1)
    lg.rectangle("line", self.x, self.y, self.w, self.h)
    lg.setColor(r, g, b, a)
end