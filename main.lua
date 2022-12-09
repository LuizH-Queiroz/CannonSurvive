-- Including libraries
Class = require 'libs/class'

require 'src/states/game/BaseState'
require 'src/states/game/PlayState'

require 'src/Player'
require 'src/Projectile'
require 'src/StateMachine'


-- Constants
SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720



function love.load()

    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {
        resizable = false,
        vsync = true
    })


    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end
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