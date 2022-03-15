WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 600

push = require 'push'
Class = require 'class'
require 'StateMachine'
require 'states/BaseState'
require 'states/TitleState'


function love.load()
    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        highdpi = true,
        stretched = false
    })

    gStateMachine = StateMachine{
        ['title'] = function () return TitleScreenState() end
    }
    gStateMachine:change('title')
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    gStateMachine.current:keypressed(key)
end

function love.mousepressed(x1, y1)
    x, y = push:toGame(x1, y1)
    gStateMachine.current:mousepressed(x, y)
end

function love.update(dt)
    gStateMachine:update(dt)
end

function love.draw()
    --love.graphics.print(gStateMachine.current)
    push:start()
    gStateMachine:render()
    push:finish()
end