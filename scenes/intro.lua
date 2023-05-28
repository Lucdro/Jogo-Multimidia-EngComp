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
    }
}

function Intro:update(dt)
    --self.objects[1]:setDirection("down")
    self.objects[6]:setPallet(RedPallet)
end

function Intro:draw()
    for i = 1, #self.objects do
        self.objects[i]:draw()
    end
end