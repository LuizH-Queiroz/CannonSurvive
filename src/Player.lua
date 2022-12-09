Player = Class{}


PLAYER_VERTICAL_SPEED = 350
PLAYER_HORIZONTAL_SPEED = 250

NEW_PROJECTILE_TIME = 0.6 -- Time in seconds


function Player:init()

    self.radius = 20

    self.x = SCREEN_WIDTH/2
    self.y = SCREEN_HEIGHT/2

    self.xVelocity = 0
    self.yVelocity = 0

    self.projectiles = {}
    self.newProjectileTimer = 0
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
    -- Player can only partially move out of window bounds
    self.x = self.x + self.xVelocity * dt
    if self.x < 0 then

        self.x = 0
        self.xVelocity = 0
    elseif self.x > SCREEN_WIDTH then
        
        self.x = SCREEN_WIDTH
        self.xVelocity = 0
    end

    self.y = self.y + self.yVelocity * dt
    if self.y < 0 then
        
        self.y = 0
        self.yVelocity = 0
    elseif self.y > SCREEN_HEIGHT then

        self.y = SCREEN_HEIGHT
        self.yVelocity = 0
    end
    -------------


    -- calculating the rectangle rotation
    local mouseX, mouseY = love.mouse.getPosition()
    local diff_X = mouseX - self.x -- difference between Mouse X and Circle X
    local diff_Y = mouseY - self.y -- difference between Mouse Y and Circle Y

    if diff_X > 0 and diff_Y > 0 then
        self.mouseFollowRotation = math.abs(math.atan(diff_Y/diff_X)) - math.pi/2
    elseif diff_X < 0 and diff_Y > 0 then
        self.mouseFollowRotation = -math.abs(math.atan(diff_Y/diff_X)) + math.pi/2
    elseif diff_X < 0 and diff_Y < 0 then
        self.mouseFollowRotation = math.abs(math.atan(diff_Y/diff_X)) + math.pi/2
    elseif diff_X > 0 and diff_Y < 0 then
        self.mouseFollowRotation = -math.abs(math.atan(diff_Y/diff_X)) - math.pi/2
    end
    -------------



    -- Projectiles creation, update and removal

    -- Creating a projectile, if 1s has passed since last projectile
    local toRemove = {} -- Projectiles (indexes) to be removed
    local removed = 0 -- Number of removed projectiles

    self.newProjectileTimer = self.newProjectileTimer + dt
    if self.newProjectileTimer >= NEW_PROJECTILE_TIME then

        local hypot = math.sqrt(diff_X*diff_X + diff_Y*diff_Y)
        table.insert(self.projectiles, Projectile(
            self.x,
            self.y,
            400 * (math.abs(diff_X/hypot) * (diff_X > 0 and 1 or -1)),
            400 * (math.abs(diff_Y/hypot) * (diff_Y > 0 and 1 or -1)),
            12
        ))

        self.newProjectileTimer = 0
    end

    -- Update projectiles
    for i, projectile in pairs(self.projectiles) do

        projectile:update(dt)
        if projectile.remove then
            table.insert(toRemove, i)
        end
    end

    -- Remove projectiles
    for i, index in pairs(toRemove) do
        table.remove(self.projectiles, index - removed)
        removed = removed + 1
    end
end


function Player:render()

    for i, projectile in pairs(self.projectiles) do
        projectile:render()
    end

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