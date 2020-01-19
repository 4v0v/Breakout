Entity = Class:extend()

-------------------------------
-------------------------------
-------------------------------

function Entity:new(room, tag, x, y, z)
    self.id    = uuid()
    self.room  = room
    self.timer = Timer()
    self.tag   = tag or self.id
    self.x     = x or 0
    self.y     = y or 0
    self.z     = z or 0
    self.dead  = false 

    self.room.entities[self.tag] = self
end
function Entity:update(dt) self.timer:update(dt) end
function Entity:draw() end
function Entity:is_dead() return self.dead end
function Entity:on_death() end
function Entity:get_id() return self.id end
function Entity:get_tag() return self.tag end
