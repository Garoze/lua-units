local switch = require('switch').switch
local case = require('switch').case
local default = require('switch').default

local x = 6

switch(x,
    case(10, print, 'è igual a 10'),
    case(5, function(i)
        print('é 5 e o i é: '..i)
    end, 1),
    default(print, 'não é nenhum dos 2') 
)
