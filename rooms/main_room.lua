Main_Room = Room:extend()

-------------------------------
-------------------------------
-------------------------------

function Main_Room:new(roomMgr, tag)
    self.super.new(self, roomMgr, tag)

    Pad(self, _, 100, 100, 200, 20)
    Ball(self,_, 50, 50, 20, 20)
    

    self.un = Brick(self,_, 200, 200, 20, 20)
    self.deux =  Brick(self,_, 215, 200, 20, 20)
end

function Main_Room:update(dt)
    self.super.update(self, dt)
    self.un.x = love.mouse.getX();
    self.un.y = love.mouse.getY();
end

function Main_Room:draw()
    self.super.draw(self)
end

function Main_Room:drawOutsideCamera()
end

function Main_Room:collision(r1, r2)

    if not (r1.x + r1.w >= r2.x and   
            r1.x <= r2.x + r2.w and   
            r1.y + r1.h >= r2.y and   
            r1.y <= r2.y + r2.h) then return false end 

    local b_col = r2.y + r2.h - r1.y
    local t_col = r1.y + r1.h - r2.y
    local l_col = r1.x + r1.w - r2.x
    local r_col = r2.x + r2.w - r1.x
    
    if t_col < b_col and t_col < l_col and t_col < r_col then return true, "bottom"
    elseif b_col < t_col and b_col < l_col and b_col < r_col then return true, "top"
    elseif l_col < r_col and l_col < t_col and l_col < b_col then return true, "right"
    elseif r_col < l_col and r_col < t_col and r_col < b_col then return true, "left" end
end