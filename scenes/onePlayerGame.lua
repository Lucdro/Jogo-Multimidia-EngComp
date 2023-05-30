--requires
require("objects.snakehead")
require("objects.snakeTail")
require("objects.snakeTailEnd")
require("objects.snakeTailDiagonal")
require("objects.apple")
require("scenes.genericScene")
--onePlayerGame.lua
OnePlayerGame = {

}
setmetatable(OnePlayerGame,MetaGenericScene)

function OnePlayerGame:load()
    self.switch = false
    Settings:setScale(12,7)
    self.objects = {
        SnakeHead.new(0,0),
        SnakeTail.new(Settings:getSpriteWidth(),0),
        SnakeTailDiagonal.new(0,Settings:getSpriteHeight()),
    }
end

function OnePlayerGame:update(dt)
    self:checkPallet()
    self:checkFocus()
    if love.keyboard.keysPressed['escape'] == true then 
        self.newScene = 2
        self.switch = true
    end
end
