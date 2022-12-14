BombOnHoldState = Class{__includes = BaseState}


function BombOnHoldState:init(bomb)

    self.bomb = bomb
    self.timer = BOMB_ON_HOLD_TIME
end


function BombOnHoldState:update(dt)

    self.timer = self.timer - dt
    if self.timer <= 0 then

        self.bomb.state:change('count-down')
    end
end


function BombOnHoldState:render()

    love.graphics.setColor(self.bomb.color.r, self.bomb.color.g, self.bomb.color.b, 1)
    love.graphics.circle('fill', self.bomb.x, self.bomb.y, BOMB_RADIUS)
end