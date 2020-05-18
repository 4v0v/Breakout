function table.size(t) local n = 0 for _ in pairs(t) do n = n + 1 end return n end
function table.keys(t) local l = {} for k in pairs(t) do l[#l + 1] = k end return l end
function table.values(t) local l = {} for _, v in pairs(t) do l[#l + 1] = v end return l end
function table.print(t)
    for k,v in pairs(t) do if type(v) ~= 'table' then print(k .. ' : ' .. tostring(v)) end end
    for k,v in pairs(t) do if type(v) == 'table' then print(k .. ' : ' .. tostring(v)) end end
end

tools = {}
function tools.almost(a, b, o) return a <= b + o and a >= b - o end
function tools.uid() local fn = function() local r = math.random(16) return ('0123456789ABCDEF'):sub(r, r) end return ('xxxxxxxxxxxxxxxx'):gsub('[x]', fn) end
function tools.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end
function tools.angle_to_vec(angle) return math.cos(angle), math.sin(angle) end
function tools.vec_to_angle(x, y) return math.atan2(y, x) end
function tools.distance(x1, y1, x2, y2) local dx, dy = x1 - x2, y1 - y2 return math_sqrt(dx^2 + dy^2) end
function tools.require(path)
    for _,v in pairs(love.filesystem.getDirectoryItems(path)) do
        if love.filesystem.getInfo(path .. '/' .. v).type == 'file' then require(path .. '/' .. v:gsub('.lua', '')) end
    end
end
function tools.random(x, y, ...)
    if type(x) == 'table' then
        return x[love.math.random(#x)] 
    elseif type(x) == 'string' then
        local values = {x, y, ...}
        return values[love.math.random(#values)] 
    elseif type(x) == 'number' and y == nil then 
        if x % math.floor(x) ~= 0 then return love.math.random(x * 1000) / 1000 else return love.math.random(x) end
    elseif type(x) == 'number' and type(y) == 'number' then 
        if x % math.floor(x) ~= 0 or y % math.floor(y) ~= 0 then return love.math.random(x*1000, y*1000) / 1000 else return love.math.random(x, y) end
    elseif x == nil and y == nil then 
        return love.math.random()
    end
end

function tools.distance_between_angles(x, y) local _x, _y = x + math.pi*0.5, y + math.pi*0.5 return math.atan2(math.sin(_y-_x), math.cos(_y-_x)) end -- x = source, y = target
function tools.lerp(a, b, x) return a + (b - a) * x end
function tools.cerp(a, b, x) local f=(1-math.cos(x*math.pi))*.5 return a*(1-f)+b*f end
function tools.clamp(x, min, max) return x < min and min or (x > max and max or x) end

function tools.rotate_point_around_pivot( cx, cy, ox, oy, angle )
    local rot_pnt = { x, y }
    rot_pnt.x = ox * math.cos(math.rad(-angle)) - oy * math.sin(math.rad(-angle))
    rot_pnt.y = ox * math.sin(math.rad(-angle)) + oy * math.cos(math.rad(-angle))
    return rot_pnt.x + cx, rot_pnt.y + cy
end

function tools.pointRect(x, y, rx, ry, rw, rh) return x >= rx and x <= rx + rw and y >= ry and y <= ry + rh end
function tools.rectRect(x1, y1, w1, h1, x2, y2, w2, h2) 
    if not (x1 + w1 >= x2 and  x1 <= x2 + w2 and  y1 + h1 >= y2 and  y1 <= y2 + h2) then return false end 
    local b_col = y2 + h2 - y1
    local t_col = y1 + h1 - y2
    local l_col = x1 + w1 - x2
    local r_col = x2 + w2 - x1

    if     t_col < b_col and t_col < l_col and t_col < r_col then return true, 'bottom'
    elseif b_col < t_col and b_col < l_col and b_col < r_col then return true, 'top'
    elseif l_col < r_col and l_col < t_col and l_col < b_col then return true, 'right'
    elseif r_col < l_col and r_col < t_col and r_col < b_col then return true, 'left' end
end

local old_print = print
function print(...)
    local info = debug.getinfo(2, 'Sl')
    local source = info.source
    if source:sub(-4) == '.lua' then source = source:sub(1, -5) end
    if source:sub(1,1) == '@' then source = source:sub(2) end
    local msg = ('%s:%i'):format(source, info.currentline)
    old_print(msg, ...)
end

table.insert(package.loaders, 2, function(name)
	local name = name:gsub("%.", "/") .. ".lua"
    local file = love.filesystem.read(name)
    if not file then return nil end

    local var = "([%w%.:_%[%]'\"]+)"
	for i, v in ipairs(
        {
            { pattern = var .. "%s*%+=" , replacement = "%1 = %1 + "}, -- +=
            { pattern = var .. "%s*%-=" , replacement = "%1 = %1 - "},  -- -=
            { pattern = var .. "%s*%*=" , replacement = "%1 = %1 * "}, -- *=
            { pattern = var .. "%s*/="  , replacement = "%1 = %1 / "}, -- /=
            { pattern = var .. "%s*^="  , replacement = "%1 = %1 ^ "}, -- ^=
            { pattern = var .. "%s*%%=" , replacement = "%1 = %1 %% "}, -- %=
            { pattern = var .. "%s*%..=", replacement = "%1 = %1 .. "}, -- ..=
            { pattern = var .. "%+%+"   , replacement = "%1 = %1 + 1"}, -- ++
            { pattern = "&&"            , replacement = " and "},
            { pattern = "||"            , replacement = " or "},
            { pattern = "!="            , replacement = "~="},
            { pattern = "!"             , replacement = " not "},
            { pattern = "([%s,={%(])fn%(", replacement = "%1function("},
        }
    ) do 
		file = file:gsub(v.pattern, v.replacement) 
	end
	return assert(loadstring(file, name))
end)