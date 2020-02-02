Pad = Entity:extend("Pad")

-------------------------------
-------------------------------

function Pad:new(x, y, w, h)
    self.__super.new(self, x, y, 1)
    self.w = w
    self.h = h
end

-------------------------------
-------------------------------

function Pad:update(dt)
    self.__super.update(self, dt)
end

function Pad:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(1,1,0)
    lg.rectangle("line", self.x, self.y, self.w, self.h)
    lg.setColor(r, g, b, a)
end

function Pad:moveRight(speed, dt)
    self.x = self.x + speed * dt
end

function Pad:moveLeft(speed, dt)
    self.x = self.x - speed * dt
end