Bomber = Class{}


BOMBER_MAX_HEALTH = 8

BOMBER_SPEED = 120


function Bomber:init(bombsTable)

    self.x = math.random(0, 1) == 0 and (math.random(-120, -90)) or (SCREEN_WIDTH + math.random(90, 120))
    self.y = math.random(0, 1) == 0 and (math.random(-120, -90)) or (SCREEN_HEIGHT + math.random(90, 120))

    self.width = 40
    self.height = 40

    self.color = {
        r = math.random(),
        g = math.random(),
        b = math.random()
    }

    self.destination_X = 0
    self.destination_Y = 0

    -- Bomber next destination
    setDestination(self)

    self.bombs = bombsTable

    self.healthBar = HealthBar(BOMBER_MAX_HEALTH, BOMBER_MAX_HEALTH)
end


function Bomber:update(dt)

    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt

    -- Bombs creation
    if (self.xVelocity < 0 and self.x < self.destination_X)
    or (self.xVelocity > 0 and self.x > self.destination_X) then
        
        table.insert(self.bombs, Bomb(self.x + self.width/2, self.y + self.height/2))
        setDestination(self)
    end


    -- Health Bar
    self.healthBar:update(dt)
end


function Bomber:render()

    for i, bomb in pairs(self.bombs) do

        bomb:render()
    end

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    -- Health Bar
    self.healthBar:render(self.x - 5, self.y - 10, self.width + 10, 5)
end



---------------------------------------------
---------------------------------------------
---------------------------------------------


function Bomber:collides(player)
    
    return CircleRect_Collision(player, self)
end


function setDestination(bomber)

    bomber.destination_X = math.random(0, SCREEN_WIDTH - bomber.width)
    bomber.destination_Y = math.random(0, SCREEN_HEIGHT - bomber.height)

    local diff_X = bomber.destination_X - bomber.x
    local diff_Y = bomber.destination_Y - bomber.y
    local hypot = math.sqrt(diff_X*diff_X + diff_Y*diff_Y)
    bomber.xVelocity = BOMBER_SPEED * (diff_X/hypot)
    bomber.yVelocity = BOMBER_SPEED * (diff_Y/hypot)
end