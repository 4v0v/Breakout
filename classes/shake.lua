Shake = Class:extend('Shake')

function Shake:new()
	self.timer = Timer()
	self.final_canvas = lg.newCanvas(lg.getWidth(), lg.getHeight())
	self.shake_amount = 0
end

function Shake:update(dt)
	self.timer:update(dt)
end

function Shake:get_canvas(canvas)
	local x_offset, y_offset = 0, 0
	self.shake_amount = tools.lerp(self.shake_amount, 0, 0.1)

	if not tools.almost(self.shake_amount, 0, 1) then
		x_offset = (tools.random() - 0.5) * self.shake_amount
		y_offset = (tools.random() - 0.5) * self.shake_amount
	end

	lg.setCanvas(self.final_canvas)
	lg.clear()
		lg.translate(x_offset,y_offset)
		lg.draw(canvas, 0, 0)
	lg.setCanvas()

	return self.final_canvas
end

function Shake:add_shake(amount)
	self.shake_amount = amount
end
