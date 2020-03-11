function love.run()
    local _DT, _F_DT, _ACC = 0, 1/60, 0
    local _INPUT = {_CUR = {}, _PRE = {}}
    function pressed(key)  return _INPUT._CUR[key] and not _INPUT._PRE[key] end
    function released(key) return _INPUT._PRE[key] and not _INPUT._CUR[key]  end
    function down(key) if key=="mouse_1"or key=="mouse_2"or key=="mouse_3"then return love.mouse.isDown(tonumber(key:sub(7))) end; return love.keyboard.isDown(key) end  

    Timer  = require("core/libraries/timer")
    Class  = require("core/libraries/class")
    Camera = require("core/libraries/camera")
    vec2   = require("core/libraries/vector")
    Physics = require("core/libraries/physics")
    require("core/libraries/tools")
    tools.require("core/classes")
    tools.require("rooms")
    tools.require("entities")
    tools.require("entities/particles")
    
    lg = love.graphics
    lg.setDefaultFilter("nearest", "nearest")
    lg.setLineStyle("rough")
    love.keyboard.setKeyRepeat(true)
    --love.window.setMode( 800, 600, { vsync = true, x = 1111, y = 70 })
    love.load()
    love.timer.step()

    return function()
        -- EVENTS --
        love.event.pump() 
        for name,a,b,c,d,e,f in love.event.poll() do 
            if name == "quit"          then if not love.quit or not love.quit() then return a or 0 end end
            if name == "mousepressed"  then _INPUT._CUR["mouse_".. c] = true            end
            if name == "mousereleased" then _INPUT._CUR["mouse_".. c] = false           end
            if name == "keypressed"    then _INPUT._CUR[a]            = true if c == true then _INPUT._PRE[a] = false  end  end -- isRepeat
            if name == "keyreleased"   then _INPUT._CUR[a]            = false           end
            love.handlers[name](a,b,c,d,e,f)
        end
		-- UPDATE --
		_DT = love.timer.step()
        if _DT > 0.2 then return end -- prevent screen grabbing
        _ACC = _ACC + _DT
        while _ACC >= _F_DT do 
            love.update(_F_DT); _ACC=_ACC-_F_DT 
            for k,v in pairs(_INPUT._CUR) do _INPUT._PRE[k] = v end -- input update
        end
        -- DRAW --
		if lg.isActive() then lg.origin(); lg.clear(lg.getBackgroundColor()); love.draw(); lg.present()end
		love.timer.sleep(0.001)
    end
end

function love.load()
    camera = Camera(0, 0, 800, 600)
    camera:setPosition(400, 300)
    main_room_mgr = RoomMgr()
    main_room_mgr:add("play_room", Play_Room())
    main_room_mgr:add("menu_room", Menu_Room())
    main_room_mgr:changeRoom("play_room")

    play = true
    mode = "play"
end

function love.update(dt)
    if play then 
        camera:update(dt)
        main_room_mgr:update(dt)
    end
    if mode == "frame" then play = false end

    if pressed("1") then
        if     mode == "play"  then mode = "frame"
        elseif mode == "frame" then mode = "play"; play = true end
    end
    if pressed("2") then play = true end

    if pressed("escape") then love.load() end
end

function love.draw()
    camera:draw(function() 
        main_room_mgr:draw()
    end)
end