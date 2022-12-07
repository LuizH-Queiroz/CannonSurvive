Player = Class{}


PLAYER_VERTICAL_SPEED = 350
PLAYER_HORIZONTAL_SPEED = 250


function Player:init()

    self.radius = 20

    self.x = SCREEN_WIDTH/2
    self.y = SCREEN_HEIGHT/2

    self.xVelocity = 0
    self.yVelocity = 0
end


function Player:update(dt)

    -- Player yVelocity and xVelocity
    if love.keyboard.isDown('w') then
        self.yVelocity = self.yVelocity - PLAYER_VERTICAL_SPEED * dt
        
        if self.yVelocity > 0 then
            self.yVelocity = self.yVelocity - PLAYER_VERTICAL_SPEED * dt
        end
    end
    
    if love.keyboard.isDown('s') then
        self.yVelocity = self.yVelocity + PLAYER_VERTICAL_SPEED * dt

        if self.yVelocity < 0 then
            self.yVelocity = self.yVelocity + PLAYER_VERTICAL_SPEED * dt
        end
    end


    if love.keyboard.isDown('a') then
        self.xVelocity = self.xVelocity - PLAYER_HORIZONTAL_SPEED * dt

        if self.xVelocity > 0 then
            self.xVelocity = self.xVelocity - PLAYER_HORIZONTAL_SPEED * dt
        end
    end
    if love.keyboard.isDown('d') then
        self.xVelocity = self.xVelocity + PLAYER_HORIZONTAL_SPEED * dt

        if self.xVelocity < 0 then
            self.xVelocity = self.xVelocity + PLAYER_HORIZONTAL_SPEED * dt
        end
    end
    -------------


    -- Player movement
    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt
    -------------


    -- calculating the rectangle rotation
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX = mouseX - self.x -- difference between Mouse X and Circle X
    mouseY = mouseY - self.y -- difference between Mouse Y and Circle Y

    if mouseX > 0 and mouseY > 0 then
        self.mouseFollowRotation = math.abs(math.atan(mouseY/mouseX)) - math.pi/2
    elseif mouseX < 0 and mouseY > 0 then
        self.mouseFollowRotation = -math.abs(math.atan(mouseY/mouseX)) + math.pi/2
    elseif mouseX < 0 and mouseY < 0 then
        self.mouseFollowRotation = math.abs(math.atan(mouseY/mouseX)) + math.pi/2
    elseif mouseX > 0 and mouseY < 0 then
        self.mouseFollowRotation = -math.abs(math.atan(mouseY/mouseX)) - math.pi/2
    end
    -------------
end


function Player:render()

    -- 
    love.graphics.setColor(0, 0, 0, 1)

    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.mouseFollowRotation)
    love.graphics.rectangle('fill', -15, 0, 30, 30)
    love.graphics.pop()
    --

    love.graphics.setColor(0, 1, 1, 1)
    love.graphics.circle('fill', self.x, self.y, self.radius)
end