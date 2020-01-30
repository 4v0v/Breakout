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
        if love.filesystem.getInfo(path .. "/" .. v).type == "file" then require(path .. "/" .. v:gsub(".lua", ""))
        elseif love.filesystem.getInfo(path .. "/" .. v).type == "directory" then recursive_require(path .. "/" .. v) end
    end
end