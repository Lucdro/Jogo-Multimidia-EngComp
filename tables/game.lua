--Requires
require("tables.data")
require("scenes.intro")
require("tables.scenes")
--game.lua
Game = {
    scenes = Scenes,
    data = Data,
    currentScene = 0
}

function Game:recoverData()
    local path = "data.txt"
    if FileExists(path) then
        self.data:loadFromFile(path)
    else
        self.data.settings:defaultSettings()
        self.data:saveOnFile(path)
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
    --if not self.loaded then return end
    if self:sceneExists(self.currentScene) then
        self.scenes[self.currentScene]:update(dt)
        if self.scenes[self.currentScene].switch then
            self:setScene(self.scenes[self.currentScene].nextScene)
        end
    else
        self:printError("No scene selected! -- Update")
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
