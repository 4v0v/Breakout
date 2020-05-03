Particles = Entity:extend('Particles')

function Particles:new(x, y, img)
    Particles:super().new(self, x, y, 1)
    self.particles = lg.newParticleSystem(img)
end

function Particles:update(dt)
    Particles:super().update(self, dt)
    self.particles:update(dt)
end

function Particles:draw()
    lg.draw(self.particles, self.x, self.y)
end
