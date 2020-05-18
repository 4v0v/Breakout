Ball = Entity:extend('Ball')

function Ball:new(x, y, w, h)
    Ball:super().new(self, x, y, 1)
    self.w = w
    self.h = h

    self.speed = 500
    self.angle = 0
    self.state = 'init'
end

function Ball:update(dt)
    Ball:super().update(self, dt)

    if self.state == 'launched' then
		local dx = self.speed * math.cos(self.angle)
		local dy = self.speed * math.sin(self.angle)

		self.x = self.x + dx * dt
		self.y = self.y + dy * dt
    end
end

function Ball:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(1,1,1)
    lg.circle('fill', self.x + self.w/2, self.y + self.h/2, self.w/2)
    lg.setColor(r, g, b, a)
end

function Ball:move(x, y)
    if x then self.x = x end
    if y then self.y = y end
end


function Ball:setAngle(angle) self.angle = angle end

function Ball:launch(angle)
    self:setAngle(angle)
    if self.state == 'init' then 
        self.state = 'launched'
    end
end
