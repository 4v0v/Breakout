Play_Room = Room:extend('Play_Room')

Play_Room.death_sound = love.audio.newSource('assets/sounds/death.wav', 'static')
Play_Room.bump_sound = love.audio.newSource('assets/sounds/bump.wav', 'static')
Play_Room.ding_sound = love.audio.newSource('assets/sounds/ding.wav', 'static')

function Play_Room:new(roomMgr, tag)
    Play_Room:super().new(self, roomMgr, tag)
    self.world = Physics(0, 1500)
    self.state = 'begin'
    self.current_level = 1
    self.score = 0
    self.lives = 3

    self.levels = {
        {{0,0,0,0,0,0,0,0,0,0},
         {0,0,0,0,0,0,0,0,0,0},
         {0,0,0,0,0,0,0,0,0,0},
         {0,0,0,0,0,0,0,0,0,0},
         {0,0,0,0,0,0,0,0,0,1}},

        {{1,1,1,1,1,1,1,1,1,1},
         {1,1,1,0,0,0,0,1,1,1},
         {1,1,1,0,0,0,0,1,1,1},
         {1,1,1,0,0,0,0,1,1,1},
         {1,1,1,1,1,1,1,1,1,1}},

        {{1,1,1,1,1,1,1,1,1,1},
         {1,1,1,1,1,1,1,1,1,1},
         {1,1,1,1,1,1,1,1,1,1},
         {1,1,1,1,1,1,1,1,1,1},
         {1,1,1,1,1,1,1,1,1,1}}
    }
end


function Play_Room:enter()
    self:add('pad', Pad(300, 550, 200, 20))
    self:add('ball', Ball(390, 530, 20, 20))
    self:add('left', Wall(0, 0, 10, lg.getHeight() - 1))
    self:add('right', Wall(lg.getWidth() - 10, 0, 10, lg.getHeight() - 1))
    self:add('top', Wall(0, 0, lg.getWidth(), 10))
    self:add('bottom', Wall(0, lg.getHeight()-11, lg.getWidth(), 10))

    self.state = 'begin'
    self.current_level = 1
    self.score = 0
    self.lives = 3

    self:construct_level()
end

function Play_Room:update(dt)
    Play_Room:super().update(self, dt)
    self.world:update(dt)

    if self.state == 'begin' then 
        if pressed('return') or pressed('space') then self.state = 'play' end
    
    elseif self.state == 'loose' then 
        if pressed('return') or pressed('space') then room_mgr:change_room('menu_room') end

    elseif self.state == 'play' then 
        local pad = self:get('pad')
        local ball = self:get('ball')

        pad.x = ball.x + ball.w/2 - pad.w/2

        if down('left') then
            if ball.state == 'init' then ball:moveLeft(500, dt) end
            pad:moveLeft(500, dt) 
        end
        if down('right') then 
            if ball.state == 'init' then ball:moveRight(500, dt) end
            pad:moveRight(500, dt) 
        end

        if pressed('space') then self:get('ball'):launch(500, -500)  end

        self:foreach('Ball', function(ball)
            self:foreach({'Wall', 'Pad', 'Brick'}, function(entity)
                local coll, dir = tools.rectRect(ball.x, ball.y, ball.w, ball.h, entity.x, entity.y, entity.w, entity.h)

                if not coll or ball.state == 'init' then return end

                if entity:class() == 'Wall' then 
                    love.audio.play(Play_Room.bump_sound:clone())

                    if entity:tag() == 'left'   then entity.spring_x:pull(10) end
                    if entity:tag() == 'top'    then entity.spring_y:pull(10) end
                    if entity:tag() == 'right'  then entity.spring_x:pull(-10) end
                    if entity:tag() == 'bottom' then 
                        entity.spring_y:pull(-10)
                        if self.lives == 0 then 
                            love.audio.play(Play_Room.death_sound:clone())
                            self:foreach('All', function(entity) entity:kill() end)
                            self.state = 'loose'
                        else
                            self.lives = self.lives - 1
                            self:get('pad'):kill()
                            self:get('ball'):kill()
                            self:add('pad', Pad(300, 550, 200, 20))
                            self:add('ball', Ball(390, 530, 20, 20))
                        end
                    end
                end

                if entity:class() == 'Brick' then
                    self.score = self.score + 1
                    shake:add_shake(5)
                    shockwave:add_shockwave(ball.x, ball.y)
                    chroma:add_aberration()

                    self:add(Physics_Brick(self.world, ball.xSpeed, ball.ySpeed, entity.x + entity.w/2, entity.y + entity.h/2, entity.w, entity.h))
                    self:add(Brick_Particles(entity.x + entity.w/2, entity.y + entity.h/2))
                    self:add(Bonus(entity.x + entity.w/2, entity.y + entity.h/2))
                    love.audio.play(Play_Room.ding_sound:clone())
                    entity:kill()

                    if self:count('Brick') == 1 and self.lives > 0 then
                        if self.current_level < #self.levels then 
                            self.current_level = self.current_level + 1 
                        else 
                            self.current_level = 1 
                        end
                        self:construct_level()
                    end
                end

                if dir == 'bottom' then ball:setYSpeed(-500) end
                if dir == 'top'    then ball:setYSpeed(500)  end
                if dir == 'left'   then ball:setXSpeed(500)  end
                if dir == 'right'  then ball:setXSpeed(-500) end
            end)
        end)

        self:foreach('Bonus', function(bonus)
            self:foreach({'Wall', 'Pad'}, function(entity) 
                local coll, dir = tools.rectRect(bonus.x, bonus.y, bonus.w, bonus.h, entity.x, entity.y, entity.w, entity.h)
                if not coll then return end
    
                if entity:tag() == 'bottom' then
                    bonus:kill()
                elseif entity:tag() == 'pad' then 
                    local b = Ball(10, 10, 20, 20)
                    self:add(b)
                    b:launch(500, 500)
                    bonus:kill()
                end
            end)
        end)
    end
end

function Play_Room:draw()
    Play_Room:super().draw(self)

    lg.print(self.lives, 15 , 15, _, 3)
    lg.printf(self.score, 30 , 15, 250, 'right',_, 3)

    if self.state == 'begin' then 
        lg.setColor(0,0,0,0.5)
        lg.rectangle('fill', 0,0,lg.getWidth(), lg.getHeight())
        lg.setColor(1,1,1,1)
        lg.print('start', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 10, _, 2, 2)
    elseif self.state == 'loose' then 
        lg.setColor(0,0,0,0.5)
        lg.rectangle('fill', 0,0,lg.getWidth(), lg.getHeight())
        lg.setColor(1,1,1,1)
        lg.print('you loose', lg.getWidth()/2 -100 , lg.getHeight()/2 - 200 + 10, _, 2, 2)
    end

    self.world:draw()
end

function Play_Room:construct_level()
    for i, v in ipairs(self.levels[self.current_level]) do 
        for j, brick_type in ipairs(v) do 
            if brick_type == 1 then self:add(Brick( 70 * j, 40 * i, 60, 30)) end
        end
    end
end