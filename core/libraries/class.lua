local Class = {}
function Class:new() end
function Class:extend(className) 
    local obj = {}
     obj.className = className or "Object"
     obj.__tostring = self.__tostring
     obj.__call = self.__call
     obj.__index = obj
     obj.super = self 
    return setmetatable(obj, self) 
end
function Class:__index(v) return Class[v] end
function Class:__call(...) local obj = setmetatable({}, self) obj:new(...) return obj end
function Class:__tostring() return self.className end
return Class