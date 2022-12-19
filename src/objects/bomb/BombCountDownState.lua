BombCountDownState = Class{__includes = BaseState}


function BombCountDownState:init(bomb)

    self.bomb = bomb

    self.visible = true -- Bomb should twinkle
end


function BombCountDownState:enter(params)

    self.toggleVisibleTimer = params.toggleVisibleTimer -- Time in seconds to toggle self.visible
    self.twinklings = params.twinklings

    self.timer = self.toggleVisibleTimer
    self.twinkled = 0
end


function BombCountDownState:update(dt)

    self.timer = self.timer - dt
    if self.timer <= 0 then
        
        self.visible = not self.visible
        self.twinkled = self.twinkled + 1

        if self.twinkled == self.twinklings then

            if self.toggleVisibleTimer <= 0.05 then
                
                self.bomb.state:change('explosion')
            end
            
            self.toggleVisibleTimer = self.toggleVisibleTimer/2
            self.twinklings = self.twinklings * 2

            self.twinkled = 0
        end

        self.timer = self.toggleVisibleTimer
    end
end


function BombCountDownState:render()

    if self.visible then
        
        love.graphics.setColor(self.bomb.color.r, self.bomb.color.g, self.bomb.color.b, 1)
        love.graphics.circle('fill', self.bomb.x, self.bomb.y, BOMB_RADIUS)
    end
end