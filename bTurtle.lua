-- bTurtle--
-- by BananaFish
-- Contains functions for doing various things.

-- Initalize Turtle Class
Turtle = {}
Turtle.__index = Turtle

function Turtle:new()
    local instance = setmetatable({}, Turtle)
    local fuel_level = 0

    print("Testy")
    return instance
end

-- Interface Methods --
-- Helping for online development

-- Wipe --
-- Attempt to clear screen and reset cursor.
-- Copy-cat IDE doesn't contain some functions like setCursorPosition.
-- This causes errors.
function Turtle:wipe()
  print("Attempting wipe")
  term.clear()
  term.setCursorPosition(1,1)
end

-- QOL Methods --
-- Things I wanted to add that were simple but supplimented the provided library

-- Drills a 1x1 tunnel of the specified distance
-- @param Distance to drill: string
function Turtle:drill(distance,  come_home)

    -- Variables
    local distance = distance

    return nil

end

function Turtle:refuel(amount)
  local amount = amount
  turtle.refuel(amount)
end

-- Start --
local status, result = pcall(function() bTurtle:wipe() end)
if status == TRUE
then
  print("Screen Wiped")

else
  print("Wipe error")
end

print "bTurtle 0.1.0"
print("By BananaFish")

bTurtle = Turtle:new()

local input = io.read()
print (input)

-- End --