--requires

--intro.lua
MenuSettings = {
    objects = {
    },
    nextScene = 2,
    switch = false
}

function MenuSettings:update(dt)
    
end

function MenuSettings:draw()
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
end