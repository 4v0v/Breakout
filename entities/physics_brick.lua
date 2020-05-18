Physics_Brick = Entity:extend('Physics_Brick')

function Physics_Brick:new(world, vecx, vecy, x, y, w, h)
    Physics_Brick:super().new(self, x, y, 1)
    self.world = world
    self.direction = vec2(vecx, vecy)
    self.w = w 
    self.h = h
end

function Physics_Brick:init()
    self.collider = self.world:addRectangle(self.x, self.y, self.w, self.h):setColor(0, 1, 0)
    self.collider:applyLinearImpulse(self.direction.x, self.direction.y * tools.random{2, 3})
    self.collider:applyAngularImpulse(self.direction.x * tools.random(7))
    self.timer:after(3,fn() self:kill() end)
end

function Physics_Brick:update(dt)
    Physics_Brick:super().update(self, dt)
end

function Physics_Brick:kill()
    Physics_Brick:super().kill(self)
    self.collider:destroy()
end