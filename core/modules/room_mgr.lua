RoomMgr = Class:extend("RoomMgr")

-------------------------------
-------------------------------
-------------------------------

function RoomMgr:new()
    self.timer = Timer()
    self.rooms = {}
    self.currentRoom = false 
end

function RoomMgr:update(dt)
    self.timer:update(dt)
    if not self.currentRoom then return end
    self.rooms[self.currentRoom]:update(dt)
end

function RoomMgr:draw()
    if not self.currentRoom then return end
    self.rooms[self.currentRoom]:draw()
end

function RoomMgr:changeRoom(tag)
    local previousRoom = self.currentRoom
    local nextRoom = tag

    self.currentRoom = tag
end