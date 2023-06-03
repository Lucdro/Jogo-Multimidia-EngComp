--requires
require("objects.snakehead")
require("objects.snakeTailDiagonal")
require("scenes.genericScene")
--twoPlayerGame.lua
TwoPlayerGame = {

}
setmetatable(TwoPlayerGame,MetaGenericScene)

function TwoPlayerGame:load()
    self.switch = false
    Settings:setScale(12,7)
    self.objects = {
        SnakeHead.new(0,0),
        SnakeTailDiagonal.new(100,100)
    }
end

function TwoPlayerGame:update(dt)
    self:checkPallet()
    self:checkFocus()
    if love.keyboard.keysPressed['escape'] == true then 
        self.newScene = 2
        self.switch = true
    end
end
