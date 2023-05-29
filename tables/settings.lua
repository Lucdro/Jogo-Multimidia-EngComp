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
    selectedPallet = {}
}

function Settings:defaultSettings()
    Settings.setWindowSize({width = 1280, height =720})
    self.pixelheight = 5
    self.pixelwidth = 5
    self.selectedPallet = DefaultPallet
end

function Settings:setWindowSize(windowsize)
    Settings.windowSize.width = windowsize.width
    Settings.windowSize.height = windowsize.height
    love.window.setMode(windowsize.width,windowsize.height)
end

function Settings:set(settings)
    self:setWindowSize(settings.windowSize)
    self.pixelwidth = settings.pixelwidth
    self.pixelheight = settings.pixelheight
    self.spritelenght = settings.spritelenght
    self.selectedPallet = settings.selectedPallet
end