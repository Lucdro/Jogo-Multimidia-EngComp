FileToSprite = {
    errorSpritePath = "/sprites/error.txt"
}

function FileExists(path)
    local f=io.open(path,"r")
    if f~=nil then io.close(f) return true else return false end
end

function FileToSprite:Read(path)
    if not FileExists(path) then
        if  path ~= self.errorSpritePath then
            return self:Read(self.errorSpritePath)
        else
            error("Tentou devolver vazio\nCaminho:"..path)
            return {} end end

    local pixels = {}
    local i = 1
    for line in io.lines(path) do
        pixels[#pixels + 1] = {}
        for j = 1 , #line do
            pixels[i][j] = tonumber(line:sub(j,j))
        end
        i = i + 1
    end
    --return pixels
    pixels = self:reajustOrientation(pixels)
    return pixels
end

function FileToSprite:reajustOrientation(pixels)
    local newPixels = {}
    if pixels[1] == nil then return pixels end
    for i = 1 , #pixels[1] do
        newPixels[i] = {}
        for j = 1 , #pixels do
            newPixels[i][j] = pixels[j][i]
        end
    end
    return newPixels
end