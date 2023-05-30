--requires
require("objects.genericObj")
--snakeTailEnd.lua
SnakeTailEnd = {
    path = "sprites/snakeTailEnd.txt"
}

function SnakeTailEnd.new(x,y,pallet)
    local newObj = GenericObj.new(x,y,pallet)
    newObj:setPath(SnakeTailEnd.path)
    return newObj
end


