local Camera, lg, rand = {}, love.graphics, love.math.random

local function _smooth(a, b, s, dt) return a + (b - a) * (1.0 - math.exp(-s * dt)) end

function Camera:new(x, y, w, h, r, s)
    local obj = {}
        obj.x = x
        obj.y = y
        obj.w = w
        obj.h = h
        obj.r = r or 0
        obj.s = s or 1
        obj.cam = { x = 0, y = 0, r = r or 0, s = s or 1, tx = 0, ty = 0, ts = s or 1, m = 'default', sm = 'default', sv = 10, ssv = 10 }
        obj.final_canvas = love.graphics.newCanvas(lg.getWidth(), lg.getHeight())
    return setmetatable(obj, {__index = Camera})
end

function Camera:update(dt)
    if     self.cam.m == 'default'  then self.cam.x, self.cam.y = self.cam.tx, self.cam.ty
    elseif self.cam.m == 'smooth'   then self.cam.x, self.cam.y = _smooth(self.cam.x, self.cam.tx, self.cam.sv, dt), _smooth(self.cam.y, self.cam.ty, self.cam.sv, dt) end
    if     self.cam.sm == 'default' then self.cam.s = self.cam.ts
    elseif self.cam.sm == 'smooth'  then self.cam.s = _smooth(self.cam.s, self.cam.ts, self.cam.ssv, dt) end
end

function Camera:get_canvas(canvas)
    local cx, cy = self.x + self.w/2, self.y + self.h/2

    lg.setCanvas(self.final_canvas)
    lg.clear()
        lg.setScissor(self.x, self.y, self.w, self.h)
        lg.push()
        lg.translate(cx, cy)
        lg.scale(self.cam.s)
        lg.rotate(self.cam.r)
        lg.translate(-self.cam.x, -self.cam.y)
            lg.draw(canvas, 0, 0)
        lg.pop()
        lg.setScissor()
    lg.setCanvas()
    return self.final_canvas
end

function Camera:attach(x, y) self.cam.tx, self.cam.ty = x or self.cam.tx, y or self.cam.ty end
function Camera:zoom(s) self.cam.ts = s end

function Camera:getPosition() return self.cam.x, self.cam.y end
function Camera:getTargetPosition() return self.cam.tx, self.cam.ty end
function Camera:getX() return self.cam.x end
function Camera:getY() return self.cam.y end
function Camera:getTargetX() return self.cam.tx end
function Camera:getTargetY() return self.cam.ty end
function Camera:getAngle() return self.cam.r end
function Camera:getScale() return self.cam.s end
function Camera:getTargetScale() return self.cam.ts end

function Camera:setLinearValue(lv) self.cam.lv = lv end
function Camera:setSmoothValue(sv) self.cam.sv = sv end
function Camera:setScale(s) self.cam.s, self.cam.ts = s, s end
function Camera:setAngle(r) self.cam.r = r end
function Camera:setMode(m) self.cam.m = m end
function Camera:setScaleMode(m) self.cam.sm = m end
function Camera:setPosition(x, y) self.cam.x, self.cam.tx, self.cam.y, self.cam.ty = x or self.cam.x, x or self.cam.tx, y or self.cam.y, y or self.cam.ty end
function Camera:setX(x) self.cam.x, self.cam.tx = x or self.cam.x, x or self.cam.tx end
function Camera:setY(y) self.cam.y, self.cam.ty = y or self.cam.y, y or self.cam.ty end

function Camera:screenToCam(x, y) end
function Camera:camToScreen(x, y)
    local _c, _s = math.cos(self.cam.r), math.sin(self.cam.r)
    local _x = (x - self.cam.x) * _c - (y - self.cam.y) * _s 
    local _y = (y - self.cam.y) * _c + (x - self.cam.x) * _s 
    _x, _y = _x * self.cam.s, _y * self.cam.s
    _x, _y = _x + self.x + self.w/2,  _y + self.y + self.h/2
    return _x, _y
end

function Camera:getMousePosition() return self:camToScreen(love.mouse.getPosition()) end

return setmetatable({}, {__call = function(self, x, y, w, h, r, s) return Camera:new(x, y, w, h, r, s) end})