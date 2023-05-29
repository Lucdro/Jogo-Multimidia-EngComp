--requires
require("objects.snakehead")
require("scenes.genericScene")
--menuSettings.lua
MenuSettings = {

}
setmetatable(MenuSettings,MetaGenericScene)

function MenuSettings:load()
    self.switch = false
    Settings:setScale(12,7)
    self.objects = {
        SnakeHead.new(0,0,Settings.selectedPallet)
    }
end

function MenuSettings:update(dt)
    self:checkPallet()
    self:checkFocus()
end
