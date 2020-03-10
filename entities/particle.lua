Particle = Entity:extend("Particle")

Particle.particle_img = love.graphics.newImage("assets/images/square.png")

-------------------------------
-------------------------------

function Particle:new(x, y, w, h)
    self.__super.new(self, x, y, 1)
    self.w = w
    self.h = h
    self.p_system = love.graphics.newParticleSystem(self.particle_img)
end

-------------------------------
-------------------------------

function Particle:update(dt)
    self.__super.update(self, dt)

    self.p_system:update(dt)
end

function Particle:draw()
    love.graphics.draw(self.p_system, self.x, self.y)
end
