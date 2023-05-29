--Requires
require("tables.data")
require("tables.scenes")
require("tables.pallets")
--game.lua
Game = {
    scenes = Scenes,
    data = Data,
    currentScene = 0,
    pallets = Pallets,
}

function Game:recoverData()
    if FileExists(Settings.savefile) then
        self.data:loadFromFile()
    else
        self.data.settings:defaultSettings()
        self.data:saveOnFile()
    end
end

function Game:sceneExists(n)
    if self.scenes == nil then error("No scenes!") end
    if self.scenes[n] ~= nil then
        return true
    else return false end
end

function Game:setScene(n)
    if self:sceneExists(n) then
        self.currentScene = n
        self.scenes[self.currentScene]:setPallet(Settings.selectedPallet)
        self.scenes[self.currentScene]:load()
    end
end

function Game:update(dt)
    if self:sceneExists(self.currentScene) then
        self.scenes[self.currentScene]:update(dt)
        if self.scenes[self.currentScene].switch then
            self:setScene(self.scenes[self.currentScene].nextScene)
        end
    else
        self:printError("No scene selected! -- Update")
    end

    if love.keyboard.wasPressed("1") then
        self:previousPallet()
    elseif love.keyboard.wasPressed("2") then
        self:nextPallet()
    end
end
function Game:draw()
    if self.scenes[self.currentScene] ~= nil then
        self.scenes[self.currentScene]:draw()
    else
        self:printError("No scene selected! -- Draw ")
    end
end
function Game:printError(e)
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.setColor(1,1,1)
    love.graphics.print(e)
end

function Game:setPallet(pallet)
    Settings.selectedPallet = pallet
end

function Game:previousPallet()
    if Settings.currentPallet == 1 then
        Settings.currentPallet = #self.pallets
    else
        Settings.currentPallet = Settings.currentPallet - 1
    end
    self:setPallet(self.pallets[Settings.currentPallet])
end

function Game:nextPallet()
    if Settings.currentPallet == #self.pallets then
        Settings.currentPallet = 1
    else
        Settings.currentPallet = Settings.currentPallet + 1
    end
    self:setPallet(self.pallets[Settings.currentPallet])
end

