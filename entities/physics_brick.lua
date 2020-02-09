Physics_Brick = Entity:extend("Physics_Brick")

-------------------------------
-------------------------------

function Physics_Brick:new(world, xspeed, yspeed, x, y, w, h)
    self.__super.new(self, x, y, 1)
    self.world = world
    self.xspeed = xspeed
    self.yspeed = yspeed
    self.w = w 
    self.h = h
end

-------------------------------
-------------------------------

function Physics_Brick:init()
    self.collider = self.world:addRectangle(self.x, self.y, self.w, self.h):setColor(0, 1, 0)
    self.collider:applyLinearImpulse(self.xspeed, self.yspeed * tools.random{2, 3})
    self.collider:applyAngularImpulse(self.xspeed * love.math.random(7))
    self.timer:after(3, function() self.collider:destroy(); self:kill() end)
end

function Physics_Brick:update(dt)
    self.__super.update(self, dt)
end

function Physics_Brick:draw()
end