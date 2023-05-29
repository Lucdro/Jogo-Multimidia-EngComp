--requires
require("objects.snakehead")
require("scenes.genericScene")
--intro.lua
Intro = {

}
setmetatable(Intro,MetaGenericScene)

function Intro:load()
    self.switch = false
    Settings:setScale(12,7)
    self.objects = {
        SnakeHead.new(0,0,Settings.selectedPallet)
    }
end

function Intro:update(dt)
    self:checkPallet()
    self:checkFocus()
end
