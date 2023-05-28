--requires

--intro.lua
OnePlayerGame = {
    objects = {
    },
    nextScene = 2,
    switch = false
}

function OnePlayerGame:update(dt)
    
end

function OnePlayerGame:draw()
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
end