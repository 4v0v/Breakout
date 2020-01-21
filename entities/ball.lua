Ball = Entity:extend("Ball")

-------------------------------
-------------------------------
-------------------------------

function Ball:new(room, tag, x, y, w, h)
    self.super.new(self, room, tag, x, y, 1)
    self.w = w
    self.h = h
end

function Ball:update(dt)
    self.super.update(self, dt)
end

function Ball:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(1,1,1)
    lg.rectangle("fill", self.x, self.y, self.w, self.h)
    lg.setColor(r, g, b, a)
end