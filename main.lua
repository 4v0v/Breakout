function love.run()
    local _DT, _F_DT, _ACC = 0, 1/60, 0
    local _INPUT = {_CUR = {}, _PRE = {}}
    function pressed(key)  return _INPUT._CUR[key]  and not _INPUT._PRE[key] end
    function released(key) return _INPUT._PRE[key] and not _INPUT._CUR[key]  end
    function down(key) if key=="mouse_1"or key=="mouse_2"or key=="mouse_3"then return love.mouse.isDown(tonumber(key:sub(7))) end; return love.keyboard.isDown(key) end  

    Timer  = require("core/libraries/timer")
    Class  = require("core/libraries/class")
    Camera = require("core/libraries/camera")
    vec2   = require("core/libraries/vector")
    require("core/libraries/tools")
    require("core/modules/room_mgr")
    require("core/modules/room")
    require("core/modules/entity")
    tools.require("rooms")
    tools.require("entities")
    
    lg = love.graphics
    lg.setDefaultFilter("nearest", "nearest")
    lg.setLineStyle("rough")
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
            if name == "keypressed"    then _INPUT._CUR[a]            = true            end
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
    Main_Room(main_room_mgr, "main_room")
    main_room_mgr:changeRoom("main_room")
end

function love.update(dt)
    camera:update(dt)
    main_room_mgr:update(dt)

    if pressed("escape") then love.load() end
end

function love.draw()
    camera:draw(function() 
        main_room_mgr:draw()
    end)
end