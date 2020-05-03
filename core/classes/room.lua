Room = Class:extend('Room')

function Room:new()
    self.timer   = Timer()
    self.__id    = nil
    self.__tag   = nil
    self.__mgr   = nil
    self.__queue = {}
    self.__ents  = {}
end

function Room:update(dt)
    self.timer:update(dt)

    for tag, entity in pairs(self.__queue) do
        self.__ents[tag] = entity
        entity:init()
    end
    self.__queue = {}

    for tag, entity in pairs(self.__ents) do
        entity:update(dt)
        if entity.__dead then
            entity.timer:destroy()
            entity = {}
            self.__ents[tag] = nil
        end
    end
end

function Room:draw()
    local sort_table = {}
    for _, entity in pairs(self.__ents) do table.insert(sort_table, entity) end
    table.sort(sort_table, function(a, b) if a.z == b.z then return a.__id < b.__id else return a.z < b.z end end)
    for _, entity in pairs(sort_table) do entity:draw() end
end

function Room:add(t, e)
    local tag, entity
    if type(t) == 'table' then tag = nil; entity = t else tag = t; entity = e end
    entity.__id    = tools.uid()
    entity.__tag   = tag or entity:class() .. '_' .. entity.__id
    entity.__room  = self
    self.__queue[entity:tag()] = entity
    return entity
end

function Room:get(tag) return self.__ents[tag] end
function Room:is_entity(tag) return not not self.__ents[tag] end
function Room:enter() end 
function Room:leave() end
function Room:mgr() return self.__mgr end

function Room:foreach(filter, func)
    for _, entity in pairs(self.__ents) do
        if type(filter) == 'table' then 
            for _, class in pairs(filter) do 
                if entity:class() == class then func(entity, entity:tag(), entity:class()) end
            end
        elseif type(filter) == 'string' and filter == 'All' then 
            func(entity, entity:tag(), entity:class()) 
        elseif type(filter) == 'string' then 
            if entity:class() == filter then func(entity, entity:tag(), entity:class()) end
        end
    end
end

function Room:count(filter) local count = 0; self:foreach(filter, function() count = count + 1 end); return count end