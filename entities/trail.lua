Trail = Entity:extend('Trail')

function Trail:new(x, y)
    Trail:super().new(self, x, y, 1)

    self.t              = vec2()
    self.pos            = vec2(x, y)
    self.vel            = vec2(tools.random(-1, 1), tools.random(-1, 1))
    self.target         = vec2(dx, dy)
    self.turn_speed     = 100
    self.move_speed     = tools.random(1, 100)
    self.visible        = 10
    
    self.trail      = {}
    for i = 1, 6 do 
        table.insert( self.trail, self.pos.x)
        table.insert( self.trail, self.pos.y)
    end
end

function Trail:init() 
    self.timer:tween(0.5, self, {move_speed = 1500}, 'linear')
    self.timer:tween(0.5, self, {turn_speed = 5}, 'out-quad')
end

function Trail:update(dt)
    Trail:super().update(self, dt)

    self.target = (self.t - self.pos):normalize()
    local steering = self.target - self.vel
    self.vel = self.vel + (steering / self.turn_speed)
    self.pos = self.pos + self.vel * self.move_speed * dt

    -- visual
    table.remove( self.trail )
    table.remove( self.trail )
    table.insert( self.trail,1, math.ceil(self.pos['y']))
    table.insert( self.trail,1, math.ceil(self.pos['x']))

    -- prevent visual bug on creation
    if type(self.visible) == 'number' then self.visible = self.visible - 1 end
    if self.visible == 0 then self.visible = true end

    -- non instant deletion
    if tools.almost(self.pos.x, self.t.x, 15) and tools.almost(self.pos.y, self.t.y, 15) then 
        table.remove( self.trail )
        table.remove( self.trail )
        if #self.trail == 0 then 
            self:kill() 
        end
    end 

end

function Trail:draw()

    if #self.trail > 4 then 
        lg.setColor(1,0,0,0.8)
        lg.line(self.trail[1] +2, self.trail[2] +2, self.trail[3] +2 , self.trail[4]+2)
        lg.setColor(1,1,1,1)
        lg.line(self.trail[1], self.trail[2], self.trail[3], self.trail[4])
    end
    
    if #self.trail > 6 then 
        lg.setColor(1,0,0,0.8)
        lg.line(self.trail[3] +2, self.trail[4] +2, self.trail[5] +2 , self.trail[6]+2)
        lg.setColor(1,1,1,1)
        lg.line(self.trail[3], self.trail[4], self.trail[5], self.trail[6])
    end

    if #self.trail > 8 then 
        lg.setColor(1,0,0, 0.4)
        lg.line(self.trail[5] +2, self.trail[6] +2, self.trail[7] +2 , self.trail[8]+2)
        lg.setColor(1,1,1,0.6)
        lg.line(self.trail[5], self.trail[6], self.trail[7], self.trail[8])
    end

    if #self.trail > 10 then 
        lg.setColor(1,0,0, 0.4)
        lg.line(self.trail[7] +2, self.trail[8] +2, self.trail[9] +2, self.trail[10]+2)
        lg.setColor(1,1,1,0.6)
        lg.line(self.trail[7], self.trail[8], self.trail[9], self.trail[10])
    end

    if #self.trail > 12 then 
        lg.setColor(1,0,0, 0.1)
        lg.line(self.trail[9] +2, self.trail[10] +2, self.trail[11] +2 , self.trail[12]+2)
        lg.setColor(1,1,1,0.2)
        lg.line(self.trail[9], self.trail[10], self.trail[11] , self.trail[12])
    end

    lg.setColor(1,1,1,1)
end

function Trail:set_target(x, y) self.t.x, self.t.y = x, y  end