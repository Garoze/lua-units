local luaLib = {}

function luaLib.switch(condition, ...)
    assert(condition ~= nil, '[luaLib.switch] - Expected a \'condition\' on #1 argument and got none')
    assert(type(...) == 'table', '[luaLib.switch] - Expected a \'table\' on #2 argument and got '..type(...))
    for _, case in ipairs({...}) do 
        if case.condition == condition or case.condition == nil then 
            return #case.args >= 1 and case.f(unpack(case.args)) or case.f()
        end
    end
end

function luaLib.case(condition, f, ...)
    assert(condition ~= nil, '[luaLib.switch] - Expected a \'condition\' on #1 argument and got none')
    assert(type(f) == 'function', '[luaLib.case] - Expected a \'function\' on #2 argument and got '..type(f))
    return { condition = condition, f = f, args = {...} }
end

function luaLib.default(f, ...)
    assert(type(f) == 'function', '[luaLib.default] - Expected a \'function\' on #2 argument and got '..type(f))
    return { condition = nil, f = f, args = {...} }
end

return 
{
    switch = luaLib.switch,
    case = luaLib.case,
    default = luaLib.default
}
