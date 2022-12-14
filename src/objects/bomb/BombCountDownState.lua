BombCountDownState = Class{__includes = BaseState}


function BombCountDownState:init(bomb)

    self.bomb = bomb

    self.Visible = true -- Bomb should blink
    self.toggleVisibleTimer = 1 -- Time in seconds to toggle self.Visible
    self.nextTimer = 0.9
end


function BombCountDownState:update(dt)

    self.toggleVisibleTimer = self.toggleVisibleTimer - dt
    if self.toggleVisibleTimer <= 0 then
        
        self.Visible = not self.Visible
        self.toggleVisibleTimer = self.nextTimer
        self.nextTimer = self.nextTimer - 0.1

        if self.toggleVisibleTimer <= 0 then
            
            self.bomb.state:change('explosion')
        end
    end
end


function BombCountDownState:render()

    if self.Visible then
        
        love.graphics.setColor(self.bomb.color.r, self.bomb.color.g, self.bomb.color.b, 1)
        love.graphics.circle('fill', self.bomb.x, self.bomb.y, BOMB_RADIUS)
    end
end