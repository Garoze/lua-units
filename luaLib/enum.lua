local luaLib = {}

function luaLib.enum(elemTable)
    local enum = {}
    for i = 1, #elemTable do 
        enum[elemTable[i]] = i
    end
    return enum
end

