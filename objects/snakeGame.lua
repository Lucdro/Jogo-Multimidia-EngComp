--requires 
require("objects.snakehead")
require("objects.snakeTail")
require("objects.snakeTailEnd")
require("objects.snakeTailDiagonal")
require("objects.apple")
require("objects.wall")
require("objects.ground")
require("objects.genericObj")
--snakeGame.lua
SnakeGame = {
    pause = true,
    matrix = {},
    headposition = {x = 0, y = 0},
    lx = 16,
    ly = 9,
    apple = false,
    sLenght = 0,
    lastInput = "right",
    objs = {
        head = {},
        tail = {},
        taild = {},
        taile = {},
        apple = {},
        ground = {},
    },
    appletime = 3,
    appletimer = 0,
    movetime = 0.7,
    movetimer = 0,
}
setmetatable(SnakeGame,MetaGenericObj)
MetaSnakeGame = {
    __index = SnakeGame
}

function SnakeGame.new(x,y,lx,ly,pallet)
    local newGame = setmetatable({},MetaSnakeGame)
    newGame:init(x,y,lx,ly,pallet)
    return newGame
end

function SnakeGame:init(x,y,lx,ly,pallet)
    self.pallet = pallet
    self.objs.head = SnakeHead.new(0,0,pallet)
    self.objs.tail = SnakeTail.new(0,0,pallet)
    self.objs.taild = SnakeTailDiagonal.new(0,0,pallet)
    self.objs.taile = SnakeTailEnd.new(0,0,pallet)
    self.objs.taile:invertHorizontal()
    self.objs.apple = Apple.new(0,0,pallet)
    self.objs.ground = Ground.new(0,0,pallet)

    self.x = x
    self.y = y
    self.lx = lx
    self.ly = ly
    self:reset()
end

function SnakeGame:reset()
    self.pause = true
    self:createMatrix()
    self:createSnake()
end

function SnakeGame:createMatrix()
    for i = 1, self.lx do
        self.matrix[i] = {}
        for j = 1, self.ly do
            self.matrix[i][j] = 0
        end
    end
end

function SnakeGame:createSnake()
    --tries to position on center -- could break if game is too small
    self.headposition.x = math.floor(self.lx/2)
    self.headposition.y = math.floor(self.ly/2)
    -- point head left
    self.matrix[self.headposition.x][self.headposition.y] = 2
    -- place tail on the left pointing towards left
    self.matrix[self.headposition.x-1][self.headposition.y] = 2
end

function SnakeGame:draw()
    self:drawMatrix()
    if self.pause then love.graphics.print("Pausado",Settings.windowSize.width/4,Settings.windowSize.height/16,0,5,5) end
end

function SnakeGame:drawMatrix()
    local obj = {}
    local snake = self:getSnake()
    local taile = snake[#snake]
    for i = 1, self.lx do
        for j = 1, self.ly do
            local cellVal = self.matrix[i][j]
            if cellVal == 0 then
                obj = nil
            elseif cellVal == 1 then
                obj = self.objs.apple
            else
                local direction = ""
                --If is the head
                if i == self.headposition.x and j == self.headposition.y then
                    obj = self.objs.head
                    direction = self:getDirection(self.matrix[i][j])
                    obj:setDirection(self:invertDirection(direction))
                --If is the tail end
                elseif i == taile.x and j == taile.y then
                    obj = self.objs.taile
                    local previousPart = snake[#snake-1]
                    direction = self:getDirection(previousPart.value)
                    obj:setDirection(direction)
                --Just another tailpart
                else
                    local index = self:findIndexSnakePart(snake,i,j)
                    local nextPart = snake[index+1]
                    local previousPart = snake[index-1]
                    local part = snake[index]
                    --horizontal movement
                    if nextPart.y == previousPart.y and nextPart.x ~= previousPart.x then
                        obj = self.objs.tail
                        obj:setDirection("left")
                    --vertical movement
                    elseif nextPart.x == previousPart.x and nextPart.y ~= previousPart.y then
                        obj = self.objs.tail
                        obj:setDirection("up")
                    --diagonal moviment    
                    else
                        obj = self.objs.taild
                        --up -> original

                        --dp
                        --n0
                        if previousPart.x > part.x and nextPart.y > part.y then obj:setDirection("up")
                        --0p
                        --nd
                        elseif previousPart.y < part.y and nextPart.x < part.x then obj:setDirection("down")
                        --nd
                        --0p
                        elseif previousPart.y > part.y and nextPart.x < part.x then obj:setDirection("right")
                        --n0
                        --dp
                        elseif previousPart.x > part.x and nextPart.y < part.y then obj:setDirection("left")
                        --0n
                        --pd
                        elseif previousPart.x < part.x and nextPart.y < part.y then obj:setDirection("down")
                        --dn
                        --p0
                        elseif previousPart.y > part.y and nextPart.x > part.x then obj:setDirection("up")
                        --p0
                        --dn
                        elseif previousPart.y < part.y and nextPart.x > part.x then obj:setDirection("left")
                        --pd
                        --0n
                        elseif previousPart.x < part.x and nextPart.y > part.y then obj:setDirection("right")
                        end
                    end
                end
            end
            local x = self.x + (i-1)*Settings:getSpriteWidth()
            local y = self.y + (j-1)*Settings:getSpriteHeight()
            --draw ground bellow
            self.objs.ground.x = x
            self.objs.ground.y = y
            self.objs.ground:draw()
            --draw selectedobj
            if obj ~= nil then
                obj.x = x
                obj.y = y
                obj:draw()
            end
        end
    end
end

function SnakeGame:findIndexSnakePart(snake,x,y)
    snake = snake or self:getSnake()
    for i = 1, #snake do
       if snake[i].x == x and snake[i].y == y then
        return i end
    end
end

function SnakeGame:getDirection(cellVal)
    if cellVal == 2 then return "left"
    elseif cellVal == 3 then return "right"
    elseif cellVal == 4 then return "up"
    elseif cellVal == 5 then return "down"
    end
end

function SnakeGame:getNumbDirection(direction)
    if direction == "left" then return 2
    elseif direction == "right" then return 3
    elseif direction == "up" then return 4
    elseif direction == "down" then return 5
    end
end

function SnakeGame:getSnake()
    local tail = false
    local cell = {x = self.headposition.x, y = self.headposition.y}
    local lastCell = {}
    local snake = {}
    while not(tail) do
        --if a last cell exists add it
        if lastCell ~= nil and lastCell.x ~= nil then
            snake[#snake+1] = {value = self.matrix[lastCell.x][lastCell.y], x = lastCell.x, y = lastCell.y}
        end
        lastCell = {x = cell.x, y = cell.y}
        local value = self.matrix[cell.x][cell.y]
        if value == 2 then cell.x = cell.x - 1
        elseif value == 3 then cell.x = cell.x + 1
        elseif value == 4 then cell.y = cell.y - 1
        elseif value == 5 then cell.y = cell.y + 1
        else tail = true
        end
        --if not(tail) then snake[#snake+1] = {value = value, x = cell.x, y = cell.y} end
        --if not(tail) then snake[cell.x..","..cell.y] = value end
    end
    self.sLenght = #snake
    return snake
end

function SnakeGame:setPallet(pallet)
    self.objs.head:setPallet(pallet)
    self.objs.tail:setPallet(pallet)
    self.objs.taild:setPallet(pallet)
    self.objs.taile:setPallet(pallet)
    self.objs.apple:setPallet(pallet)
    self.objs.ground:setPallet(pallet)
end

function SnakeGame:update(dt)
    --Pause
    if self.pause then return end
    --MoveSnake
    if self.movetimer < 0 then
        self.movetimer = self.movetime
        self:moveSnake()
    else
        self.movetimer = self.movetimer - dt
    end
    --SpawnApple
    if not(self.apple) then
        if self.appletimer < 0 then
            self.appletimer = self.appletime
            self:spawnApple()
        else
            self.appletimer = self.appletimer - dt
        end
    end
end

function SnakeGame:spawnApple()
    while not(self.apple) do
        local x = math.random(1,#self.matrix)
        local y = math.random(1,#self.matrix[x])
        if self.matrix[x][y] == 0 then
            self.matrix[x][y] = 1
            self.apple = true
        end
    end
end

function SnakeGame:moveSnake()
    local nextPosition = {
        x = self.headposition.x,
        y = self.headposition.y
    }
    if self.lastInput == "left" then nextPosition.x = nextPosition.x - 1
    elseif self.lastInput == "right" then nextPosition.x = nextPosition.x + 1
    elseif self.lastInput == "up" then nextPosition.y = nextPosition.y - 1
    elseif self.lastInput == "down" then nextPosition.y = nextPosition.y + 1
    end
    if self:canMove(nextPosition) then
        --If not a apple remove tail
        if self.matrix[nextPosition.x][nextPosition.y] ~= 1 then self:removeTail()
        else self.apple = false end
        local direction = self:invertDirection(self.lastInput)
        
        self.matrix[nextPosition.x][nextPosition.y] = self:getNumbDirection(direction)
        self.headposition.x = nextPosition.x
        self.headposition.y = nextPosition.y
    else
        self.pause = true
    end
end

function SnakeGame:canMove(position)
    return position.x > 0 and position.x <= #self.matrix and
    position.y > 0 and position.y <= #self.matrix[position.x] and
    (self.matrix[position.x][position.y] == 0 or self.matrix[position.x][position.y] == 1) 
end

function SnakeGame:invertDirection(direction)
    if direction== "left" then direction = "right"
    elseif direction == "right" then direction = "left"
    elseif direction == "up" then direction = "down"
    elseif direction == "down" then direction = "up"
    end
    return direction
end

function SnakeGame:removeTail()
    local snake = self:getSnake()
    local tail = snake[#snake]
    self.matrix[tail.x][tail.y] = 0
end