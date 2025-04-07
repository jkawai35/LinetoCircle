local Circle = {}
Circle.__index = Circle

function Circle:new(x, y, vx, vy)
  local c = {
    x = x,
    y = y,
    vx = vx,
    vy = vy,
    alpha = 1,
    color = {love.math.random(), love.math.random(), love.math.random()},
    radius = 30
  }
  setmetatable(c, Circle)
  return c
end

function Circle:update(dt)
  self.x = self.x + self.vx * dt
  self.y = self.y + self.vy * dt

  local screenWidth = love.graphics.getWidth()
  local screenHeight = love.graphics.getHeight()
  local alphaDecrease = 0.8

  -- Bounce off left/right
  if self.x - self.radius < 0 then
    self.x = self.radius
    self.vx = -self.vx
    self.radius = self.radius * 0.8
    self.alpha = self.alpha * alphaDecrease
  elseif self.x + self.radius > screenWidth then
    self.x = screenWidth - self.radius
    self.vx = -self.vx
    self.radius = self.radius * 0.8
    self.alpha = self.alpha * alphaDecrease
  end

  -- Bounce off top/bottom
  if self.y - self.radius < 0 then
    self.y = self.radius
    self.vy = -self.vy
    self.radius = self.radius * 0.8
    self.alpha = self.alpha * alphaDecrease
  elseif self.y + self.radius > screenHeight then
    self.y = screenHeight - self.radius
    self.vy = -self.vy
    self.radius = self.radius * 0.8
    self.alpha = self.alpha * alphaDecrease
  end
end

function Circle:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
  love.graphics.circle("line", self.x, self.y, self.radius)
end

return Circle
