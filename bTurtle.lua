-- bTurtle--
-- by BananaFish
-- Contains functions for doing various things.

local help = ""
-- Initalize Turtle Class
Turtle = {}
Turtle.__index = Turtle

function Turtle:new()
  print("Initalizing Turtle Object")
    local instance = setmetatable({}, Turtle)
    instance.fuel_level = 0

    return instance
end

-- Interface Methods --
-- Helping for online development

-- Wipe --
-- Attempt to clear screen and reset cursor.
-- Copy-cat IDE doesn't contain some functions like setCursorPosition.
-- This causes errors.
function Turtle:wipe()
  local repeat_input = true

  print("Attempting wipe")
  term.clear()
  term.setCursorPosition(1,1)
end

-- Exit
-- Break interface loop
function Turtle:exit()
  print("Exiting bTurtle")
  return
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
bTurtle = Turtle:new()
local input = ""

local status, result = pcall(function() bTurtle:wipe() end)
if status == true
then
  print("Screen Wiped")

else
  print("Wipe error, Probably can't set cursor to 1,1")
  term.clear()
end

print "bTurtle 0.1.0"
print("By BananaFish")

print("Please input the desired method")
input = io.read()

if bTurtle[input] and type(bTurtle[input]) == "function" -- Request user input for selecting method
then
  bTurtle[input](bTurtle)
end


-- End --