Pad = Entity:extend('Pad')

function Pad:new(x, y, w, h)
    Pad:super().new(self, x, y, 1)
    self.w = w
    self.h = h
    self.cx = fn() return self.x + self.w/2 end
end

function Pad:update(dt)
    Pad:super().update(self, dt)
end

function Pad:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(1,1,0)
    lg.rectangle('fill', self.x, self.y, self.w, self.h)
    lg.setColor(r, g, b, a)
end

function Pad:move(xspeed, yspeed, dt)
    local xspeed = xspeed or 0
    local yspeed = yspeed or 0
    self.x = self.x + xspeed * dt
    self.y = self.y + yspeed * dt
end