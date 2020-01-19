Main_Room = Room:extend()

-------------------------------
-------------------------------
-------------------------------

function Main_Room:new(roomMgr, tag)
    self.super.new(self, roomMgr, tag)

    Rect(self)
    Bullet(self, _, 100, 100, 20)
end

function Main_Room:update(dt)
    self.super.update(self, dt)
end

function Main_Room:draw()
    self.super.draw(self)

end

function Main_Room:drawOutsideCamera()
end