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

function createInterface(interfaceTable)
    assert(getType(interfaceTable) == 'table', '[createInterface] - Expected a \'table\' on #1 argument and got '..getType(interfaceTable))
    assert(isValidInterface(interfaceTable) == true, '[createInterface] - Invalid interface construction, please make sure that every field has a \'string\' value.')
    return {
        __name = nil,
        __type = 'interfaceObject',
        interface = interfaceTable,
    }
end

function interfaceHandler(name, interfaceObject)
    assert(interfaceExists(name) == false, '[interfaceHandler] - Error: There is a interface with this name.')
    assert(isInterfaceObject(interfaceObject) == true, '[interfaceHandler] - Invalid interface construction please see: createInterface syntax.')
    interfaceObject.__name = name
    GlobalInterfaces[name] = interfaceObject
    return interfaceExists(name) or false
end

function validadeInterface(interface, validadeInterface)
    for field, v in pairs(interface) do 
        if validadeInterface[field] == nil then return false end 
    end
end

function Interface(name, interfaceValidate)
    assert(interfaceExists(name) == true, '[Interface] - Error: There\'s no interface with the name ['..name..']')
    assert(getType(interfaceValidate) == 'table', '[Interface] - Expected a \'table\' on #2 argument and got '..getType(interfaceValidate))
    if validadeInterface(getInterfaceObject(name), interfaceValidate) == true then 
        return interfaceValidate
    end
    return false
end

interfaceHandler('test', createInterface { o1 = 'string'})
Interface('test', { o = 'ola'})
