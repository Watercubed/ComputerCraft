-- Pulse --
-- Emits a  15 strength redstone signal at the rear of the computer
-- @param active_length: length in seconds redstone is on | int
-- @param inactive_length: length in seconds between activations
active_length = 2
inactive_length = 2

-- Start --
-- Clear screen and update user
term.clear()
term.setCursorPos(1, 1)
print("Redstone pulse activated")
print("Signal Strength: 15")
print("Side: Rear")
print("Active for: " .. active_length .. " Seconds")
print("Inactive for: " .. inactive_length .. " Seconds")

-- Start infinite pulse loop
while 1 == 1
do
  redstone.setOutput("back", true) -- Activate
  sleep(active_length) -- Hold redstone on
  redstone.setOutput("back", false) -- Deactivate
  sleep(inactive_length) -- Wait based on parameter
end