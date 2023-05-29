--requires
require("tables.data")
require("objects.button")
require("objects.ground")
require("pallets.defaultPallet")
require("pallets.redPallet")
require("scenes.genericScene")
--menu.lua
Menu = {
    
}
setmetatable(Menu,MetaGenericScene)

function Menu:load()
    self.switch = false
    Settings:setScale(12,7)
    --Settings:setWindowSize({width = 640, height = 360})
    local x = (Settings.windowSize.width/2) - (Settings.pixelwidth * Settings.spritelenght)
    local yplus = (Settings.pixelheight * Settings.spritelenght * 1.25)
    local y = (Settings.windowSize.height - 5*yplus)/2
    Menu.objects[1] = Button.new(x,y + 0*yplus,Settings.selectedPallet,"Single Player")
    Menu.objects[2] = Button.new(x,y + 1*yplus,Settings.selectedPallet,"Two Players")
    Menu.objects[3] = Button.new(x,y + 2*yplus,Settings.selectedPallet,"Settings")
    Menu.objects[4] = Button.new(x,y + 3*yplus,Settings.selectedPallet,"Intro")
    Menu.objects[5] = Button.new(x,y + 4*yplus,Settings.selectedPallet,"Sair")
    
    --create background
    for i = 0, Settings:getHorizontalSprites() do
        self.background[#self.background+1] = {}
        for j = 0, Settings:getVerticalSprites() do
            self.background[i+1][j+1] = Ground.new(Settings.pixelwidth*Settings.spritelenght*i,
            Settings.pixelheight*Settings.spritelenght*j, Settings.selectedPallet)
        end 
    end
end

function Menu:update(dt)
    self:checkPallet()
    self:checkFocus()
    if love.mouse.isDown(1) and self.objects[1].onFocus then
        self.nextScene = 4
        self.switch = true
    end
    if love.mouse.isDown(1) and self.objects[2].onFocus then
        self.nextScene = 5
        self.switch = true
    end
    if love.mouse.isDown(1) and self.objects[3].onFocus then
        self.nextScene = 3
        self.switch = true
    end
    if love.mouse.isDown(1) and self.objects[4].onFocus then
        self.nextScene = 1
        self.switch = true
    end
    if love.mouse.isDown(1) and self.objects[5].onFocus then
        Data:saveOnFile()
        love.event.quit()
    end
end


