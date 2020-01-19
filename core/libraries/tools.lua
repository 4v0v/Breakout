function table.size(t) local n = 0 for _ in pairs(t) do n = n + 1 end return n end
function table.keys(t) local l = {} for k in pairs(t) do l[#l + 1] = k end return l end
function table.values(t) local l = {} for _, v in pairs(t) do l[#l + 1] = v end return l end
function oequal(a, b, o) return a <= b + o and a >= b - o end
function uuid() local fn = function() local r = math.random(16) return ("0123456789ABCDEF"):sub(r, r) end return ("xxxxxxxxxxxxxxxx"):gsub("[x]", fn) end

function recursive_require(path)
    for _,v in pairs(love.filesystem.getDirectoryItems(path)) do
        if love.filesystem.getInfo(path .. "/" .. v).type == "file" then require(path .. "/" .. v:gsub(".lua", ""))
        elseif love.filesystem.getInfo(path .. "/" .. v).type == "directory" then recursive_require(path .. "/" .. v) end
    end
end