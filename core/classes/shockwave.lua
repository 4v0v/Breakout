Shockwave = Class:extend('Shockwave')

function Shockwave:new()
	self.timer = Timer()
	self.img = lg.newImage('assets/images/shockwave.png')
	self.shader = lg.newShader('assets/shaders/shockwave.frag')
	self.shockwaves_canvas = lg.newCanvas(lg.getWidth(), lg.getHeight())
	self.final_canvas = lg.newCanvas(lg.getWidth(), lg.getHeight())
	self.shockwaves = {}
end

function Shockwave:update(dt)
	self.timer:update(dt)
end

function Shockwave:get_canvas(canvas)
	-- draw the shockwaves
	lg.setCanvas(self.shockwaves_canvas)
	lg.clear()
		for _, v in pairs(self.shockwaves) do 
			lg.setColor(1,1,1, v.alpha)
			lg.draw(self.img, v.x, v.y, 0, v.scale, v.scale, self.img:getWidth()/2, self.img:getHeight()/2 )
		end
		lg.setColor(1,1,1,1)
	lg.setCanvas()

	-- insert the shockwaves into the canvas
	lg.setCanvas(self.final_canvas)
	lg.clear()
		lg.setShader(self.shader)
		self.shader:send('displacement_map', self.shockwaves_canvas)
			lg.draw(canvas, 0, 0)
		lg.setShader()
	lg.setCanvas()

	return self.final_canvas
end

function Shockwave:add_shockwave(x, y)
	local uid = tools.uid();
	self.shockwaves[uid] = {
		x = x, 
		y = y, 
		scale = 0,
		alpha = 1,
		uid = uid
	}
	self.timer:tween(0.3, self.shockwaves[uid], {scale = 0.5, alpha = 0}, 'out-quad', function() self.shockwaves[uid] = nil end)
end