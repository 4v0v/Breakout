local Class = {}
function Class:new() end
function Class:extend(className) 
    return setmetatable({
        __super    = self,
        __class    = className or "Object",
        __tostring = self.__tostring,
        __call     = self.__call,
        __index    = obj
    }, self)
end
function Class:__index(v) return Class[v] end
function Class:__call(...) local obj = setmetatable({}, self) obj:new(...) return obj end
function Class:__tostring() return self.className end
return Class