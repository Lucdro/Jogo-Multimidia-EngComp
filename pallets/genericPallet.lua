GenericPallet = {}
MetaGenericPallet = {
    __index = GenericPallet
}
function GenericPallet.new(pallet)
    local newObj = setmetatable({},MetaGenericPallet)
    newObj:init(pallet)
    return newObj
end

function GenericPallet:init(pallet)
    if pallet == nil then return end
    for i = 1, 4 do 
        self[i] = {}
        self[i].red = pallet[i][1]/255
        self[i].green = pallet[i][2]/255
        self[i].blue = pallet[i][3]/255
        self[i].alpha = pallet[i][4]/255
    end
end
