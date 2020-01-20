Brick = Entity:extend()

-------------------------------
-------------------------------
-------------------------------

function Brick:new(room, tag, x, y, w, h)
    self.super.new(self, room, tag, x, y, 1)
    self.w = w
    self.h = h
end

function Brick:update(dt)
    self.super.update(self, dt)
end

function Brick:draw()
    lg.rectangle("line", self.x, self.y, self.w, self.h)
end