Menu_Room = Room:extend('Menu_Room')

function Menu_Room:new()
    Menu_Room:super().new(self)
    self.selection = 1
    self.entered = false
end

function Menu_Room:enter()
    if not self.entered then 
        self.entered = true
        -- love.audio.play(bg_calm:clone())
    end
    self.selection = 1
end

function Menu_Room:update(dt)
    Menu_Room:super().update(self, dt)
    
    if pressed('down') then 
        self.selection = self.selection + 1 if self.selection > 4 then self.selection = 1 end shake:add_shake(5) 
        love.audio.play(switch_sound:clone())
    end
    if pressed('up')   then 
        self.selection = self.selection - 1 if self.selection < 1 then self.selection = 3 end shake:add_shake(5) 
        love.audio.play(switch_sound:clone())
    end

    if pressed('return') or pressed('space') then 
        if self.selection == 1 then room_mgr:change_room_with_transition('play_room') end
        if self.selection == 2 then room_mgr:change_room_with_transition('option_room') end
        if self.selection == 3 then room_mgr:change_room_with_transition('highscore_room') end
        if self.selection == 4 then room_mgr:change_room_with_transition('seeyou_room') end
    end
    
end

function Menu_Room:draw()
    Menu_Room:super().draw(self)

    lg.draw(forest_bg, 0, 0, 0, lg.getWidth()/forest_bg:getWidth(), lg.getHeight()/forest_bg:getHeight())

    lg.print('play', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 10, _, 2, 2)
    lg.print('menu', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 50, _, 2, 2)
    lg.print('highscores', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 90, _, 2, 2)
    lg.print('exit', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 130, _, 2, 2)

    if self.selection == 1 then lg.rectangle('line', lg.getWidth()/2 -100, lg.getHeight()/2 - 200 + 10, 100, 34) end
    if self.selection == 2 then lg.rectangle('line', lg.getWidth()/2 -100, lg.getHeight()/2 - 200 + 50, 100, 34) end
    if self.selection == 3 then lg.rectangle('line', lg.getWidth()/2 -100, lg.getHeight()/2 - 200 + 90, 150, 34) end
    if self.selection == 4 then lg.rectangle('line', lg.getWidth()/2 -100, lg.getHeight()/2 - 200 + 130, 100, 34) end
end