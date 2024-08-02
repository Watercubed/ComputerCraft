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

-- w,a,s,d,Space,Shift,q,e
-- @param count: repeat n times
--function Turtle:w(count)
  -- Default to once
--  local count = count or 1

  --for n = 1, count
  --do
   -- turtle.forward()
  --end






-- Drills a 1x1 tunnel of the specified distance
-- @param Distance to drill: string
-- @param come_home: Will the rutle return to the starting position?
function Turtle:drill(distance,  come_home)

    -- Variables
    local distance = distance
    -- Come home by default
    local come_home = come_home or true

    -- Dig, and move forward n times
    for n = 1, distance
    do
      turtle.suck()
      turtle.dig()
      turtle.forward()
    end

    -- Return if come_home true
    if come_home == true
    then
      for n = 1, distance
      do
        turtle.back()
      end
    end


    return nil

end

-- Refuels slot one

function Turtle:refuel(amount)
  -- Convert to int
  print(amount)
  local amount = tonumber(amount)
  turtle.refuel(amount)

end

-- Start --
bTurtle = Turtle:new()
local input = ""
local input_formated = {}
local input_index = 1
local params = {}
local param_index = 1
local rollover_note = ""


while true
do
  Turtle:trywipe()


  -- Info block --
  term.setTextColor(16) -- Dec Yellow
  print "bTurtle 0.2.0"

  term.setTextColor(1) -- Dec White
  print("Current fuel Level:", turtle.getFuelLevel())
  print("Use Help 'Method' for description\n")
  print("Methods:")

  print("W,A,S,D,Space,Shift,q,e")
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

  -- Set cursor one above lowest line on turtle
  term.setCursorPos(1,13)

  -- Take and format user input
  input = io.read()
  input_lower = string.lower(input)

  -- Unpack input string into array
  input_index = 1
  param_index = 1
  for element in string.gmatch(input, "%S+")
  do
    input_formated[input_index] = string.lower(element)

    -- If not first element add to parameter list
    if input_index >= 1
    then
      params[param_index] = element
      param_index = param_index + 1
    end

    input_index = input_index + 1
  end


  -- If user enters any form of input break immediatly
  if input_lower == "exit"
  then
    Turtle:trywipe()
    break

  -- User enters method with params
  -- 2 because the index is declared at 1
  elseif type(bTurtle[input_formated[1]]) == "function" and input_index ~= 2
  then
    rollover_note = "Method with params"
    bTurtle[input_formated[1]](unpack(params))

  -- User enters method without params
  elseif type(bTurtle[input_lower]) == "function" -- Request user input for selecting method
  then
    rollover_note = "Method without params"
    bTurtle[input_lower](bTurtle)

  -- Unknown input
  else
    rollover_note = "Invalid command:" .. input
  end
end


-- End --