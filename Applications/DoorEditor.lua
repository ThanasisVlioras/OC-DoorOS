local arg = {...}

local function showFile(path) -- This is very temporary, everything about this code is subject to change
  GUI.clearScreen()
  print(FILESYSTEM.get(path))
  selectedObject = nil

  while true do
    local code = KEYBOARD.keyboardGenericMenuHandle()
    if code == 18 then return end -- Return on E
  end
end

showFile(arg[1])
