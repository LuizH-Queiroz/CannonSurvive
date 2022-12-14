Bomber = Class{}


BOMBER_SIZE = 40
BOMBER_SPEED = 120


function Bomber:init()

    self.x = math.random(0, 1) == 0 and (math.random(-120, -90)) or (SCREEN_WIDTH + math.random(90, 120))
    self.y = math.random(0, 1) == 0 and (math.random(-120, -90)) or (SCREEN_HEIGHT + math.random(90, 120))

    self.color = {
        r = math.random(),
        g = math.random(),
        b = math.random()
    }

    self.destination_X = 0
    self.destination_Y = 0

    -- Bomber next destination
    setDestination(self)

    self.bombs = {}
end


function Bomber:update(dt)

    self.x = self.x + self.xVelocity * dt
    self.y = self.y + self.yVelocity * dt

    -- Bombs handling:
    -- Creation
    -- Update
    -- Removal

    local toRemove = {}
    local removed = 0

    if (self.xVelocity < 0 and self.x < self.destination_X)
    or (self.xVelocity > 0 and self.x > self.destination_X) then
        
        table.insert(self.bombs, Bomb(self.x + BOMBER_SIZE/2, self.y + BOMBER_SIZE/2))
        setDestination(self)
    end

    for i, bomb in pairs(self.bombs) do
    
        bomb:update(dt)
        if bomb.remove then
            table.insert(toRemove, i)
        end
    end

    for i, index in pairs(toRemove) do
        table.remove(self.bombs, index - removed)
        removed = removed + 1
    end
end


function Bomber:render()

    for i, bomb in pairs(self.bombs) do

        bomb:render()
    end

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
    love.graphics.rectangle('fill', self.x, self.y, BOMBER_SIZE, BOMBER_SIZE)
end



---------------------------------------------
---------------------------------------------
---------------------------------------------


function setDestination(bomber)

    bomber.destination_X = math.random(0, SCREEN_WIDTH - BOMBER_SIZE)
    bomber.destination_Y = math.random(0, SCREEN_HEIGHT - BOMBER_SIZE)

    local diff_X = bomber.destination_X - bomber.x
    local diff_Y = bomber.destination_Y - bomber.y
    local hypot = math.sqrt(diff_X*diff_X + diff_Y*diff_Y)
    bomber.xVelocity = BOMBER_SPEED * (diff_X/hypot)
    bomber.yVelocity = BOMBER_SPEED * (diff_Y/hypot)
end