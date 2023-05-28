--requires

--intro.lua
TwoPlayerGame = {
    objects = {
    },
    nextScene = 2,
    switch = false
}

function TwoPlayerGame:update(dt)
    
end

function TwoPlayerGame:draw()
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
end