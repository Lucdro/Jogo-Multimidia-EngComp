--requires
require("objects.genericObj")
--snakehead.lua
SnakeTail = {
    path = "sprites/snakeTail.txt"
}

function SnakeTail.new(x,y,pallet)
    local newObj = GenericObj.new(x,y,pallet)
    newObj:setPath(SnakeTail.path)
    return newObj
end


