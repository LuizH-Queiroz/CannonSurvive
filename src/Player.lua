Player = Class{}


PLAYER_MAX_HEALTH = 50
PLAYER_AUTO_HEAL_AMOUNT = 5 -- Healing per second
PLAYER_AUTO_HEAL_COOLDOWN = 3

PLAYER_VERTICAL_ACCELERATION = 350
PLAYER_HORIZONTAL_ACCELERATION = 250

PLAYER_PROJECTILE_VELOCITY = 750

NEW_PROJECTILE_TIME = 0.6 -- Time in seconds


function Player:init()

    self.radius = 20

    self.x = SCREEN_WIDTH/2
    self.y = SCREEN_HEIGHT/2

    self.xVelocity = 0
    self.yVelocity = 0

    self.projectiles = {}
    self.newProjectileTimer = 0

    self.healthBar = HealthBar(PLAYER_MAX_HEALTH, PLAYER_MAX_HEALTH, PLAYER_AUTO_HEAL_AMOUNT, PLAYER_AUTO_HEAL_COOLDOWN)
end


function Player:update(dt)

    -- Player yVelocity and xVelocity
    -- Acceleration must double if actual velocity has opposite sign
    if love.keyboard.isDown('w') then
        self.yVelocity = self.yVelocity - PLAYER_VERTICAL_ACCELERATION * dt * (self.yVelocity > 0 and 2 or 1)
    end
    
    if love.keyboard.isDown('s') then
        self.yVelocity = self.yVelocity + PLAYER_VERTICAL_ACCELERATION * dt * (self.yVelocity < 0 and 2 or 1)
    end


    if love.keyboard.isDown('a') then
        self.xVelocity = self.xVelocity - PLAYER_HORIZONTAL_ACCELERATION * dt * (self.xVelocity > 0 and 2 or 1)
    end

    if love.keyboard.isDown('d') then
        self.xVelocity = self.xVelocity + PLAYER_HORIZONTAL_ACCELERATION * dt * (self.xVelocity < 0 and 2 or 1)
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
            self.x + 20 * (diff_X/hypot),
            self.y + 20 * (diff_Y/hypot),
            PLAYER_PROJECTILE_VELOCITY * diff_X/hypot,
            PLAYER_PROJECTILE_VELOCITY * diff_Y/hypot,
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


    -- Health Bar render
    self.healthBar:render(
        self.x - self.radius,
        self.y - self.radius - 25,
        self.radius * 2,
        10
    )
end