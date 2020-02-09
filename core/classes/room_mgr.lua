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

function RoomMgr:add(t, r)
    local tag, room
    if type(t) == "table" then tag = nil; room = t else tag = t; room = r end
    room.__id  = tools.uuid()
    room.__tag = tag or room:class() .. "_" .. room.__id
    room.__mgr = self

    self.rooms[tag] = room
    return room
end

function RoomMgr:changeRoom(tag)
    local prevRoom, nextRoom = self.currentRoom, tag
    self.currentRoom = tag
end