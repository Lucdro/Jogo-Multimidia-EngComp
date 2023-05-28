--requires
require("objects.button")
require("objects.apple")
require("pallets.defaultPallet")
require("pallets.redPallet")
--intro.lua
Menu = {
    objects = {
        Button.new(20,20,RedPallet,"Hello world!")
    },
    nextScene = 2,
    switch = false
}

function Menu:update(dt)
    
end

function Menu:draw()
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
end