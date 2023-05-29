--requires
require("objects.snakehead")
require("objects.snakeTail")
require("objects.snakeTailEnd")
require("objects.apple")
require("scenes.genericScene")
require("objects.wall")
--intro.lua
Intro = {
    headposition = 0
}
setmetatable(Intro,MetaGenericScene)

function Intro:load()
    self.switch = false
    self.headposition = 0
    Settings:setScale(12,7)
    self.backGroundSprite = Wall
    self:createBackground()
    self.objects = {
        SnakeHead.new(self.headposition,Settings:halfScreenVertical(1),Settings.selectedPallet),
        Apple.new(Settings:halfScreenHorizontal(1),Settings:halfScreenVertical(1),Settings.selectedPallet)
    }
    self.objects[1]:setDirection("right")
end

function Intro:update(dt)
    self:checkPallet()
    self:checkFocus()
end
