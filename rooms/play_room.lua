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


    self.levels = {}
    local files = love.filesystem.getDirectoryItems('assets/levels')
    for k,file in ipairs(files) do 
        table.insert(self.levels, require('assets/levels/' .. file:gsub(".lua", "")))
    end
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
        if pressed('return') || pressed('space') then self.state = 'play' end
    
    elseif self.state == 'loose' then 
        if pressed('return') || pressed('space') then room_mgr:change_room_with_transition('menu_room') end

    elseif self.state == 'play' then 
        local pad = self:get('pad')
        local ball = self:get('ball')

        if down('left') then
            pad:move(-500, _, dt) 
            if ball && ball.state == 'init' then ball:move(pad:cx() - ball.w/2, _) end
        end
        if down('right') then 
            pad:move(500, _, dt) 
            if ball && ball.state == 'init' then ball:move(pad:cx() - ball.w/2, _) end
        end

        if pressed('space') && ball and ball.state == 'init' then 
            self:get('ball'):launch(math.rad(45)) 
        end

        self:foreach('Ball', fn(ball)
            if ball.y > lg.getHeight() || ball.y < 0 then 
                ball:kill()
                if self:count('Ball') == 0 then
                    self:add('ball', Ball(pad:cx() - 10, 530, 20, 20))
                end
            end
            self:foreach({'Wall', 'Pad', 'Brick'}, fn(entity)
                local coll, dir = tools.rectRect(ball.x, ball.y, ball.w, ball.h, entity.x, entity.y, entity.w, entity.h)

                if not coll || ball.state == 'init' then return end

                if entity:class() == 'Pad' then 
                    -- if dir == 'bottom' then 
                    --     local half_length = entity.w/2
                    --     local normal = (ball.x - entity.x) / (half_length)
                    --     ball:setAngle(math.atan2(-math.sin(ball.angle), normal))
                    -- end

                elseif  entity:class() == 'Wall' then 
                    love.audio.play(Play_Room.bump_sound:clone())

                    if entity:tag() == 'left'   then entity.spring_x:pull(10) end
                    if entity:tag() == 'top'    then entity.spring_y:pull(10) end
                    if entity:tag() == 'right'  then entity.spring_x:pull(-10) end
                    if entity:tag() == 'bottom' then
                        ball:kill()
                        entity.spring_y:pull(-10)
                        if self:count('Ball') == 0 then 
                            if self.lives == 0 then 
                                love.audio.play(Play_Room.death_sound:clone())
                                self:foreach('All', fn(entity) entity:kill() end)
                                self.state = 'loose'
                            else
                                self.lives = self.lives - 1
                                self:foreach({'Ball', 'Bonus'}, fn(entity) entity:kill() end)
                                self:add('ball', Ball(pad:cx() - 10, 530, 20, 20))
                            end                    
                        end
                    end

                elseif entity:class() == 'Brick' then
                    self.score++
                    shake:add_shake(5)
                    shockwave:add_shockwave(ball.x, ball.y)
                    chroma:add_aberration()

                    self:add(Physics_Brick(self.world, math.cos(ball.angle) * 500, math.sin(ball.angle) * 500, entity.x, entity.y, entity.w, entity.h))
                    self:add(Brick_Particles(entity:cx(), entity:cy()))
                    for i = 1, tools.random(10) do
                        self:add(Trail(entity:cx(), entity:cy()))
                    end
                    self:add(Bonus(entity:cx(), entity:cy(), tools.random("extraball", "addwidth")))
                    love.audio.play(Play_Room.ding_sound:clone())
                    entity:kill()

                    if self:count('Brick') == 0 and self.lives >= 0 then
                        if self.current_level < #self.levels then 
                            self.current_level++
                        else 
                            self.current_level = 1 
                        end
                        self:construct_level()
                    end
                end

                if dir == 'bottom' then 
                    ball:setAngle(math.atan2(-math.sin(ball.angle), math.cos(ball.angle)))
                    ball:move(_, entity.y - ball.h)
                elseif dir == 'top' then 
                    ball:setAngle(math.atan2(-math.sin(ball.angle), math.cos(ball.angle)))
                    ball:move(_, entity.y + entity.h)
                elseif dir == 'left' then 
                    ball:setAngle(math.atan2(math.sin(ball.angle), -math.cos(ball.angle)))
                    ball:move(entity.x + ball.h, _)
                elseif dir == 'right' then 
                    ball:setAngle(math.atan2(math.sin(ball.angle), -math.cos(ball.angle))) 
                    ball:move(entity.x - ball.h, _)
                end
            end)
        end)

        self:foreach('Bonus', fn(bonus)
            self:foreach({'Wall', 'Pad'}, fn(entity) 
                local coll, dir = tools.rectRect(bonus.x, bonus.y, bonus.w, bonus.h, entity.x, entity.y, entity.w, entity.h)
                if not coll then return end
    
                if entity:tag() == 'bottom' then
                    bonus:kill()
                elseif entity:tag() == 'pad' then 
                    if bonus.type == "extraball" then 
                        if self:count('Ball') < 10 then 
                            self:foreach('Ball', fn(ball) 
                                local b = self:add(Ball(ball.x, ball.y, ball.w, ball.h))
                                b:launch(math.atan2(math.sin(ball.angle), -math.cos(ball.angle)))
                            end)
                        end
                    elseif bonus.type == "addwidth" then
                        entity.w = entity.w + 10
                    end
                    bonus:kill()
                end
            end)
        end)

        self:foreach('Trail', fn(trail)
            trail:set_target(pad:cx(), pad:cy())
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