local lua = {}
lua.utils = {}

function lua.utils.arrayType(arrType, arrElements)
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

