Bonus = Entity:extend('Bonus')

function Bonus:new(x, y, type)
    Bonus:super().new(self, x, y, 1)
    self.w = 50
    self.h = 50
    self.ySpeed = 200
    self.type = type
end

function Bonus:init()
end

function Bonus:update(dt)
    Bonus:super().update(self, dt)

    self.y = self.y + self.ySpeed * dt
end

function Bonus:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(0,1,1)
    lg.rectangle('line', self.x, self.y, self.w, self.h)
    lg.setColor(r, g, b, a)
end