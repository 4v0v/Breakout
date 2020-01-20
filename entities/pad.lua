Pad = Entity:extend()

-------------------------------
-------------------------------
-------------------------------

function Pad:new(room, tag, x, y, w, h)
    self.super.new(self, room, tag, x, y, 1)
    self.w = w
    self.h = h
end

function Pad:update(dt)
    self.super.update(self, dt)
end

function Pad:draw()
    lg.rectangle("fill", self.x, self.y, self.w, self.h)
end