require("core/run")

function love.load()
    main_room_mgr = RoomMgr()
    Main_Room(main_room_mgr, "main_room")
    main_room_mgr:changeRoom("main_room")
end

function love.update(dt)
    main_room_mgr:update(dt)
end

function love.draw()
    main_room_mgr:draw()
end