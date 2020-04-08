Seeyou_Room = Room:extend("Seeyou_Room")




function Seeyou_Room:new()
    Seeyou_Room:super().new(self)

    self.timer:after(2, function() love.event.quit() end)

end

function Seeyou_Room:update(dt)
    Seeyou_Room:super().update(self, dt)
end

function Seeyou_Room:keypressed(key)
    love.event.quit()
end

function Seeyou_Room:draw()
    Seeyou_Room:super().draw(self)

    lg.print("See you soon!", WIDTH/2 -100 , HEIGHT/2 - 200 + 10, _, 2, 2)
end