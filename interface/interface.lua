local GlobalInterfaces = {}
local interfaceCallMeta = { __call = function(self, ...) return self:validateInterface(self,...) end } 

function interfaceExists(name)
    return GlobalInterfaces[name] ~= nil or false
end

function isInterfaceObject(interface)
    return interface.__type == 'interfaceObject' or false
end

function getInterfaceObject(name)
    if interfaceExists(name) == true then
        return GlobalInterfaces[name] 
    end return false
end

function getObjectType(object)
    if type(object) == 'table' and object.__type ~= nil then 
        return object.__type
    else
        return type(object)
    end
end

function isValidType(type)
    local interfaceValidTypes = {
        ['string']  = true,
        ['number']  = true,
        ['table']   = true,
        ['boolean'] = true,
        ['interfaceObject'] = true,
    }
    return interfaceValidTypes[type]
end

function isValidInterface(interfaceTable)
    local errors = {}
    for field, v in pairs(interfaceTable) do 
        if getObjectType(field) ~= 'string' or getObjectType(v) ~= 'string' then 
            if not isValidType(v) then table.insert(errors, field) end
        end
    end return #errors == 0 or false
end

function Interface(name, interfaceTable)
    assert(getObjectType(name) == 'string', '[createInterface] - Expected a \'string\' on #1 argument and got '..type(name))
    assert(getObjectType(interfaceTable) == 'table', '[createInterface] - Expected a \'table\' on #2 argument and got '..type(interfaceTable))
    if interfaceExists(name) == false then 
        assert(isValidInterface(interfaceTable) == true, '[Interface] - Invalid interface construction, please make sure that every field has a \'string\' value.')
        GlobalInterfaces[name] = {
            __name = name,
            __type = 'interfaceObject',
            interface = interfaceTable,
            validateInterface = function(self, validateTable)
                assert(getObjectType(validateTable) == 'table', '[validateInterface] - Expected a \'table\' on #1 argument and got a '..type(validateTable))
                if self:hasSameMethods(validateTable) == true then 
                    return self:hasSameTypes(validateTable) == true or self:getDiffTypes(validateTable)
                else self:getMissingFields(validateTable) end
            end,
            hasSameMethods = function(self, validateTable)
                for field, v in pairs(self.interface) do 
                    if validateTable[field] == nil then
                        return false 
                    end 
                end return true
            end,
            hasSameTypes = function(self, validateTable)
                for field, v in pairs(self.interface) do 
                    if type(validateTable[field]) ~= v then
                        return false
                    end
                end return true
            end,
            getDiffMethods = function(self, validateTable)
                for field, v in pairs(self.interface) do 
                    if validateTable[field] == nil then 
                        print('[Interface] - Missing Field: '..field)
                    end
                end
            end,
            getDiffTypes = function(self, validateTable) 
                for field, v in pairs(self.interface) do 
                    if type(validateTable[field]) ~= v then 
                        print('[getDiffTypes] - Field: '..field..' expected \''..v..'\' and got ' ..type(validateTable[field]))
                    end
                end
            end,
            getMissingFields = function(self, validateTable)
                for field, v in pairs(self.interface) do 
                    if validateTable[field] == nil then 
                        print('[getMissingFields] - Missing field: '..field)
                    end
                end
            end,
        } 
    else return getInterfaceObject(name):validateInterface(interfaceTable) end
end

Interface('test', { name = 'string', age = 'number'})
Interface('test', { name = 23, age = 23})


--  Separar o Interface como createInterface
--  Pra gerenciar a interface no GlobalInterfaces
--  Criar uma função de validação de interfaces
    -- Com return 
