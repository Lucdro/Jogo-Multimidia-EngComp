--requires
require("tables.settings")
--genericScene.lua
GenericScene = {
    background = {},
    objects = {},
    nextScene = 2,
    switch = false,
    focus = {},
    pallet = {},
    backGroundSprite = {}
}

MetaGenericScene = {
    __index = GenericScene
}

function GenericScene.new()
    local newScene = setmetatable({},MetaGenericScene)
    return newScene
end

function GenericScene:drawGeneric()
    if #self.background ~= nil then
        for i = 1, #self.background do
            for j = 1, #self.background[i] do
                self.background[i][j]:draw()
            end
        end
    end
    if #self.objects ~= nil then
        for i = 1, #self.objects do
            self.objects[i]:draw()
        end
    end
end

function GenericScene:onClick()
    
end

function GenericScene:checkFocus()
    if #self.objects ~= nil then
        for i = 1, #self.objects do
            self.objects[i].onFocus = self.objects[i]:checkInside(love.mouse.getPosition())
            if self.objects[i].setFocus ~= nil then
                self.objects[i]:setFocus(self.objects[i].onFocus)
            end
        end
    end
end

function GenericScene:setPallet(pallet)
    self.pallet = pallet
    Settings.selectedPallet = pallet
    if #self.background ~= nil then
        for i = 1, #self.background do
            for j = 1, #self.background[i] do
                self.background[i][j]:setPallet(pallet)
            end
        end
    end
    if #self.objects ~= nil then
        for i = 1, #self.objects do
            self.objects[i]:setPallet(pallet)
        end
    end
end

function GenericScene:checkPallet()
    if self.pallet ~= Settings.selectedPallet then
        self:setPallet(Settings.selectedPallet)
    end
end

function  GenericScene:createBackground()
    --create background
    self.background = {}
    for i = 0, Settings:getHorizontalSprites() do
        self.background[#self.background+1] = {}
        for j = 0, Settings:getVerticalSprites() do
            self.background[i+1][j+1] = self.backGroundSprite.new(Settings.pixelwidth*Settings.spritelenght*i,
            Settings.pixelheight*Settings.spritelenght*j, Settings.selectedPallet)
        end 
    end
end

function GenericScene:draw()
    
end