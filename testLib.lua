function libAssert(toAssert)
    return {
        equalsTo = function(self, n)
            return toAssert == n or false
        end,
    }
end


local a = 10

print(libAssert(a):equalsTo(10))
