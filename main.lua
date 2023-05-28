--[[
    Your love2d game start here
]]
require("tables.game")
Game:recoverData()
love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    -- init something here ...
    love.window.setTitle('Snoki')
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    love.window.setMode(w,h,{fullscreen = false})
end

function love.keypressed(key)
    if key == 'escape' then
        Game.data:saveOnFile()
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    -- change some values based on your actions
    Game:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    -- draw your stuff here
    Game:draw()
end

