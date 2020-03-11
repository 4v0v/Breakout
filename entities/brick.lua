Brick = Entity:extend("Brick")

-------------------------------
-------------------------------

Brick.bounce_sound = love.audio.newSource('assets/sounds/bump.wav', 'static')

-------------------------------
-------------------------------

function Brick:new(x, y, w, h)
    Brick.__super.new(self, x, y, 1)
    self.w = w
    self.h = h
    self.sine_scale = Sinewave(1, 3, 3)
end

-------------------------------
-------------------------------

function Brick:init()
    self.sine_scale:stop()
    self.timer:after({0, 2}, function() self.sine_scale:play() end)
end

function Brick:update(dt)
    Brick.__super.update(self, dt)
    self.sine_scale:update(dt)
end

function Brick:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(0,1,0)
    lg.push()
    love.graphics.setCanvas(self.canvas)
    lg.rectangle("line", self.x - self.sine_scale:value(), self.y - self.sine_scale:value(), self.w + self.sine_scale:value()* 2, self.h + self.sine_scale:value()* 2)
    lg.pop()
    lg.setColor(r, g, b, a)
end