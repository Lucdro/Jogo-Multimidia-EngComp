--requires
require("tables.data")
require("objects.button")
require("objects.ground")
require("objects.wall")
require("scenes.genericScene")
--menu.lua
Menu = {
}
setmetatable(Menu,MetaGenericScene)

local btnSinglePlayer = {}
local btnCredits = {}
local btnSettings = {}
local btnIntro = {}
local btnLeave = {}
local theme = {}

function Menu:load()
    self.switch = false
    Settings:setScale(12,7)
    self:createObjects()
    theme = love.audio.newSource("sounds/02 Vampire Killer.mp3","static")
    self.backGroundSprite = Wall
    self:createBackground()
end

function Menu:update(dt)
    self:checkPallet()
    self:checkFocus()
    if not theme:isPlaying() then love.audio.play(theme) end
    if love.mouse.isDown(1) then Menu:onClick() end
end

function Menu:onClick()
    if btnSinglePlayer.onFocus then
        btnSinglePlayer:playSound()
        self.nextScene = 4
        self.switch = true
    end
    if btnCredits.onFocus then
        btnSinglePlayer:playSound()
        self.nextScene = 5
        self.switch = true
    end
    if btnSettings.onFocus then
        btnSinglePlayer:playSound()
        self.nextScene = 3
        self.switch = true
    end
    if btnIntro.onFocus then
        btnSinglePlayer:playSound()
        self.nextScene = 1
        self.switch = true
    end
    if btnLeave.onFocus then
        btnSinglePlayer:playSound()
        Data:saveOnFile()
        love.event.quit()
    end
end

function Menu:createObjects()
    self.objects = {}
    local x = (Settings.windowSize.width/2) - (Settings.pixelwidth * Settings.spritelenght)
    local yplus = (Settings.pixelheight * Settings.spritelenght * 1.25)
    local y = (Settings.windowSize.height - 5*yplus)/2

    btnSinglePlayer = Button.new("Single\nPlayer",x,y + 0*yplus)
    table.insert(self.objects, btnSinglePlayer)
    
    btnCredits = Button.new("Credits",x,y + 1*yplus)
    table.insert(self.objects, btnCredits)

    btnSettings = Button.new("Settings",x,y + 2*yplus)
    table.insert(self.objects, btnSettings)

    btnIntro = Button.new("Intro",x,y + 3*yplus)
    table.insert(self.objects, btnIntro)

    btnLeave = Button.new("Leave",x,y + 4*yplus)
    table.insert(self.objects, btnLeave)
end
