Bomb = Class{}


BOMB_RADIUS = 15
EXPLOSION_RADIUS = 8 * BOMB_RADIUS
EXPLOSION_SPEED = 150

BOMB_ON_HOLD_TIME = 2 -- Time to wait before countdown


function Bomb:init(x, y)

    self.x = x
    self.y = y

    self.color = {
        r = math.random(),
        g = math.random(),
        b = math.random()
    }

    self.state = StateMachine {
        ['on-hold'] = function() return BombOnHoldState(self) end,
        ['count-down'] = function() return BombCountDownState(self) end,
        ['explosion'] = function() return BombExplosionState(self) end
    }
    self.state:change('on-hold')

    self.remove = false
end


function Bomb:update(dt)

    self.state:update(dt)
end


function Bomb:render()

    self.state:render()
end