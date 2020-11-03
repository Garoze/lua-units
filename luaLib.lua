local lua = {}

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

local testArray = {1,2,3,4,5,6,7,8,9,10}

lua.print(
    lua.filter(testArray,
        function(n)
            return n % 2 == 0
        end
    )
)
