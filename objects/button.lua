--requires
require("objects.genericObj")
require("tables.settings")

--snakehead.lua
Button = {
    path = "sprites/button.txt",
    pathOnFocus = "sprites/buttonOnFocus.txt",
    x = 0,
    y = 0,
    text = "",
    left = {},
    right = {},
    pallet = {},
    direction = "",
    textx = 8,
    texty = 3,
}
MetaButton = {
    __index = Button
}

function Button.new(text,x,y,pallet)
    pallet = pallet or Settings.selectedPallet
    local newButton = setmetatable({},MetaButton)
    newButton:setText(text)
    newButton:setTextPosition(5,0)
    newButton:setPosition(x,y)
    newButton.left = GenericObj.new(x,y,pallet)
    newButton.left:setPath(Button.path)
    newButton.left:setDirection("right")
    newButton.right = GenericObj.new(x+Settings.pixelwidth*Settings.spritelenght,y,pallet)
    newButton.right:setPath(Button.path)
    newButton.right:setDirection("left")
    newButton.right:invertVertical()
    newButton:setPallet(pallet)
    
    return newButton
end

function Button:draw()
    self.left:draw()
    self.right:draw()
    love.graphics.setColor(self.pallet[4].red, self.pallet[4].green, self.pallet[4].blue, self.pallet[4].alpha)
    love.graphics.print(self.text,self.x + self.textx ,self.y + self.texty,0,
    Settings.pixelwidth/10,Settings.pixelwidth/10)
end

function Button:setTextPosition(x,y)
    self.textx = Settings.pixelwidth * x
    self.texty = Settings.pixelheight * y
end

function Button:setPosition(x,y)
    self.x = x
    self.y = y
end

function Button:setPallet(pallet)
    self.pallet = pallet
    self.left:setPallet(pallet)
    self.right:setPallet(pallet)
end

function Button:setText(text)
    self.text = text
end

function Button:setDirection(direction)
    self.direction = direction
end

function Button:checkInside(x,y)
    if x == nil or y == nil then return end
    return x >= self.x and x <= self.x+Settings.pixelwidth*Settings.spritelenght*2 
    and y >= self.y and y <= self.y+Settings.pixelheight*Settings.spritelenght
end

function Button:setFocus(focus)
    if not focus and self.left.path ~= self.path then
        self.left:setPath(self.path)
        self.right:setPath(self.path)
        self.right:invertVertical()
    elseif focus and self.left.path ~= self.pathOnFocus then
        self.left:setPath(self.pathOnFocus)
        self.right:setPath(self.pathOnFocus)
        self.right:invertVertical()
    end
end