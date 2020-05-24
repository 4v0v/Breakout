Lightning = Entity:extend('Lightning')

function Lightning:new(x1, y1, x2, y2)
	self.x, self.y = ( x1+x2)/2, (y1+y2)/2
	Lightning:super().new(self, self.x, self.y, 1)

	self.lines = {}
	table.insert(self.lines, {x1 = x1, y1 = y1, x2 = x2, y2 = y2})
	self.generations = 5
	self.max_offset = 200
	self.duration = 0.8
	self.alpha = 1
end

function Lightning:init()
	self.timer:tween(self.duration, self, {alpha = 0}, 'in-out-cubic', fn() self:kill() end)

	for j = 1, self.generations do
		for i = #self.lines, 1, -1 do
			local start_point = vec2(self.lines[i].x1, self.lines[i].y1)
			local end_point = vec2(self.lines[i].x2, self.lines[i].y2)
			local mid_point = vec2((start_point.x + end_point.x)/2, (start_point.y + end_point.y)/2)
		
			local offset = vec2(end_point.x - start_point.x, end_point.y - start_point.y):normalized():perpendicular()
	

			mid_point.x += offset.x * tools.random(-self.max_offset, self.max_offset)
			mid_point.y += offset.y * tools.random(-self.max_offset, self.max_offset)



			local direction = mid_point - start_point
			local split_end = direction:rotate(tools.random(math.rad(1), math.rad(3))) * 0.7 + mid_point

			table.remove(self.lines, i)
			if tools.random(10) > 5 then
				table.insert(self.lines, {x1 = mid_point.x, y1 = mid_point.y, x2 = split_end.x, y2 = split_end.y})
			end
			table.insert(self.lines, {x1 = start_point.x, y1 = start_point.y, x2 = mid_point.x, y2 = mid_point.y})
			table.insert(self.lines, {x1 = mid_point.x, y1 = mid_point.y, x2 = end_point.x, y2 = end_point.y})
		end
		self.max_offset /= 2
	end
end
 
function Lightning:update(dt)
	Lightning:super().update(self, dt)
end

function Lightning:draw()
	for i, line in ipairs(self.lines) do 
		love.graphics.setColor(1, 1, 1, self.alpha)
		love.graphics.line(line.x1, line.y1, line.x2, line.y2) 
	end
	love.graphics.setColor(1, 1, 1, 1)

end
