Menu_Room = Room:extend("Menu_Room")

-------------------------------
-------------------------------

function Menu_Room:new()
    self.__super.new(self)
end

function Menu_Room:update(dt)
    self.__super.update(self, dt)
end

function Menu_Room:draw()
    self.__super.draw(self)
end