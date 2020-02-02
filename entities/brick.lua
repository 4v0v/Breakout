Brick = Entity:extend("Brick")

-------------------------------
-------------------------------

function Brick:new(x, y, w, h)
    self.__super.new(self, x, y, 1)
    self.w = w
    self.h = h
end

-------------------------------
-------------------------------

function Brick:update(dt)
    self.__super.update(self, dt)
end

function Brick:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(0,1,0)
    lg.rectangle("line", self.x, self.y, self.w, self.h)
    lg.setColor(r, g, b, a)
end