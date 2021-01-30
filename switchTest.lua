local switch = require('switch').switch
local case = require('switch').case

local x = 1

switch(x, 
    case(1, print, 'é 1')
)

