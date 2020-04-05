function table.size(t) local n = 0 for _ in pairs(t) do n = n + 1 end return n end
function table.keys(t) local l = {} for k in pairs(t) do l[#l + 1] = k end return l end
function table.values(t) local l = {} for _, v in pairs(t) do l[#l + 1] = v end return l end
function table.print(t)
    for k,v in pairs(t) do if type(v) ~= "table" then print(k .. " : " .. tostring(v)) end end
    for k,v in pairs(t) do if type(v) == "table" then print(k .. " : " .. tostring(v)) end end
end

tools = {}
function tools.oequal(a, b, o) return a <= b + o and a >= b - o end
function tools.uuid() local fn = function() local r = math.random(16) return ("0123456789ABCDEF"):sub(r, r) end return ("xxxxxxxxxxxxxxxx"):gsub("[x]", fn) end
function tools.angle(x1, y1, x2, y2) return math_atan2(y2 - y1, x2 - x1) end
function tools.distance(x1, y1, x2, y2, squared) local dx, dy = x1 - x2, y1 - y2 local s = dx * dx + dy * dy return squared and s or math_sqrt(s) end
function tools.require(path)
    for _,v in pairs(love.filesystem.getDirectoryItems(path)) do
        if love.filesystem.getInfo(path .. "/" .. v).type == "file" then require(path .. "/" .. v:gsub(".lua", "")) end
    end
end
function tools.random(x, y)
    if type(x) == "table" then
        return x[love.math.random(#x)]  
    elseif type(x) == "number" and y == nil then 
        if x % math.floor(x) ~= 0 then return love.math.random(x * 1000) / 1000 else return love.math.random(x) end
    elseif type(x) == "number" and type(y) == "number" then 
        if x % math.floor(x) ~= 0 or y % math.floor(y) ~= 0 then return love.math.random(x*1000, y*1000) / 1000 else return love.math.random(x, y) end
    elseif x == nil and y == nil then 
        return love.math.random()
    end
end

function tools.pointRect(x, y, rx, ry, rw, rh) return x >= rx and x <= rx + rw and y >= ry and y <= ry + rh end
function tools.rectRect(x1, y1, w1, h1, x2, y2, w2, h2) return x1 + w1 >= x2 and x1 <= x2 + w2 and  y1 + h1 >= y2 and  y1 <= y2 + h2 end