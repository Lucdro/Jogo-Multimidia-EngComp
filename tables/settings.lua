Settings = {
    windowSize ={
        width = {},
        height = {}
    },
    pixelwidth = 1,
    pixelheight = 1,
}

function Settings:defaultSettings()
    self.windowSize.width = 1280
    self.windowSize.height = 720
    self.pixelheight = 5
    self.pixelwidth = 5
end