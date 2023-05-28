Settings = {
    windowSize ={
        width = {},
        height = {}
    },
    pixelwidth = 5,
    pixelheight = 5,
    spritelenght = 16,
}

function Settings:defaultSettings()
    Settings.setWindowSize({width = 1280, height =720})
    self.pixelheight = 5
    self.pixelwidth = 5
end

function Settings.setWindowSize(windowsize)
    Settings.windowSize.width = windowsize.width
    Settings.windowSize.height = windowsize.height
    love.window.setMode(windowsize.width,windowsize.height)
end