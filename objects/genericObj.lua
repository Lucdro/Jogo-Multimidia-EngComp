--requires
require("objects.genericSprite")
require("notMyCode.copytable")
--genericObj.lua
GenericObj = {
    sprite = {},
    x = 0,
    y = 0,
    pallet = {},
    path = "",
    direction = "up",
    onFocus = false,
}
MetaGenericObj = {
    __index = GenericObj
}

function GenericObj.new(x,y,pallet)
    local newObj = setmetatable({}, MetaGenericObj)
    newObj:init(x,y,pallet)
    return newObj
end

function GenericObj:init(x,y,pallet)
    self.x = x
    self.y = y
    self.pallet = pallet
end

function GenericObj:setSprite()
    self.sprite = GenericSprite.new(self.path)
end

function GenericObj:draw()
    self.sprite:draw(self.x,self.y,self.pallet,self.direction)
end

function GenericObj:setPallet(pallet)
    self.pallet = pallet
end

function GenericObj:setPath(path)
    self.path = path
    self:setSprite()
end

function GenericObj:setDirection(direction)
    self.direction = direction
end

function GenericObj:move(x,y)
    --local ox,oy = self.x, self.y
    --local direction = GenericObj.GetDirection(ox,oy,x,y,self.direction)
    --self:setDirection(direction)
    self.x = x
    self.y = y
end

function GenericObj.GetDirection(ox,oy,x,y,olddirection)
   if ox > x then return "left"
   elseif ox < x then return "right"
   elseif oy > y then return "down"
   elseif oy < y then return "up"
   else return olddirection
   end
end

function GenericObj:checkInside(x,y)
    if x == nil or y == nil then return end
    return x >= self.x and x <= self.x+Settings.pixelwidth*Settings.spritelenght 
    and y >= self.y and y <= self.y+Settings.pixelheight*Settings.spritelenght
end