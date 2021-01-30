local lua = {}
lua.utils = {}

function lua.print(toPrint)
    if type(toPrint) == 'table' then 
        local toPrintResult = ''
        for i, v in pairs(toPrint) do 
            if i < #toPrint then 
                toPrintResult = toPrintResult..v..','..' '
            else 
                toPrintResult = toPrintResult..v
            end
        end
        print(tostring(toPrint)..' - {'..toPrintResult..'}')
    else print(toPrint) end
end

function lua.map(array, callFunction)
    assert(type(array) == 'table', '[lua.map] - Expected a \'table\' on #1 argument and got '..type(array))
    assert(type(callFunction) == 'function', '[lua.map] - Expected a \'function\' on #2 argument and got '..type(callFunction))
    local mapResult = {}
    for i=1, #array do 
        table.insert(mapResult, callFunction(array[i]))
    end
    return mapResult
end

function lua.filter(array, callFunction)
    assert(type(array) == 'table', '[lua.filter] - Expected a \'table\' on #1 argument and got '..type(array))
    assert(type(callFunction) == 'function', '[lua.filter] - Expected a \'function\' on #2 argument and got '..type(callFunction))
    local filterResult = {}
    for i=1, #array do
        if callFunction(array[i]) == true then 
            table.insert(filterResult, array[i])
        end
    end
    return filterResult
end

function lua.utils.arrayType(arrType, arrElements)
    assert(type(arrType) == 'string', '[lua.utils.arrayType] - Expected a \'string\' on #1 argument and got '..type(arrType))
    assert(type(arrElements) == 'table', '[lua.utils.arrayType] - Expected a \'table\' on #2 argument and got '..type(arrElements))
    for i, element in ipairs(arrElements) do 
        assert(type(element) == arrType, '[lua.utils.arrayType] - Invalid type on index: '..i..' Expected '..arrType..' got '..type(element))
    end
    return arrElements
end

function lua.array(arrType, arrElements)
    return setmetatable({
        __type = 'arrayObject',
        __arrType = arrType,
        array = lua.utils.arrayType(arrType, arrElements),

        --> arrayFunctions <--
        push = function(self, value)
            assert(type(value) == self.__arrType, '[lua.array -> push] - Expected a \''..arrType..'\' on #1 argument and got \''..type(value)..'\'')
            table.insert(self.array, value)
        end,

        pop = function(self)
            assert(#self.array > 1, '[lua.array -> pop] - Cannot remove the first element of an array')
            table.remove(self.array, #self.array)
        end,
        
        printFirst = function(self)
            assert(self.array[1] ~= nil, '[lua.array -> printFirst] - Theres no first valid element to print')
            print(self.array[1])
        end,

        printLast = function(self)
            assert(self.array[#self.array] ~= nil, '[lua.array -> printLast] - Theres no last valid element to print')
            print(self.array[#self.array])
        end,

        getArrayLength = function(self)
            assert(#self.array >= 1, '[lua.array -> getArrayLength] - Theres no valid length for this array')
            return #self.array
        end,
    },{ __call = function(self) return self.array end })
end

