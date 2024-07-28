term.clear()
 
-- Update colors
if term.isColor()
then
    term.setTextColor(colors.green)
    term.setCursorPos(1,1)
    write("Terminal is Color")
else
    term.setCursorPos(1,1)
    write("Terminal is Black White")
 
os.sleep(1)
end
 
-- Clock Loop
x_size, y_size = term.getSize()
 
while true
do
    term.clear()
    term.setCursorPos(x_size/2-1,y_size/2+1)
    write(textutils.formatTime(os.time()))
    sleep(20)
    end  
    