--[[
    Your love2d game start here
]]
require("tables.game")
require("tables.settings")

function love.load()
    -- init something here ...
    love.window.setTitle('Snoki')
    local icon = love.image.newImageData("assets/apple.png")
    love.window.setIcon(icon)
    love.graphics.setDefaultFilter("nearest","nearest")
    Game:recoverData()
    Settings:setFont()
    --Settings:setWindowSize({width = 1280, height = 720})
    Game:setScene(2)
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    love.window.setMode(w,h,{fullscreen = false})
end

function love.keypressed(key)
    if key == 'escape' then love.quit() end

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

function love.quit()
    Game.data:saveOnFile()
    love.event.quit()
end
