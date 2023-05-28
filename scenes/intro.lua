--requires
require("objects.snakehead")
require("objects.snakeTail")
require("objects.snakeTailEnd")
require("objects.apple")
require("objects.wall")
require("objects.ground")
require("pallets.defaultPallet")
require("pallets.redPallet")
--intro.lua
Intro = {
    objects = {
        Wall.new(0,0,DefaultPallet),
        SnakeTail.new(100,0,DefaultPallet),
        Apple.new(0,100,DefaultPallet),
        SnakeTailEnd.new(100,100,DefaultPallet),
        Ground.new(200,0,DefaultPallet),
        SnakeHead.new(200,100,DefaultPallet),
    },
    time = 5,
    nextScene = 2,
    switch = false
}

function Intro:update(dt)
    --self.objects[1]:setDirection("down")
    self.objects[6]:setPallet(RedPallet)
    
    if self.time <= 0 then self.switch = true
    else self.time = self.time - 1 * dt end
end

function Intro:draw()
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
end