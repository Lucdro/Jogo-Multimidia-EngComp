--requires
require("objects.button")
require("objects.ground")
require("pallets.defaultPallet")
require("pallets.redPallet")

--intro.lua
Menu = {
    objects = {},
    nextScene = 2,
    switch = false,
    focus = {},
    background = {}
}

function Menu:load()
    local x = (Settings.windowSize.width/2) - (Settings.pixelwidth * Settings.spritelenght)
    Menu.objects[1] = Button.new(x,200,Settings.selectedPallet,"Single Player")
    Menu.objects[2] = Button.new(x,300,Settings.selectedPallet,"MultiPlayer")
    Menu.objects[3] = Button.new(x,400,Settings.selectedPallet,"Settings")
    Menu.objects[4] = Button.new(x,500,Settings.selectedPallet,"Sair")
    
    local horizontalSprites = (Settings.windowSize.width/ (Settings.pixelwidth*Settings.spritelenght)) +1
    local verticalSprites = (Settings.windowSize.height/ (Settings.pixelheight*Settings.spritelenght)) +1

    for i = 0, horizontalSprites do
        self.background[#self.background+1] = {}
        for j = 0, verticalSprites do
            self.background[i+1][j+1] = Ground.new(Settings.pixelwidth*Settings.spritelenght*i,
            Settings.pixelheight*Settings.spritelenght*j, Settings.selectedPallet)
        end 
    end
end

function Menu:update(dt)
    Menu:checkFocus()
    if love.mouse.isDown(1) and self.objects[1].onFocus then
        self:onClick(1)
    end
    if love.mouse.isDown(1) and self.objects[2].onFocus then
        self:onClick(2)
    end
    if love.mouse.isDown(1) and self.objects[3].onFocus then
        self:onClick(3)
    end
    if love.mouse.isDown(1) and self.objects[4].onFocus then
        self:onClick(4)
    end
    if love.keyboard.wasPressed("d") then
        self:setPallet(DefaultPallet)
    elseif love.keyboard.wasPressed("a") then
        self:setPallet(RedPallet)
    end
end

function Menu:draw()
    for i = 1, #self.background do
        for j = 1, #self.background[i] do
            self.background[i][j]:draw()
        end
    end
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
end

function Menu:onClick(n)
    Menu.objects[n]:setText("Clickou!")
end

function Menu:checkFocus()
    for i = 1, #self.objects do
        self.objects[i].onFocus = self.objects[i]:checkInside(love.mouse.getPosition())
        self.objects[i]:setFocus(self.objects[i].onFocus)
    end
end

function Menu:setPallet(pallet)
    Settings.selectedPallet = pallet
    for i = 1, #self.background do
        for j = 1, #self.background[i] do
            self.background[i][j]:setPallet(pallet)
        end
    end
    for i = 1, #self.objects do
        self.objects[i]:setPallet(pallet)
    end
end

