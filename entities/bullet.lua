Bullet = Entity:extend()

-------------------------------
-------------------------------
-------------------------------

function Bullet:new(room, tag, x, y, z)
    self.super.new(self, room, tag, x, y, z)
    self.r = love.math.random(10, 50)
end

function Bullet:update(dt)
    self.super.update(self, dt)
end

function Bullet:draw()
    self.super.draw(self)
    lg.circle("line", self.x, self.y, self.r)
end