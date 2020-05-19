Trail = Entity:extend('Trail')

function Trail:new(x, y, target_x, target_y)
    Trail:super().new(self, x, y, 1)

    self.target      = vec2(target_x, target_y)
    self.position    = vec2(x, y)
    self.direction   = vec2(tools.random(-1, 1), tools.random(-1, 1))
    self.speed       = tools.random(1, 100)
    self.turn_speed  = 0

    self.trail      = {}
    for i = 1, 6 do 
        table.insert( self.trail, self.position.x)
        table.insert( self.trail, self.position.y)
    end
end

function Trail:init() 
    self.timer:tween(0.5, self, {speed = 1500}, 'linear')
    self.timer:tween(1, self, {turn_speed = 5}, 'out-quad')
end

function Trail:update(dt)
    Trail:super().update(self, dt)

    local target_direction = (self.target - self.position):normalize()
    local direction_difference = target_direction - self.direction
    self.direction += (direction_difference * (self.turn_speed / 100))
    self.position += self.direction * self.speed * dt

    table.remove( self.trail )
    table.remove( self.trail )
    table.insert( self.trail,1, math.ceil(self.position['y']))
    table.insert( self.trail,1, math.ceil(self.position['x']))

    if tools.almost(self.position.x, self.target.x, 20) and tools.almost(self.position.y, self.target.y, 20) then 
        table.remove( self.trail )
        table.remove( self.trail )
        if #self.trail == 0 then 
            self:kill() 
        end
    end 

end

function Trail:draw()
    lg.setLineWidth(3)
    if #self.trail > 4 then 
        lg.setColor(1,0,0,1)
        lg.line(self.trail[1] +2, self.trail[2] +2, self.trail[3] +2 , self.trail[4]+2)
        lg.setColor(1,1,1,1)
        lg.line(self.trail[1], self.trail[2], self.trail[3], self.trail[4])
    end
    
    if #self.trail > 6 then 
        lg.setColor(1,0,0,1)
        lg.line(self.trail[3] +2, self.trail[4] +2, self.trail[5] +2 , self.trail[6]+2)
        lg.setColor(1,1,1,1)
        lg.line(self.trail[3], self.trail[4], self.trail[5], self.trail[6])
    end

    if #self.trail > 8 then 
        lg.setColor(1,0,0, 0.6)
        lg.line(self.trail[5] +2, self.trail[6] +2, self.trail[7] +2 , self.trail[8]+2)
        lg.setColor(1,1,1,0.6)
        lg.line(self.trail[5], self.trail[6], self.trail[7], self.trail[8])
    end

    if #self.trail > 10 then 
        lg.setColor(1,0,0, 0.6)
        lg.line(self.trail[7] +2, self.trail[8] +2, self.trail[9] +2, self.trail[10]+2)
        lg.setColor(1,1,1,0.6)
        lg.line(self.trail[7], self.trail[8], self.trail[9], self.trail[10])
    end

    if #self.trail > 12 then 
        lg.setColor(1,0,0, 0.2)
        lg.line(self.trail[9] +2, self.trail[10] +2, self.trail[11] +2 , self.trail[12]+2)
        lg.setColor(1,1,1,0.2)
        lg.line(self.trail[9], self.trail[10], self.trail[11] , self.trail[12])
    end
    lg.setLineWidth(1)

    lg.setColor(1,1,1,1)
end

function Trail:set_target(x, y) self.target.x, self.target.y = x, y  end