Trail = Entity:extend("Trail")

-------------------------------
-------------------------------

function Trail:new(x, y)
    Trail.__super.new(self, x, y, 1)

    self.t              = vec2()
    self.pos            = vec2(x, y)
    self.vel            = vec2(love.math.random(-100, 100)/ 100, love.math.random(-100, 100)/ 100)
    self.target         = vec2(dx, dy)
    self.color          = color or {love.math.random(), love.math.random(), love.math.random()}
    self.turn_speed     = 100
    self.move_speed     = 100
    self.visible        = 10
    self.begin_deletion = 1
    
    self.trail      = {}
    for i = 1, 10 do 
        table.insert( self.trail, self.pos.x)
        table.insert( self.trail, self.pos.y)
    end
end

-------------------------------
-------------------------------

function Trail:init() 
    self.timer:after(0.1, function() self.move_speed = 100 end)
    self.timer:tween(1, self, {move_speed = 2000}, 'linear')
    self.timer:tween(0.5, self, {turn_speed = 20}, 'out-quad')
    self.timer:tween(5, self.color, {1, 1, 1}, 'linear')
end

function Trail:update(dt)
    Trail.__super.update(self, dt)

    self.target = (self.t - self.pos):normalize()
    local steering = self.target - self.vel
    self.vel = self.vel + (steering / self.turn_speed)
    self.pos = self.pos + self.vel * self.move_speed * dt

    -- visual
    table.remove( self.trail )
    table.remove( self.trail )
    table.insert( self.trail,1, math.ceil(self.pos["y"]))
    table.insert( self.trail,1, math.ceil(self.pos["x"]))

    -- prevent visual bug on creation
    if type(self.visible) == "number" then self.visible = self.visible - 1 end
    if self.visible == 0 then self.visible = true end

    -- non instant deletion
    if tools.oequal(self.pos.x, self.t.x, 7) and tools.oequal(self.pos.y, self.t.y, 15) then 
        if type(self.begin_deletion) == "number" then 
            self.begin_deletion = self.begin_deletion - 1 
            if self.begin_deletion == 0 then self.begin_deletion = true end
        end
    end 
    if self.begin_deletion == true then 
        table.remove( self.trail )
        table.remove( self.trail )
        if #self.trail == 0 then 
            -- self:room():add(Explosion_effect(self.pos.x, self.pos.y, love.math.random(100)))
            self:kill() 
        end
    end
end

function Trail:draw()
    local r,g,b,a = lg.getColor()
    local lw = lg.getLineWidth()

    lg.setColor(self.color)
    lg.setLineWidth(7) 
        if #self.trail > 4  then lg.line(self.trail[1] , self.trail[2], self.trail[3] , self.trail[4])  end
        if #self.trail > 6  then lg.line(self.trail[3] , self.trail[4], self.trail[5] , self.trail[6])  end
    lg.setLineWidth(6) 
        if #self.trail > 8  then lg.line(self.trail[5] , self.trail[6], self.trail[7] , self.trail[8])  end
        if #self.trail > 10 then lg.line(self.trail[7] , self.trail[8], self.trail[9] , self.trail[10])  end
    lg.setLineWidth(5) 
        if #self.trail > 12 then lg.line(self.trail[9] , self.trail[10], self.trail[11] , self.trail[12])  end
        if #self.trail > 14 then lg.line(self.trail[11] , self.trail[12], self.trail[13] , self.trail[14])  end
    lg.setLineWidth(4) 
        if #self.trail > 16 then lg.line(self.trail[13] , self.trail[14], self.trail[15] , self.trail[16])  end
        if #self.trail > 18 then lg.line(self.trail[15] , self.trail[16], self.trail[17] , self.trail[18])  end
    lg.setLineWidth(3) 
        if #self.trail > 20 then lg.line(self.trail[17] , self.trail[18], self.trail[19] , self.trail[20])  end

    lg.setLineWidth(lw)
    lg.setColor(r, g, b, a)
end

function Trail:set_target(x, y) self.t.x, self.t.y = x, y  end