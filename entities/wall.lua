Wall = Entity:extend()

-------------------------------
-------------------------------
-------------------------------

function Wall:new(room, tag, x, y, w, h)
    self.super.new(self, room, tag, x, y, 1)
    self.w = w
    self.h = h
end

function Wall:update(dt)
    self.super.update(self, dt)
end

function Wall:draw()
    lg.rectangle("fill", self.x, self.y, self.w, self.h)
end