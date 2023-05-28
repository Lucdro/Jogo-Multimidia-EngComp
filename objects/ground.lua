--requires
require("objects.genericObj")
--snakehead.lua
Ground = {
    path = "sprites/Ground.txt"
}

function Ground.new(x,y,pallet)
    local newObj = GenericObj.new(x,y,pallet)
    newObj:setPath(Ground.path)
    return newObj
end

