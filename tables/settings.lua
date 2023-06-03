--requires
require("pallets.blackWhitePallet")
require("tables.pallets")
--settings.lua
Settings = {
    windowSize ={
        width = 0,
        height = 0
    },
    pixelwidth = 5,
    pixelheight = 5,
    spritelenght = 16,
    selectedPallet = {},
    currentPallet = 1,
    spritesx = 16,
    spritesy = 9,
    minpixelwidth = 1,
    minpixelheight = 1,
    fontsize = 10,
    savefile = "data.txt",
    fontFile = "/fonts/Pixeled.ttf",
    font = {},
    title = 'Snoki'
}

function Settings:defaultSettings()
    self.selectedPallet = BlackWhitePallet
    self.currentPallet = 1
    self.fontFile = "/fonts/Pixeled.ttf"
    self.font = love.graphics.newFont(self.fontFile, self.fontsize)
    self:setWindowSize({width = 1280, height =720})
    self:setScale(16,9)
end

function Settings:setWindowSize(windowsize)
    self.windowSize = {}
    self.windowSize.width = windowsize.width
    self.windowSize.height = windowsize.height
    love.window.setMode(windowsize.width,windowsize.height)
    self:reScale()
end

function Settings:setScale(x,y)
    self.spritesx = x
    self.spritesy = y
    self:reScale()
end

function Settings:reScale()
    self.pixelwidth = self.windowSize.width/(self.spritesx*self.spritelenght)
    if self.pixelwidth < self.minpixelwidth then
        self.pixelwidth = self.minpixelwidth
    end
    self.pixelheight = self.windowSize.height/(self.spritesy*self.spritelenght)
    if self.pixelheight < self.minpixelheight then
        self.pixelheight = self.minpixelheight
    end
    self.fontsize = 15 + ((self.pixelwidth/self.spritesx)+ (self.pixelheight/self.spritesy)*18)
    self.font = nil
    self:setFont()
end

function Settings:set(settings)
    self.spritelenght = settings.spritelenght
    self.currentPallet = settings.currentPallet
    self.selectedPallet = Pallets[self.currentPallet]
    self.fontFile = settings.fontFile
    self.font = settings.font
    self:setWindowSize(settings.windowSize)
end

function Settings:getHorizontalSprites()
    return (self.windowSize.width/ (self.pixelwidth*Settings.spritelenght)) +1
end

function Settings:getVerticalSprites()
    return (self.windowSize.height/ (self.pixelheight*Settings.spritelenght)) +1
end

function Settings:setFont()
    if self.font == nil then
        self:changeFont(love.graphics.newFont(Settings.fontFile,self.fontsize))
    end
    self.font:setLineHeight(0.15 + self.fontsize/(self.pixelheight*self.spritelenght))
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

function Settings:getSpriteWidth()
    return self.pixelwidth*self.spritelenght
end

function Settings:getSpriteHeight()
    return self.pixelheight*self.spritelenght
end