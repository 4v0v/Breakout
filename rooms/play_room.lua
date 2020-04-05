Play_Room = Room:extend("Play_Room")

-------------------------------
-------------------------------

Play_Room.death_sound = love.audio.newSource('assets/sounds/death.wav', 'static')
Play_Room.bump_sound = love.audio.newSource('assets/sounds/bump.wav', 'static')
Play_Room.ding_sound = love.audio.newSource('assets/sounds/ding.wav', 'static')

-------------------------------
-------------------------------

function Play_Room:new(roomMgr, tag)
    Play_Room:super().new(self, roomMgr, tag)
    self.world = Physics(0, 1500)   
end

function Play_Room:enter()
    self:add("pad", Pad(300, 550, 200, 20))
    self:add("ball", Ball(390, 530, 20, 20))
    self:add("left", Wall(0, 0, 10, lg.getHeight() - 1))
    self:add("right", Wall(lg.getWidth() - 10, 0, 10, lg.getHeight() - 1))
    self:add("top", Wall(0, 0, lg.getWidth(), 10))
    self:add("bottom", Wall(0, lg.getHeight()-11, lg.getWidth(), 10))
    for i = 1, 5 do for j = 1, 10 do self:add(Brick( 70 * j, 40 * i, 60, 30)) end end

    self.score = 0
    self.lives = 3
end

function Play_Room:update(dt)
    Play_Room:super().update(self, dt)
    self.world:update(dt)

    local pad = self:get("pad")
    local ball = self:get("ball")

    if down("left") then
        if ball.state == "init" then ball:moveLeft(500, dt) end
        pad:moveLeft(500, dt) 
    end
    if down("right") then 
        if ball.state == "init" then ball:moveRight(500, dt) end
        pad:moveRight(500, dt) 
    end

    if pressed("space") then self:get("ball"):launch(500, -500)  end

    self:foreach("Ball", function(ball)
        self:foreach({"Wall", "Pad", "Brick"}, function(entity)
            local coll, dir = self:collision(ball, entity)

            if coll and ball.state ~= "init" then

                if entity:class() == "Wall" then 
                    love.audio.play(Play_Room.bump_sound:clone())

                    if entity:tag() == "left"   then entity.spring_x:pull(10) end
                    if entity:tag() == "top"    then entity.spring_y:pull(10) end
                    if entity:tag() == "right"  then entity.spring_x:pull(-10) end
                    if entity:tag() == "bottom" then 

                        entity.spring_y:pull(-10)
                        if self.lives == 0 then 
                            love.audio.play(Play_Room.death_sound:clone())
                            self:foreach("All", function(entity) entity:kill() end)
                            self:enter()
                        else
                            self.lives = self.lives - 1
                            self:get("pad"):kill()
                            self:get("ball"):kill()
                            self:add("pad", Pad(300, 550, 200, 20))
                            self:add("ball", Ball(390, 530, 20, 20))
                        end
                    end
                end

                if entity:class() == "Brick" then
                    camera:shake(50)
                    self.score = self.score + 1
                    self:add(Physics_Brick(self.world, ball.xSpeed, ball.ySpeed, entity.x + entity.w/2, entity.y + entity.h/2, entity.w, entity.h))
                    self:add(Brick_Particles(entity.x + entity.w/2, entity.y + entity.h/2))
                    love.audio.play(Play_Room.ding_sound:clone())
                    entity:kill()
                end

                if dir == "bottom" then ball:setYSpeed(-500) end
                if dir == "top"    then ball:setYSpeed(500)  end
                if dir == "left"   then ball:setXSpeed(500)  end
                if dir == "right"  then ball:setXSpeed(-500) end
            end
        end)
    end)

    if self:count("Brick") == 0 and self.lives > 0 then 
        for i = 1, 5 do for j = 1, 10 do self:add(Brick( 70 * j, 40 * i, 60, 30)) end end
    end

    self:foreach("Trail", function(entity)
        entity:set_target(pad.x + pad.w/2 , pad.y - pad.h/ 2)
    end)
end

function Play_Room:draw()
    Play_Room:super().draw(self)

    lg.print(self.lives, 15 , 15, _, 3)
    lg.printf(self.score, 30 , 15, 250, "right",_, 3)

    self.world:draw()
end

function Play_Room:collision(r1, r2)
    if not (r1.x + r1.w >= r2.x and   
            r1.x <= r2.x + r2.w and   
            r1.y + r1.h >= r2.y and   
            r1.y <= r2.y + r2.h) then 
        return false 
    end 

    local b_col = r2.y + r2.h - r1.y
    local t_col = r1.y + r1.h - r2.y
    local l_col = r1.x + r1.w - r2.x
    local r_col = r2.x + r2.w - r1.x
    
    if     t_col < b_col and t_col < l_col and t_col < r_col then return true, "bottom"
    elseif b_col < t_col and b_col < l_col and b_col < r_col then return true, "top"
    elseif l_col < r_col and l_col < t_col and l_col < b_col then return true, "right"
    elseif r_col < l_col and r_col < t_col and r_col < b_col then return true, "left" end
end