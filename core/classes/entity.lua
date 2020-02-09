Entity = Class:extend("Entity")

-------------------------------
-------------------------------

function Entity:new(x, y, z)
    self.timer  = Timer()
    self.__id   = nil
    self.__tag  = nil
    self.__room = nil
    self.__dead = false

    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
end

-------------------------------
-------------------------------

function Entity:init() end
function Entity:update(dt) self.timer:update(dt) end
function Entity:draw() end
function Entity:id() return self.__id end
function Entity:tag() return self.__tag end
function Entity:room() return self.__room end
function Entity:kill() self.__dead = true end
