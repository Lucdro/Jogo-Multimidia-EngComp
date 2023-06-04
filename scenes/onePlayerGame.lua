--requires
require("objects.snakeGame")
require("scenes.genericScene")
require("tables.gamebgmusics")
--onePlayerGame.lua
OnePlayerGame = {
    musicpaused = false
}
local theme = {}
setmetatable(OnePlayerGame,MetaGenericScene)
local game = {}
function OnePlayerGame:load()
    self.switch = false
    Settings:setScale(32,18)
    self.backGroundSprite = Wall
    self:createBackground()
    --matrix 16 -> scene 32 -> 8 left on the sides
    local gamex = Settings.pixelwidth * Settings.spritelenght * 8
    --matrix 9 -> scene 18 -> 4.5 on top and bottom -> needs more on top
    local gamey = Settings.pixelheight * Settings.spritelenght * 6
    game = SnakeGame.new(gamex,gamey,16,9)
    table.insert(self.objects,game)
    self:newBgMusic()
end

function OnePlayerGame:newBgMusic()
    love.audio.stop()
    theme = BGMusics[math.random(1,#BGMusics)]
    love.audio.play(theme)
end

function OnePlayerGame:update(dt)
    self:checkPallet()
    self:checkFocus()
    self:radio()
    if love.keyboard.keysPressed['escape'] == true then
        if not game.sounds.exit:isPlaying( ) then
            love.audio.play(game.sounds.exit)
        end
        self.newScene = 2
        self.switch = true
    end
    if love.keyboard.keysPressed['n'] == true then self:newBgMusic() end
    if love.keyboard.keysPressed['right'] == true or love.keyboard.keysPressed['d'] == true then game.lastInput = "right"
    elseif love.keyboard.keysPressed['down'] == true or love.keyboard.keysPressed['s'] == true then game.lastInput = "down"
    elseif love.keyboard.keysPressed['left'] == true or love.keyboard.keysPressed['a'] == true then game.lastInput = "left"
    elseif love.keyboard.keysPressed['up'] == true or love.keyboard.keysPressed['w'] == true then game.lastInput = "up" end
    game:update(dt)
end

function OnePlayerGame:draw()
    love.graphics.print("1 and 2 - change color pallet\nr - retry\np or space - "..(game.pause and "unpause" or "pause")..
    "\nEsc - return to menu\nN - New music",10,10)
    if game.lose then
        love.graphics.print("R to retry!",Settings.windowSize.width/3,Settings.windowSize.height/16) end
    if game.win then
        love.graphics.print("Congratulations for winning!\n R to try again!",Settings.windowSize.width/4,
        Settings.windowSize.height/24) end
end

function OnePlayerGame:radio()
    if not theme:isPlaying() then
        if not self.musicpaused then
            self:newBgMusic()
        elseif not game.pause then love.audio.play(theme) end
    else
        if game.pause then
            theme:pause()
            self.musicpaused = true
        end
    end
end