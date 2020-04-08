Brick_Particles = Particles:extend("Brick_Particles")




Brick_Particles.particle_img = love.graphics.newImage("assets/images/square.png")




function Brick_Particles:new(x, y)
    Brick_Particles:super().new(self, x, y, Brick_Particles.particle_img)

    self.particles:setParticleLifetime(1,2)
    self.particles:setLinearAcceleration(-2000, -2000, 2000, 2000)
    self.particles:setSpeed(0)
    self.particles:setLinearDamping(30, 50)
    self.particles:setSizes(6,1, 6, 1, 3, 1)
end

function Brick_Particles:init()
    self.particles:emit(50)
    self.timer:after(5, function() self:kill() end)
end




function Brick_Particles:update(dt)
    Brick_Particles:super().update(self, dt)
end

function Brick_Particles:draw()
    Brick_Particles:super().draw(self)
end