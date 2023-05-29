--requires
require("objects.fileToSprite")
require("tables.settings")
--genericSprite.lua
GenericSprite = {
    spritePath = "",
    pixels = {},
    loaded = false
}
MetaGenericSprite = {
    __index = GenericSprite
}
function GenericSprite.new(path)
    local newObj = setmetatable({},MetaGenericSprite)
    newObj:init(path)
    return newObj
end

function GenericSprite:init(path)
    self.spritePath = path
    self.pixels = FileToSprite:Read(self.spritePath)
    self.loaded = true
end

function GenericSprite:draw(rx,ry,pallet,direction)
    local pw = Game.data.settings.pixelwidth
    local ph = Game.data.settings.pixelwidth
    if direction == "left" then
        for i = 1, #self.pixels do
            for j = 1, #self.pixels[i] do
                local pixelvalue = self.pixels[#self.pixels - (j -1)][i] or 0
                if pixelvalue == 4 then goto next end

                local rgba = pallet[pixelvalue + 1]
                love.graphics.setColor(rgba.red, rgba.green, rgba.blue, rgba.alpha)
                love.graphics.rectangle("fill",rx+(i-1)*pw,ry+(j-1)*ph,pw,ph)
                ::next::
            end
        end
    elseif direction == "up" then
        for i = 1, #self.pixels do
            for j = 1, #self.pixels[i] do
                local pixelvalue = self.pixels[i][j] or 0
                if pixelvalue == 4 then goto next end

                local rgba = pallet[pixelvalue + 1]
                love.graphics.setColor(rgba.red, rgba.green, rgba.blue, rgba.alpha)
                love.graphics.rectangle("fill",rx+(i-1)*pw,ry+(j-1)*ph,pw,ph)
                ::next::
            end
        end
    elseif direction == "right" then
        for i = 1, #self.pixels do
            for j = 1, #self.pixels[i] do
                local pixelvalue = self.pixels[j][#self.pixels - (i -1)] or 0
                if pixelvalue == 4 then goto next end

                local rgba = pallet[pixelvalue + 1]
                love.graphics.setColor(rgba.red, rgba.green, rgba.blue, rgba.alpha)
                love.graphics.rectangle("fill",rx+(i-1)*pw,ry+(j-1)*ph,pw,ph)
                ::next::
            end
        end
    elseif direction == "down" then
        for i = 1, #self.pixels do
            for j = 1, #self.pixels[i] do
                local pixelvalue = self.pixels[#self.pixels - (i -1)][#self.pixels - (j -1)] or 0
                if pixelvalue == 4 then goto next end

                local rgba = pallet[pixelvalue + 1]
                love.graphics.setColor(rgba.red, rgba.green, rgba.blue, rgba.alpha)
                love.graphics.rectangle("fill",rx+(i-1)*pw,ry+(j-1)*ph,pw,ph)
                ::next::
            end
        end
    end
end