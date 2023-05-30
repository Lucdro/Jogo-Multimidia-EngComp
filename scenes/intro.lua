--requires
require("objects.snakehead")
require("objects.snakeTail")
require("objects.snakeTailEnd")
require("objects.apple")
require("scenes.genericScene")
require("objects.wall")
--intro.lua
Intro = {
    headposition = 0,
    time = 0,
    snaketaillenght = 2,
    movetime = 0.4,
    skip = false,
}
setmetatable(Intro,MetaGenericScene)

local objSnakeHead = {}
local objApple = {}
local objSnaketailEnd = {}
local objSnaketail = {}
function Intro:load()
    self.switch = false
    self.time = 0
    Settings:setScale(12,7)
    self.backGroundSprite = Wall
    self:createBackground()
    self:createObjects()
end

function Intro:update(dt)
    self:checkPallet()
    self:checkFocus()
    
    if self.time >= self.movetime then
        self.headposition = self.headposition + Settings:getSpriteWidth()
        self:moveSnake()
        self.time = 0
    else
        self.time = self.time + dt
    end
     
    if love.keyboard.keysPressed["space"] == true or objSnaketailEnd.x > Settings.windowSize.width then
        self.nextScene = 2
        self.switch = true
    end
end

function Intro:createObjects()
    self.objects = {}
    objApple = Apple.new(Settings:halfScreenHorizontal(1),Settings:halfScreenVertical(1))
    table.insert(self.objects,objApple)
    
    self.headposition = objApple.x - (((-1 + Settings:getHorizontalSprites())/2)*Settings:getSpriteWidth())
    objSnakeHead = SnakeHead.new(self.headposition,objApple.y)
    objSnakeHead:setDirection("right")
    table.insert(self.objects,objSnakeHead)

    objSnaketail = {}
    for i = 1, self.snaketaillenght do
        objSnaketail[i] = SnakeTail.new(self.headposition - Settings:getSpriteWidth() * i,objApple.y)
        objSnaketail[i]:setDirection("right")
        table.insert(self.objects,objSnaketail[i])
    end

    local snaketailendx = self.headposition - #objSnaketail * Settings:getSpriteWidth()
    objSnaketailEnd = SnakeTailEnd.new(snaketailendx,objApple.y)
    objSnaketailEnd:setDirection("right")
    table.insert(self.objects,objSnaketailEnd)

end

function Intro:moveSnake()
    objSnakeHead:move(self.headposition,objSnakeHead.y)

    if self.skip then self.skip = false goto addtail end
    if objApple.x == self.headposition then
        self.skip = true
        objApple:move(-Settings:getSpriteWidth(),0)
    end

    for i = 1, #objSnaketail do
        objSnaketail[i]:move(self.headposition - Settings:getSpriteWidth() * i,objSnakeHead.y)
    end

    objSnaketailEnd:move(self.headposition - ((1 + #objSnaketail) * Settings:getSpriteWidth()),objSnakeHead.y)

    goto continue

    ::addtail::
    objSnaketail[#objSnaketail+1] = SnakeTail.new(self.headposition - Settings:getSpriteWidth(),objSnakeHead.y)
    objSnaketail[#objSnaketail]:setDirection("right")
    table.insert(self.objects,objSnaketail[#objSnaketail])

    ::continue::
end

function Intro:draw()
    love.graphics.print(Settings.title,Settings.windowSize.width/3.2,50,0,Settings.pixelwidth/4,Settings.pixelwidth/4)
    love.graphics.print("Space to skip",40,40,0,Settings.pixelwidth/10,Settings.pixelwidth/10)
end