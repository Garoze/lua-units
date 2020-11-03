--array('type', 'n', 'value')
--list('value', 'poiterNext')
--list -> tem HEAD (first), TAIL(ultimo)
-- double vai e volta então cada value tem um next e previous 

--stack()
-- push coloca no topo
-- pop delete do topo e retorna
-- peek apenas retorna sem deletar

--queue()
-- inQueue coloca no inicio
-- endQueue retira

local callMeta = { __call = function(self, ...) return self[1] end }

function array(arrayType, elementsTable)
    assert(type(arrayType) == 'string', '[array] - Expected a \'string\' on #1 argument and got '..type(arrayType))
    assert(type(elementsTable) == 'table', '[array] - Expected a \'table\' on #2 argument and got '..type(elementsTable))
    for _, element in ipairs(elementsTable) do 
        if type(element) ~= arrayType then return '[array] - Invalid array element type.' end
        return setmetatable({
            elementsTable,
            __type = 'arrayObject',
            __elements = #elementsTable,
        }, callMeta)
    end
end

local a = array('number', {1,2,3})

