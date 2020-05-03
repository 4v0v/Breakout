Chroma = Class:extend('Chroma')

function Chroma:new(w, h)
	self.timer = Timer()
	self.shader = lg.newShader('assets/shaders/chroma.frag')
	self.final_canvas = lg.newCanvas(lg.getWidth(), lg.getHeight())

	self.offset = 0
	self.angle = 0
	self.target_angle = 0
end

function Chroma:get_canvas(canvas)
	self.offset = tools.lerp(self.offset, 0, 0.1)
	self.angle = tools.lerp(self.angle, self.target_angle, 0.1)

	local dx = math.cos(self.angle) * self.offset / lg.getWidth()
	local dy = math.sin(self.angle) * self.offset / lg.getHeight()

	lg.setCanvas(self.final_canvas)
	lg.clear()
        lg.setShader(self.shader)
        self.shader:send('direction', {dx, dy})
            lg.draw(canvas)
        lg.setShader()
	lg.setCanvas()

	return self.final_canvas
end

function Chroma:add_aberration(offset)
	self.target_angle = (self.target_angle + tools.random(100)) % (2 * math.pi)
	self.offset = offset or tools.random(10, 20)
end