Explosion_effect = Entity:extend('Explosion_effect')

function Explosion_effect:new(x, y, radius, args)
    Explosion_effect:super().new(self, x, y, z, args)

    self.target_radius = radius
    self.radius = 0
    self.radius2 = 0
end

function Explosion_effect:init()
    self.timer:tween(0.5, self, {radius = self.target_radius}, 'in-cubic', function()
        self.timer:after(0.1, function() 
            self.timer:tween(0.5, self, {radius2 = self.target_radius}, 'in-cubic', function() 
                self.timer:after(0.8, function()
                    self:kill()
                end)
            end)
        end)
    end)
end

function Explosion_effect:update(dt)
    Explosion_effect:super().update(self, dt)
end

function Explosion_effect:draw()
    lg.setColor(1,0,0,1)
    lg.circle('line', self.x, self.y, self.radius2)
    lg.setColor(1,1,1,1)
    lg.circle('line', self.x, self.y, self.radius)
end