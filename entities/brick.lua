Brick = Entity:extend("Brick")

-------------------------------
-------------------------------

Brick.particle_img = love.graphics.newImage("assets/images/square.png")
Brick.bounce_sound = love.audio.newSource('assets/sounds/bump.wav', 'static')

-------------------------------
-------------------------------

function Brick:new(x, y, w, h)
    self.__super.new(self, x, y, 1)
    self.w = w
    self.h = h
    self.sine_scale = Sinewave(1, 3, 3)
    self.p_system = love.graphics.newParticleSystem(self.particle_img)

end

-------------------------------
-------------------------------

function Brick:init()
    self.sine_scale:stop()
    self.timer:after({0, 2}, function() self.sine_scale:play() end)

    self.p_system:setParticleLifetime(1,2)
    self.p_system:setLinearAcceleration(-1000, -1000, 1000, 1000)
    -- self.p_system:setDirection(math.pi/2)
    self.p_system:setSpeed(0)
    self.p_system:setLinearDamping(10, 30)
    self.p_system:setRadialAcceleration(30)
    self.p_system:setRadialAcceleration(30)
    self.p_system:setSizes(1,8, 1, 8, 1, 8)
end

function Brick:update(dt)
    self.__super.update(self, dt)
    self.sine_scale:update(dt)
    self.p_system:update(dt)
end

function Brick:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(0,1,0)
    lg.push()
    love.graphics.setCanvas(self.canvas)
    lg.rectangle("line", self.x - self.sine_scale:value(), self.y - self.sine_scale:value(), self.w + self.sine_scale:value()* 2, self.h + self.sine_scale:value()* 2)
    lg.pop()
    lg.setColor(r, g, b, a)

    love.graphics.draw(self.p_system, self.x+self.w/2, self.y+ self.h/2)
end