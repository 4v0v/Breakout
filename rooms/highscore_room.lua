Highscore_Room = Room:extend("Highscore_Room")




function Highscore_Room:new()
    Highscore_Room:super().new(self)
    self.selection = 1
end

function Highscore_Room:enter()
    self.selection = 1
end

function Highscore_Room:update(dt)
    Highscore_Room:super().update(self, dt)

    if pressed("return") or pressed("space") then 
        if self.selection == 1 then 
            room_mgr:changeRoom("menu_room")
            love.audio.play(back_sound:clone())
        end
    end
end

function Highscore_Room:draw()
    Highscore_Room:super().draw(self)

    lg.print("return", WIDTH/2 -100 , HEIGHT/2 - 200 + 10, _, 2, 2)

    if self.selection == 1 then lg.rectangle("line", WIDTH/2 -100, HEIGHT/2 - 200 + 10, 100, 34) end
end