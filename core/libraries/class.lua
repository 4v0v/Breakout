local Class = {}
function Class:new() end
function Class:extend() local obj = {} obj.__call, obj.__index, obj.super = self.__call, obj, self return setmetatable(obj, self) end
function Class:__index(v) return Class[v] end
function Class:__call(...) local obj = setmetatable({}, self) obj:new(...) return obj end
return Class