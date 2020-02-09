Transition_Room = Room:extend("Transition_Room")

-------------------------------
-------------------------------

function Transition_Room:new()
    self.__super.new(self)
end

function Transition_Room:update(dt)
    self.__super.update(self, dt)
end

function Transition_Room:draw()
    self.__super.draw(self)
end

function Transition_Room:enter(params)
    self.timer:after(2, function() self.mgr:changeRoom(params[1]) end)
end