Ball = Entity:extend("Ball")




function Ball:new(x, y, w, h)
    Ball:super().new(self, x, y, 1)
    self.w = w
    self.h = h
    self.xSpeed = 0
    self.ySpeed = 0
    self.state = "init"
end




function Ball:update(dt)
    Ball:super().update(self, dt)

    if self.state == "launched" then
        self.x = self.x + self.xSpeed * dt
        self.y = self.y + self.ySpeed * dt
    end
end

function Ball:draw()
    local r,g,b,a = lg.getColor()
    lg.setColor(1,1,1)
    lg.circle("fill", self.x + self.w/2, self.y + self.h/2, self.w/2)
    lg.setColor(r, g, b, a)
end




function Ball:moveRight(speed, dt)
    self.x = self.x + speed * dt
end

function Ball:moveLeft(speed, dt)
    self.x = self.x - speed * dt
end

function Ball:setXSpeed(speed) self.xSpeed = speed end
function Ball:setYSpeed(speed) self.ySpeed = speed end

function Ball:launch(x, y)
    if self.state == "init" then 
        self.state = "launched"
        self:setXSpeed(x) 
        self:setYSpeed(y)
    end
end
