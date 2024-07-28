-- bTurtle--
-- by BananaFish
-- Contains functions for doing various things.

Turtle = {}
Turtle.__index = Turtle

function Turtle:new()
    local instance = setmetatable({}, Turtle)
    return instance
end

-- QOL Methods --
-- Things I wanted to add that were simple but supplimented the provided library
-- @param Distance to drill: string
-- Drills a 1x1 tunnel of the specified distance
function drill(distance,  come_home)
    
    -- Variables
    local distance = distance
    
    
    return nil

end


-- Start --

print "BananaTurtle"
local input = io.read()
print (input)
-- End --