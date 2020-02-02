RoomMgr = Class:extend("RoomMgr")

-------------------------------
-------------------------------

function RoomMgr:new()
    self.rooms = {}
    self.currentRoom = false 
end

function RoomMgr:update(dt)
    if not self.currentRoom then return end
    self.rooms[self.currentRoom]:update(dt)
end

function RoomMgr:draw()
    if not self.currentRoom then return end
    self.rooms[self.currentRoom]:draw()
end

function RoomMgr:changeRoom(tag)
    local prevRoom, nextRoom = self.currentRoom, tag
    self.currentRoom = tag
end