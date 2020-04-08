Explosion_effect = Entity:extend("Explosion_effect")




function Explosion_effect:new(x, y, radius, args)
    Explosion_effect:super().new(self, x, y, z, args)

    self.target_radius = radius
    self.radius = 0
    self.radius2 = 0
end




function Explosion_effect:init()
    self.timer:script(function(wait)
        self.timer:tween(0.5, self, {radius = self.target_radius}, 'in-cubic')
        wait(0.1)
        self.timer:tween(0.5, self, {radius2 = self.target_radius}, 'in-cubic')
        wait(0.8)
        self:kill()
    end)
end

function Explosion_effect:update(dt)
    Explosion_effect:super().update(self, dt)
end

function Explosion_effect:draw()
    local r,g,b,a = lg.getColor()
    
    love.graphics.setColor(1,0,0,1)
    love.graphics.circle("line", self.x, self.y, self.radius2)
    love.graphics.setColor(1,1,1,1)
    love.graphics.circle("line", self.x, self.y, self.radius)

    lg.setColor(r, g, b, a)
end