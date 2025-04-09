local Circle = require("circle")

function love.load()
  position1 = nil
  position2 = nil
  position3 = nil
  position4 = nil
  circles = {}
end

function love.update(dt)
  for i = #circles, 1, -1 do
    local circle = circles[i]
    if circle.alpha < 0.2 then
      table.remove(circles, i)
    else
      circle:update(dt)
    end
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 255, 1)
  love.graphics.print("Balls: " .. #circles, 10, 10, 0, 2, 2)
  if position1 and position2 and position3 and position4 then
    love.graphics.setColor(255, 255, 255, 1)
    love.graphics.line(position1, position2, position3, position4)
  end
  
  for _, circle in ipairs(circles) do
    circle:draw()
  end
end

function love.mousepressed(x, y, button)
  position1 = love.mouse.getX()
  position2 = love.mouse.getY()
end

function love.mousemoved(x, y, dx, dy)
  position3 = love.mouse.getX()
  position4 = love.mouse.getY()
end

function love.mousereleased(x, y, button)
  if position1 and position2 and position3 and position4 then
    
    local dx = position3 - position1
    local dy = position4 - position2
    local magnitude = math.sqrt(dx * dx + dy * dy)
    
    if magnitude > 0 then
      dx = dx / magnitude
      dy = dy / magnitude
      
      local speed = magnitude * 2
      local vx = dx * speed
      local vy = dy * speed
    
      table.insert(circles, Circle:new(position1, position2, -vx, -vy))
    end
  end
  position1, position2, position3, position4 = nil
end