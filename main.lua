-- Including libraries
Class = require 'libs/class'

-- src/
require 'src/Utility'
require 'src/HealthBar'
require 'src/Player'
require 'src/StateMachine'

-- src/game
require 'src/game/BaseState'
require 'src/game/PlayState'
require 'src/game/EndState'

-- src/enemies
require 'src/enemies/Bomber'

require 'src/enemies/follower/Follower'
require 'src/enemies/follower/FollowerIdleState'
require 'src/enemies/follower/FollowerFollowState'

-- src/objects
require 'src/objects/Projectile'

require 'src/objects/bomb/Bomb'
require 'src/objects/bomb/BombOnHoldState'
require 'src/objects/bomb/BombCountDownState'
require 'src/objects/bomb/BombExplosionState'


-- Constants
SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720



function love.load()

    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {
        resizable = false,
        vsync = true
    })
    love.window.setTitle('CannonSurvive')

    math.randomseed(os.time())


    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['end'] = function() return EndState() end
    }
    gStateMachine:change('play')


    love.mouse.setVisible(false)
end



function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end



function love.update(dt)

    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end



function love.draw()

    love.graphics.setBackgroundColor(1, 1, 1)

    gStateMachine:render()
        
    love.graphics.setColor(1, 1, 0, 1)
    love.graphics.setPointSize(10)
    love.graphics.points(love.mouse.getPosition())
end