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

function Turtle:trywipe()
  local status, result = pcall(function() bTurtle:wipe() end) -- Error trap clear function

  if status == false
  then
    print("Wipe error, Probably can't set cursor to 1,1")
    term.clear()
  end
end

function Turtle:wipe()
  print("Attempting wipe")
  term.clear()
  term.setCursorPos(1,1)
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
local input_lower = ""
local rollover_note = ""


while true
do
  Turtle:trywipe()


  -- Info block --
  term.setTextColor(16) -- Dec Yellow
  print "bTurtle 0.1.0"

  term.setTextColor(1) -- Dec White
  print("Current fuel Level:", turtle.getFuelLevel())
  print("Use Help 'Method' for description\n")
  print("Methods:")

  -- Hardware functions
  for key, value in pairs(getmetatable(bTurtle))
  do
    if key ~= "__index" and key ~= "new" and key ~= "trywipe" and key ~= "wipe"  -- Remove index and wipe from tutorial view
    then
      print(" ", key)
    end
  end

  -- Manually added menu options
  print("  exit")

  -- If note from previous entry exists add note over entry line and reset
  if rollover_note ~= ""
  then
    term.setCursorPos(1,12)
    print(rollover_note)
    term.setCursorPos(1,1)
    rollover_note = ""
  end

  term.setCursorPos(1,13)

  -- Gets user input
  input = io.read()
  input_lower = string.lower(input)

    if input_lower == "exit"
    then
      Turtle:trywipe()
      break

    -- Method without params
    elseif bTurtle[input] and type(bTurtle[input]) == "function" -- Request user input for selecting method
    then
      bTurtle[input](bTurtle)

    -- Method with params
    elseif bTurtle[input] and type(bTurtle[input][1]) == "function" -- Request user input for selecting method
    then
      bTurtle[input](bTurtle)

    else
      rollover_note = "Invalid command:" .. input
    end
end


-- End --