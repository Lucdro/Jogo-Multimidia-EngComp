--requires
local json = require('notMyCode.json')
require("tables.settings")
--data.lua
Data = {
    record = {},
    settings = Settings
}

function Data:setSettings(settings)
    self.settings = settings
end

function Data:getSettings()
    return self.settings
end

function Data:saveOnFile(path)
    local jsonStr = json.encode(self)
    io.output(path)
    io.write(jsonStr)
    io.close()
end

function Data:loadFromFile(path)
    io.input(path)
    local savedData = io.read()
    local data = json.decode(savedData)
    self.record = data.record
    self.settings = data.settings
    io.close()
end