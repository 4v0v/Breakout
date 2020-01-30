Entity = Class:extend("Entity")

-------------------------------
-------------------------------

function Entity:new(room, tag, x, y, z)
    self.__id  = tools.uuid()
    self.tag   = tag or self.__id
    self.timer = Timer()
    self.room  = room
    self.x     = x or 0
    self.y     = y or 0
    self.z     = z or 0
    self.dead  = false 

    self.room.entities[self.tag] = self
end
function Entity:update(dt) self.timer:update(dt) end
function Entity:draw() end
function Entity:kill() self.dead = true end
function Entity:get_id() return self.__id end
function Entity:get_tag() return self.tag end
