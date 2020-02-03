Brick = Entity:extend("Brick")

-------------------------------
-------------------------------

function Brick:new(x, y, w, h)
    self.__super.new(self, x, y, 1)
    self.w = w
    self.h = h
    self.sine_w = Sinewave(w, 1, 10)
    self.sine_h = Sinewave(h, 1, 5)
end

-------------------------------
-------------------------------

function Brick:update(dt)
    self.__super.update(self, dt)
    self.sine_w:update(dt)
    self.sine_h:update(dt)
end

function Brick:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(0,1,0)
    lg.rectangle("line", self.x, self.y, self.sine_w:value(), self.sine_h:value())
    lg.setColor(r, g, b, a)
end