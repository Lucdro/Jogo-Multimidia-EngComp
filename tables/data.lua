--requires
local json = require('notMyCode.json')
require("tables.settings")
--data.lua
Data = {
    record = {},
    settings = Settings
}

function Data:setSettings(settings)
    Settings:set(settings)
end

function Data:getSettings()
    return self.settings
end

function Data:saveOnFile()
    local jsonStr = json.encode(self)
    io.output(Settings.savefile)
    io.write(jsonStr)
    io.close()
end

function Data:loadFromFile()
    io.input(Settings.savefile)
    local savedData = io.read()
    local data = json.decode(savedData)
    self.record = data.record
    self:setSettings(data.settings)
    io.close()
end