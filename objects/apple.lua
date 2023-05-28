--requires
require("objects.genericObj")
--snakehead.lua
Apple = {
    path = "sprites/apple.txt"
}

function Apple.new(x,y,pallet)
    local newObj = GenericObj.new(x,y,pallet)
    newObj:setPath(Apple.path)
    return newObj
end


