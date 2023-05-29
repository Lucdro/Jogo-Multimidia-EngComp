--requires
require("pallets.defaultPallet")
--settings.lua
Settings = {
    windowSize ={
        width = {},
        height = {}
    },
    pixelwidth = 5,
    pixelheight = 5,
    spritelenght = 16,
    selectedPallet = {},
    currentPallet = 1,
    minSpritesx = 16,
    maxSpritesx = 32,
    minSpritesy = 10,
    maxSpritesy = 20,
    minpixelwidth = 1,
    minpixelheight = 1,
    fontsize = 10,
    savefile = "data.txt",
    fontFile = "/fonts/Pixeled.ttf",
    font = {}
}

function Settings:defaultSettings()
    self:setWindowSize({width = 1280, height =720})
    self.pixelheight = 5
    self.pixelwidth = 5
    self.selectedPallet = DefaultPallet
    self.currentPallet = 1
    self.font = love.graphics.newFont(self.fontFile, self.fontsize)
end

function Settings:setWindowSize(windowsize)
    self.windowSize = {}
    self.windowSize.width = windowsize.width
    self.windowSize.height = windowsize.height
    love.window.setMode(windowsize.width,windowsize.height)
    self:reScale()
end

function Settings:setScale(x,y)
    self.maxSpritesx = x
    self.maxSpritesy = y
    self:reScale()
end

function Settings:reScale()
    self.pixelwidth = self.windowSize.width/(self.maxSpritesx*self.spritelenght)
    if self.pixelwidth < self.minpixelwidth then
        self.pixelwidth = self.windowSize.width/(self.minSpritesx*self.spritelenght)
    end
    self.pixelheight = self.windowSize.height/(self.maxSpritesy*self.spritelenght)
    if self.pixelheight < self.minpixelheight then
        self.pixelheight = self.windowSize.height/(self.minSpritesy*self.spritelenght)
    end
    self.fontsize = self.pixelwidth * 4
end

function Settings:set(settings)
    self:setWindowSize(settings.windowSize)
    self.pixelwidth = settings.pixelwidth
    self.pixelheight = settings.pixelheight
    self.spritelenght = settings.spritelenght
    self.selectedPallet = settings.selectedPallet
    self.currentPallet = settings.currentPallet
    self.fontsize = settings.fontsize
    self.fontFile = settings.fontFile
    self.font = settings.font
end

function Settings:getHorizontalSprites()
    return (self.windowSize.width/ (self.pixelwidth*Settings.spritelenght)) +1
end

function Settings:getVerticalSprites()
    return (self.windowSize.height/ (self.pixelheight*Settings.spritelenght)) +1
end

function Settings:setFont()
    if self.font == nil then
        self:changeFont(love.graphics.newFont(Settings.fontFile,Settings.fontsize))
    end
    self.font:setLineHeight(self.fontsize/40)
    love.graphics.setFont(self.font)
end

function Settings:changeFont(font)
    self.font = font
    love.graphics.setFont(font)
end

function Settings:halfScreenVertical(spritecount)
    return (self.windowSize.height / 2) - (self.pixelheight * (self.spritelenght / 2 * spritecount)) 
end

function Settings:halfScreenHorizontal(spritecount)
    return (self.windowSize.width / 2) - (self.pixelwidth * (self.spritelenght / 2 * spritecount))
end