Transition = Class:extend('Transition')

function Transition:new(w, h)
	self.timer = Timer()
	self.alpha = 0
end

function Transition:update(dt)
	self.timer:update(dt)
end

function Transition:draw(dt)
	lg.setColor(0,0,0,self.alpha)
	lg.rectangle('fill', 0, 0, lg.getWidth(), lg.getHeight())
	lg.setColor(1,1,1)
end

function Transition:fadein()
	self.timer:tween(0.1, self, {alpha = 1}, 'linear', _, function() 
		self.timer:tween(0.1, self, {alpha = 0}, 'linear')
	end)
end