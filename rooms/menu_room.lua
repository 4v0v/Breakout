Menu_Room = Room:extend("Menu_Room")




function Menu_Room:new()
    Menu_Room:super().new(self)
    self.selection = 1
end

function Menu_Room:enter()
    self.selection = 1
end

function Menu_Room:update(dt)
    Menu_Room:super().update(self, dt)
    
    if pressed("down") then 
        self.selection = self.selection + 1 if self.selection > 4 then self.selection = 1 end camera:shake(10) 
        love.audio.play(switch_sound:clone())
    end
    if pressed("up")   then 
        self.selection = self.selection - 1 if self.selection < 1 then self.selection = 3 end camera:shake(10) 
        love.audio.play(switch_sound:clone())
    end

    if pressed("return") or pressed("space") then 
        if self.selection == 1 then room_mgr:changeRoom("play_room") end
        if self.selection == 2 then room_mgr:changeRoom("option_room") end
        if self.selection == 3 then room_mgr:changeRoom("highscore_room") end
        if self.selection == 4 then room_mgr:changeRoom("seeyou_room") end
    end
    
end

function Menu_Room:draw()
    Menu_Room:super().draw(self)

    lg.print("play", WIDTH/2 -100 , HEIGHT/2 - 200 + 10, _, 2, 2)
    lg.print("menu", WIDTH/2 -100 , HEIGHT/2 - 200 + 50, _, 2, 2)
    lg.print("highscores", WIDTH/2 -100 , HEIGHT/2 - 200 + 90, _, 2, 2)
    lg.print("exit", WIDTH/2 -100 , HEIGHT/2 - 200 + 130, _, 2, 2)

    if self.selection == 1 then lg.rectangle("line", WIDTH/2 -100, HEIGHT/2 - 200 + 10, 100, 34) end
    if self.selection == 2 then lg.rectangle("line", WIDTH/2 -100, HEIGHT/2 - 200 + 50, 100, 34) end
    if self.selection == 3 then lg.rectangle("line", WIDTH/2 -100, HEIGHT/2 - 200 + 90, 150, 34) end
    if self.selection == 4 then lg.rectangle("line", WIDTH/2 -100, HEIGHT/2 - 200 + 130, 100, 34) end
end