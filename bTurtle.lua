-- bTurtle--
-- by BananaFish
-- Contains functions for doing various things.

move_limit = 25

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

-- Set a limit for a passed number
-- @param number: Input number
-- @param limit: maximum allowed return
function Turtle:clamp(number, limit)
  local clamp = tonumber(number)
  local limit = tonumber(limit)
  local calculated = 0

  if clamp < limit
  then
    return clamp

  else
    return limit
  end
end




-- QOL Methods --
-- Things I wanted to add that were simple but supplimented the provided library

-- seek
-- increments selected slot until hitting given description
-- @param timout: Number of slots to advance before requesting user input | Int
-- @return: If match was able to be found | Boolean
-- defaults to 16 if not given (inventory is 16)
-- resets slot to 1 at timeout
function Turtle:seek(description)
  local description = description
  local current = {}

  -- Will break after target found to not interfere with external
  -- calls expecting a return
  while 1 == 1
  do
    for i = 1, 16
    do
      current = turtle.getItemDetail() or {"empty"}
      -- If current slot not identical to description increment slot
      if current.name ~= description
      then

        -- If at slot 16 reset to one instead of advancing
        if turtle.getSelectedSlot() ~= 16
        then
          turtle.select(turtle.getSelectedSlot() + 1)
        else
          -- Simple return
          --turtle.select(1)

          -- Fancy return
          turtle.select(11)
          turtle.select(6)
          turtle.select(1)
        end

      -- If match found return true
      elseif current.name == description
      then
        return true
      end
    end

    -- No match found
    -- Request user input
    Turtle.trywipe()
    turtle.select(1)
    print("No slots found matching description passed (" .. description .. ") Refresh? y/n")
    if string.lower(io.read()) ~= "y"
    then
      -- Update note and exit
      rollover_note = "Seek abandoned"
      return false
    else
      -- pass
    end
  end
end


-- w,a,s,d,q,e,r,f
-- @param distance: repeat n times
function Turtle:w(distance)
  -- Default to once

  local distance = tonumber(distance) or 1
  local distance = Turtle:clamp(distance, move_limit)

  for n = 1, distance
  do
    turtle.forward()
  end
  rollover_note = "Moved forward " .. tostring(distance)
end

function Turtle:a(distance)
  -- Default to once
  local distance = tonumber(distance) or 1
  local distance = Turtle:clamp(distance, move_limit)
  turtle.turnLeft()
  for n = 1, distance
  do
    turtle.forward()
  end
  turtle.turnRight()
  rollover_note = "Moved left " .. tostring(distance)
end

function Turtle:s(distance)
  -- Default to once

  local distance = tonumber(distance) or 1
  local distance = Turtle:clamp(distance, move_limit)

  for n = 1, distance
  do
    turtle.back()
  end
  rollover_note = "Moved backward " .. tostring(distance)
end

function Turtle:d(distance)
  -- Default to once
  local distance = tonumber(distance) or 1
  local distance = Turtle:clamp(distance, move_limit)

  turtle.turnRight()
  for n = 1, distance
  do
    turtle.forward()
  end
  turtle.turnLeft()

  rollover_note = "Moved right " .. tostring(distance)
end

function Turtle:q(count)
  -- Default to once
  local count = tonumber(count) or 1
  local count = Turtle:clamp(count, move_limit)
  for n = 1, count
  do
    turtle.turnLeft()
  end
  rollover_note = "Turned left " .. tostring(count)  .. " times"
end

function Turtle:e(count)
  -- Default to once
  local count = tonumber(count) or 1
  local count = Turtle:clamp(count, move_limit)
  for n = 1, count
  do
    turtle.turnRight()
  end
  rollover_note = "Turned right " .. tostring(count) .. " times"
end

function Turtle:r(distance)
  -- Default to once

  local distance = tonumber(distance) or 1
  local distance = Turtle:clamp(distance, move_limit)

  for n = 1, distance
  do
    turtle.up()
  end
  rollover_note = "Moved up " .. tostring(distance)
end

function Turtle:f(distance)
  -- Default to once

  local distance = tonumber(distance) or 1
  local distance = Turtle:clamp(distance, move_limit)

  for n = 1, distance
  do
    turtle.down()
  end
  rollover_note = "Moved down " .. tostring(distance)
end


-- Drills a 1x1 tunnel of the specified distance
-- @param distance: distance to drill
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
  local amount = tonumber(amount)
  turtle.refuel(amount)
end

-- Place in front of tree chunk to chop down
function Turtle:trunk()
  local height = 0

  -- Move under tree
  turtle.dig()
  turtle.forward()

  -- Dig upward until no detection or limit
  for n = 1, move_limit
  do
    if turtle.detectUp()
    then
      turtle.digUp()
      turtle.up()
      height = height + 1
    end
  end
  -- Decend amount ascended
  for n = 0, height
  do
    turtle.down()
  end

  -- Return to starting position
  turtle.back()
end

-- Advanced Methods --

-- floor
-- Replicates the block under the turtle on a flat plane
-- L x W with turtle at 1,1
-- Takes source from origin
function Turtle:floor(length, width, replace)
  -- If params not passed, set to 0
  local length = length or 0
  local width = width or 0
  local replace = replace or "f"
  local length_moved = 0
  local width_moved = 0
  local source_present = false
  local source_info = {} -- Type unknown at declaration
  local source_name = "" -- Name of block below turtle at origin
  local target_info = {}
  local target_name = "" -- Name of block below turtle

  -- Limit maximum size
  length = Turtle:clamp(length, move_limit)
  width = Turtle:clamp(width, move_limit)

  replace = string.lower(replace)

  -- Ensure valid params
  if length > 1
    and width > 1
    then
      -- Detect and store source block info
      source_present, source_info = turtle.inspectDown()

      --for key, value in pairs(source_info)
      --do
        --print(tostring(key))
        --print(tostring(value))
      --end
  --print(type(source_info.name))
  --print(source_info.name)
  --error()

      -- Verify source detected
      if source_present == true
      then
        -- Pull name string from returned array
        source_name = source_info.name

        -- Start row
        for w = 1, width
        do
          -- Start Column
          for l = 1, length
          do
            -- Detect and store target block info
            target_present, target_info = turtle.inspectDown()
            target_name = target_info.name

            -- Seek to ensure block availability
            if Turtle:seek(source_name) == true
            then
              -- General Loop --
              -- Dig if not on first block
              -- Also, not same type
              if not (l == 1 and w == 1) and replace == "t" and target_name ~= source_name
              then
                turtle.digDown()
              else
                -- pass
              end

              turtle.placeDown()

              -- Dont advance at end of column
              if l ~= length
              then
                turtle.forward()
              else
                -- pass
              end

            else
              -- Something went wrong, return false again
              return false
            end
          end

          -- Advance row
          -- Odd row (Happens first)
          if  w % 2 ~= 0
          then
            turtle.turnRight()
            -- Don't advance past the given size
            if w ~= width
            then
              -- Dont advance at end of row
              if l ~= length
              then
                turtle.forward()
              end
            else
              --Pass
            end
            turtle.turnRight()

          -- Even Row
          else
            -- Don't advance past the given size
            if w ~= width
            then
              turtle.turnLeft()
              -- Dont advance at end of row
              if l ~= length
              then
                turtle.forward()
              end
              turtle.turnLeft()
            end
          end
          -- Loop end
        end
        -- Return to starting position
        -- Probably will need work
        -- Finished on odd width
        if width % 2 ~= 0
        then
          Turtle:w(length)
          turtle.turnRight() -- This is from cc turtle api
          Turtle:w(width - 1) -- Negative offset from not advancing at end
          turtle.turnRight()

        -- Finsihed on even width
        else
          turtle.turnRight()
          Turtle:w(width - 1) -- Negative offset from not advancing at end
          turtle.turnRight()
        end

      else
        rollover_note = "Source block not detected below"
      end
  end
end

-- Start --
bTurtle = Turtle:new()
rollover_note = "" -- Global
local input = ""
local input_formated = {}
local input_index = 1
local params = {}
local param_index = 1


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

  print("  w,a,s,d,q,e,r,f")

  -- TODO: Refactor, too bloated
  -- Remove index and wipe from tutorial view
  for key, value in pairs(getmetatable(bTurtle))
  do
    if key ~= "__index"
      and key ~= "new"
      and key ~= "trywipe"
      and key ~= "wipe"
      and key ~= "w"
      and key ~= "a"
      and key ~= "s"
      and key ~= "d"
      and key ~= "q"
      and key ~= "e"
      and key ~= "r" -- Rise
      and key ~= "f" -- Fall
      and key ~= "clamp"

    then
      print(" ", key)
    end
  end

  -- Manually added menu options
  print("  exit or ex")

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
  if input_lower == "exit" or input_lower == "ex"
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