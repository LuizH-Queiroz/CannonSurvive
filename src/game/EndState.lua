EndState = Class{__includes = BaseState}


function EndState:init()

    self.textColor = {
        r = math.random(),
        g = math.random(),
        b = math.random()
    }
end


function EndState:enter(params)

    self.survivalTime = params.survivalTime
end


function EndState:update(dt)

    if love.keyboard.keysPressed['return'] then
        
        gStateMachine:change('play')
    end

    -- Updating color (RGB)
    self.textColor.r = self.textColor.r + 0.06 * dt
    if self.textColor.r > 1 then self.textColor.r = 0 end

    self.textColor.g = self.textColor.g + 0.06 * dt
    if self.textColor.g > 1 then self.textColor.g = 0 end

    self.textColor.b = self.textColor.b + 0.06 * dt
    if self.textColor.b > 1 then self.textColor.b = 0 end
end


function EndState:render()

    local defaultFont = love.graphics.getFont() -- default Love2D font
    local font = love.graphics.newFont(48)
    love.graphics.setFont(font)


    love.graphics.setColor(self.textColor.r, self.textColor.g, self.textColor.b, 1)


    love.graphics.print('You survived:', SCREEN_WIDTH/2 - font:getWidth('You Survived:')/2, 50)

    local min = string.format("%d", self.survivalTime / 60)
    local sec = string.format("%d", self.survivalTime % 60)
    local ms = string.format("%d", (self.survivalTime - math.floor(self.survivalTime)) * 1000)
    love.graphics.print(min .. 'min ' .. sec .. 'sec ' .. ms .. 'ms',
        SCREEN_WIDTH/2 - font:getWidth(min .. 'min ' .. sec .. 'sec ' .. ms .. 'ms')/2, 150)
    
    
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)

    love.graphics.print('Press Enter to Play Again',
        SCREEN_WIDTH/2 - font:getWidth('Press Enter to Play Again')/2, 500)


    -- Return font to default settings
    love.graphics.setFont(defaultFont)
end