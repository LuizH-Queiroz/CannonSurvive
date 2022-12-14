Projectile = Class{}


-- Distance a projectile must go out the window bounds to be erased
REMOVE_DISTANCE = 25


function Projectile:init(x, y, xVelocity, yVelocity, size)

    self.x = x
    self.y = y
    self.xVelocity = xVelocity
    self.yVelocity = yVelocity
    self.size = size

    self.remove = false
end


function Projectile:update(dt)

    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt

    if self.x < -REMOVE_DISTANCE or self.x > SCREEN_WIDTH + REMOVE_DISTANCE
    or self.y < -REMOVE_DISTANCE or self.y > SCREEN_HEIGHT + REMOVE_DISTANCE then
        
        self.remove = true -- Now this projectile must be removed from the table it's in
    end
end


function Projectile:render()

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setPointSize(self.size)
    love.graphics.points(self.x, self.y)
end