Room = Class:extend("Room")

-------------------------------
-------------------------------

function Room:new(roomMgr, tag)
    self.__id     = tools.uuid()
    self.__tag    = tag or self.__id
    self.timer    = Timer()
    self.roomMgr  = roomMgr
    self.entities = {}
    self.entity_queue = {}
    
    self.roomMgr.rooms[self.__tag] = self
end

function Room:update(dt)
    self.timer:update(dt)

    for tag, entity in pairs(self.entity_queue) do
        self.entities[tag] = entity
        entity:init()
    end
    self.entity_queue = {}

    for tag, entity in pairs(self.entities) do
        entity:update(dt)
        if entity.__dead then
            entity.timer:destroy()
            entity = {}
            self.entities[tag] = nil
        end
    end
end

function Room:draw()
    local sort_table = {}
    for _, entity in pairs(self.entities) do table.insert(sort_table, entity) end
    table.sort(sort_table, function(a, b) if a.z == b.z then return a.__id < b.__id else return a.z < b.z end end)
    for _, entity in pairs(sort_table) do entity:draw() end
end

function Room:add(t, e)
    local tag, entity;
    if type(t) == "table" then tag = nil; entity = t else tag = t; entity = e end
    entity.__id    = tools.uuid()
    entity.__tag   = tag or entity:class() .. "_" .. entity.__id
    entity.__room  = self
    self.entity_queue[entity:tag()] = entity
    return entity
end

function Room:get(tag) return self.entities[tag] end
function Room:is_entity(tag) return not not self.entities[tag] end

function Room:foreach(filter, func)
    for _, entity in pairs(self.entities) do
        if type(filter) == "table" then 
            for _, class in pairs(filter) do 
                if entity:class() == class then func(entity) end
            end
        elseif type(filter) == "string" and filter == "All" then 
            func(entity) 
        elseif type(filter) == "string" then 
            if entity:class() == filter then func(entity) end
        end
    end
end

function Room:count(filter) local count = 0; self:foreach(filter, function() count = count + 1 end); return count end