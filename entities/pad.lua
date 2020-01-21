Pad = Entity:extend("Pad")

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
    local r,g,b,a = lg.getColor()
    lg.setColor(1,1,1)
    lg.rectangle("line", self.x, self.y, self.w, self.h)
    lg.setColor(r, g, b, a)
end