BombExplosionState = Class{__includes = BaseState}


function BombExplosionState:init(bomb)

    self.bomb = bomb
end


function BombExplosionState:update(dt)

    self.bomb.radius = self.bomb.radius + EXPLOSION_SPEED * dt
    if self.bomb.radius > EXPLOSION_RADIUS then
        
        self.bomb.remove = true
    end
end


function BombExplosionState:render()

    love.graphics.setColor(self.bomb.color.r, self.bomb.color.g, self.bomb.color.b, 1)
    love.graphics.circle('fill', self.bomb.x, self.bomb.y, self.bomb.radius)
end