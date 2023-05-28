--requires
require("objects.genericObj")
--snakehead.lua
Wall = {
    path = "sprites/wall.txt"
}

function Wall.new(x,y,pallet)
    local newObj = GenericObj.new(x,y,pallet)
    newObj:setPath(Wall.path)
    return newObj
end


