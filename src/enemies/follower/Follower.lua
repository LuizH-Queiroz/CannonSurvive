Follower = Class{}


function Follower:init()
    
    self.x = math.random(0, 1) == 0 and (math.random(-80, -50)) or (SCREEN_WIDTH + math.random(50, 80))
    self.y = math.random(0, 1) == 0 and (math.random(-80, -50)) or (SCREEN_HEIGHT + math.random(50, 80))

    self.width = 15
    self.height = 15
    
    self.rotation = 0
    self.rotationSpeed = math.random(3, 9)

    self.color = {
        r = math.random(),
        g = math.random(),
        b = math.random(),
    }

    self.state = StateMachine {
        ['idle'] = function() return FollowerIdleState(self) end,
        ['follow'] = function() return FollowerFollowState(self) end
    }
    self.state:change('idle')
end


function Follower:update(dt)

    self.state:update(dt)

    self.rotation = self.rotation + self.rotationSpeed * dt
    if self.rotation > 2*math.pi then
        self.rotation = self.rotation - 2*math.pi
    end


    -- Updating color (RGB)
    self.color.r = self.color.r + 0.06 * dt
    if self.color.r > 1 then self.color.r = 0 end

    self.color.g = self.color.g + 0.06 * dt
    if self.color.g > 1 then self.color.g = 0 end

    self.color.b = self.color.b + 0.06 * dt
    if self.color.b > 1 then self.color.b = 0 end
end


function Follower:render()

    love.graphics.push()

    love.graphics.translate(self.x + self.width/2, self.y + self.height/2)
    love.graphics.rotate(self.rotation)

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
    love.graphics.rectangle('fill', -self.width/2, -self.height/2, self.width, self.height)

    love.graphics.pop()
end