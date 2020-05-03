Option_Room = Room:extend('Option_Room')

function Option_Room:new()
    Option_Room:super().new(self)

    self.selection = 1
end

function Option_Room:enter()
    self.selection = 1
end

function Option_Room:update(dt)
    Option_Room:super().update(self, dt)
    
    if pressed('down') then 
        self.selection = self.selection + 1 if self.selection > 3 then self.selection = 1 end shake:add_shake(5) 
        love.audio.play(switch_sound:clone())
    end
    if pressed('up')   then 
        self.selection = self.selection - 1 if self.selection < 1 then self.selection = 3 end shake:add_shake(5) 
        love.audio.play(switch_sound:clone())
    end

    if pressed('return') or pressed('space') then 
        if self.selection == 1 then end
        if self.selection == 2 then end
        if self.selection == 3 then 
            room_mgr:change_room('menu_room') 
            love.audio.play(back_sound:clone())

        end
    end
    
end

function Option_Room:draw()
    Option_Room:super().draw(self)

    lg.print('option1', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 10, _, 2, 2)
    lg.print('option2', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 50, _, 2, 2)
    lg.print('return', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 90, _, 2, 2)

    if self.selection == 1 then lg.rectangle('line', lg.getWidth()/2 -100, lg.getHeight()/2 - 200 + 10, 100, 34) end
    if self.selection == 2 then lg.rectangle('line', lg.getWidth()/2 -100, lg.getHeight()/2 - 200 + 50, 100, 34) end
    if self.selection == 3 then lg.rectangle('line', lg.getWidth()/2 -100, lg.getHeight()/2 - 200 + 90, 100, 34) end
end