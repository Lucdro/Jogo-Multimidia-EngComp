--requires
require("objects.snakehead")
require("objects.snakeTailDiagonal")
require("scenes.genericScene")
require("objects.wall")
--credits.lua
Credits = {

}
setmetatable(Credits,MetaGenericScene)
local theme = {}
function Credits:load()
    self.switch = false
    Settings:setScale(16,9)
    self.backGroundSprite = Wall
    self:createBackground()
    theme = love.audio.newSource("sounds/04 Stage Clear.mp3","static")
    if not theme:isPlaying() then love.audio.play(theme) end
end

function Credits:update(dt)
    self:checkPallet()
    self:checkFocus()
    if love.keyboard.keysPressed['escape'] == true then 
        self.newScene = 2
        self.switch = true
    end
end

function Credits:draw()
    love.graphics.setColor(self.pallet[1].red, self.pallet[1].green, self.pallet[1].blue, self.pallet[1].alpha)
    local text ="Desenvolvedor\n\n" 
    .."Lucas Alvarenga Teixeira - RA:210251\n"
    .."\n\n\nAgradecimentos especiais\n\n"
    .."Prof. Tarcísio\n"
    .."As diversas pessoas que eu roubei musica\n"
    .."Craig Mason-Jones, Egor Skriptunoff\nCriadores da funcao to json que eu peguei 'emprestado'"
    love.graphics.print(text,100,30,0,0.8,0.8)
end
