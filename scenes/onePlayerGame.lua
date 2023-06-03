--requires
require("objects.snakeGame")
require("scenes.genericScene")
--onePlayerGame.lua
OnePlayerGame = {
}
setmetatable(OnePlayerGame,MetaGenericScene)
local game = {}
function OnePlayerGame:load()
    self.switch = false
    Settings:setScale(32,18)
    self.backGroundSprite = Wall
    self:createBackground()
    --matrix 16 -> scene 32 -> 8 left on the sides
    local gamex = Settings.pixelwidth * Settings.spritelenght * 8
    --matrix 9 -> scene 18 -> 4.5 on top and bottom -> needs more on top
    local gamey = Settings.pixelheight * Settings.spritelenght * 6
    game = SnakeGame.new(gamex,gamey,16,9)
    table.insert(self.objects,game)
end

function OnePlayerGame:update(dt)
    self:checkPallet()
    self:checkFocus()
    if love.keyboard.keysPressed['escape'] == true then
        self.newScene = 2
        self.switch = true
    end
    if love.keyboard.keysPressed['p'] == true then game.pause = not(game.pause) end
    if love.keyboard.keysPressed['r'] == true then game:reset() end
    if love.keyboard.keysPressed['right'] == true then game.lastInput = "right"
    elseif love.keyboard.keysPressed['down'] == true then game.lastInput = "down"
    elseif love.keyboard.keysPressed['left'] == true then game.lastInput = "left"
    elseif love.keyboard.keysPressed['up'] == true then game.lastInput = "up" end
    game:update(dt)
end

function OnePlayerGame:draw()
end

