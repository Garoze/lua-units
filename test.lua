local GlobalInterfaces = {}

function interfaceExists(name)
    return GlobalInterfaces[name] ~= nil or false
end

function getType(validateObject)
    if type(validateObject) == 'table' and validateObject.__type ~= nil then 
        return validateObject.__type
    end
    return type(validateObject)
end

function getInterfaceObject(name)
    if interfaceExists(name) == true then 
        return GlobalInterfaces[name]
    end
    return false
end

function isInterfaceObject(interfaceTable)
	assert(getType(interfaceTable) == 'table', '[isInterfaceObject] - Expected a \'table\' on #1 argument and got '..getType(interfaceTable))
    return interfaceTable.__type == 'interfaceObject' or false
end

function isValidInterface(interfaceTable)
    assert(getType(interfaceTable) == 'table', '[isValidInterface] - Expected a \'table\' on #1 argument and got '..getType(interfaceTable))
    local errors = {}
    for field, v in pairs(interfaceTable) do 
        if getType(field) ~= 'string' or getType(v) ~= 'string' then
            table.insert(errors, field)
        end
    end
    return #errors == 0 or false
end


