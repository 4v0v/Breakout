Menu_Room = Room:extend("Menu_Room")

-------------------------------
-------------------------------

function Menu_Room:new()
    Menu_Room.__super.new(self)
end

function Menu_Room:update(dt)
    Menu_Room.__super.update(self, dt)
end

function Menu_Room:draw()
    Menu_Room.__super.draw(self)
end