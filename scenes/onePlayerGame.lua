--requires
require("objects.snakehead")
require("scenes.genericScene")
--onePlayerGame.lua
OnePlayerGame = {

}
setmetatable(OnePlayerGame,MetaGenericScene)

function OnePlayerGame:load()
    self.switch = false
    Settings:setScale(12,7)
    self.objects = {
        SnakeHead.new(0,0,Settings.selectedPallet)
    }
end

function OnePlayerGame:update(dt)
    self:checkPallet()
    self:checkFocus()
end
