--requires
require("tables.data")
require("objects.button")
require("objects.ground")
require("scenes.genericScene")
--menu.lua
Menu = {
}
setmetatable(Menu,MetaGenericScene)

local btnSinglePlayer = {}
local btnTwoPlayers = {}
local btnSettings = {}
local btnIntro = {}
local btnLeave = {}

function Menu:load()
    self.switch = false
    Settings:setScale(12,7)
    --Settings:setWindowSize({width = 640, height = 360})
    self:createObjects()

    self.backGroundSprite = Ground
    self:createBackground()
end

function Menu:update(dt)
    self:checkPallet()
    self:checkFocus()
    if love.mouse.isDown(1) then Menu:onClick() end
end

function Menu:onClick()
    if btnSinglePlayer.onFocus then
        self.nextScene = 4
        self.switch = true
    end
    if btnTwoPlayers.onFocus then
        self.nextScene = 5
        self.switch = true
    end
    if btnSettings.onFocus then
        self.nextScene = 3
        self.switch = true
    end
    if btnIntro.onFocus then
        self.nextScene = 1
        self.switch = true
    end
    if btnLeave.onFocus then
        Data:saveOnFile()
        love.event.quit()
    end
end

function Menu:createObjects()
    self.objects = {}
    local x = (Settings.windowSize.width/2) - (Settings.pixelwidth * Settings.spritelenght)
    local yplus = (Settings.pixelheight * Settings.spritelenght * 1.25)
    local y = (Settings.windowSize.height - 5*yplus)/2

    btnSinglePlayer = Button.new(x,y + 0*yplus,Settings.selectedPallet,"Single\nPlayer")
    btnSinglePlayer:setTextPosition(9,0.4)
    table.insert(self.objects, btnSinglePlayer)
    
    btnTwoPlayers = Button.new(x,y + 1*yplus,Settings.selectedPallet,"Two\nPlayers")
    btnTwoPlayers:setTextPosition(8,0.4)
    table.insert(self.objects, btnTwoPlayers)

    btnSettings = Button.new(x,y + 2*yplus,Settings.selectedPallet,"Settings")
    btnSettings:setTextPosition(6.5,3)
    table.insert(self.objects, btnSettings)

    btnIntro = Button.new(x,y + 3*yplus,Settings.selectedPallet,"Intro")
    table.insert(self.objects, btnIntro)

    btnLeave = Button.new(x,y + 4*yplus,Settings.selectedPallet,"Leave")
    table.insert(self.objects, btnLeave)
end
