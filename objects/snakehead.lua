--requires
require("objects.genericObj")
--snakehead.lua
SnakeHead = {
    path = "sprites/snakehead.txt"
}

function SnakeHead.new(x,y,pallet)
    local newObj = GenericObj.new(x,y,pallet)
    newObj:setPath(SnakeHead.path)
    return newObj
end


