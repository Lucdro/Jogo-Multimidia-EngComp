--requires
require("objects.genericObj")
require("tables.settings")

--snakehead.lua
Button = {
    path = "sprites/button.txt",
    x = 0,
    y = 0,
    text = "",
    left = {},
    right = {},
    pallet = {},
    direction = "",
    textx = 0,
    texty = 0,
}
MetaButton = {
    __index = Button
}

function Button.new(x,y,pallet,text)
    local newButton = setmetatable({},MetaButton)
    newButton:setText(text)
    newButton:setPosition(x,y)
    newButton.left = GenericObj.new(x,y,pallet)
    newButton.left:setPath(Button.path)
    newButton.left:setDirection("right")
    newButton.right = GenericObj.new(x+Settings.pixelwidth*Settings.spritelenght,y,pallet)
    newButton.right:setPath(Button.path)
    newButton.right:setDirection("left")
    newButton:setPallet(pallet)
    return newButton
end

function Button:draw()
    self.left:draw()
    self.right:draw()
    
    love.graphics.setColor(self.pallet[4].red, self.pallet[4].green, self.pallet[4].blue, self.pallet[4].alpha)
    love.graphics.setNewFont(15)
    love.graphics.print(self.text,self.textx,self.texty)
end

function Button:setTextPosition(x,y)
    self.textx = x
    self.texty = y
end

function Button:setPosition(x,y)
    self.x = x
    self.y = y
    self:setTextPosition(x*1.5,y*1.5)
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

function Button:onClick()
    
end