--requires
require("objects.genericObj")
--snakeTailDiagonal.lua
SnakeTailDiagonal = {
    path = "sprites/snakeTailDiagonal.txt"
}

function SnakeTailDiagonal.new(x,y,pallet)
    local newObj = GenericObj.new(x,y,pallet)
    newObj:setPath(SnakeTailDiagonal.path)
    return newObj
end


