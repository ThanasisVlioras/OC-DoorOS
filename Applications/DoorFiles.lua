local function showFiles(path)
  local MENUFiles = {}
  local MENUMain
  GUI.clearScreen()

  local files = FILESYSTEM.list(path)
  for _, file in ipairs(files) do
    -- Add UI
    GUI:new(path .. file, 3, file, UIoptions.backgroundColor, UIoptions.foregroundColor)
    table.insert(MENUFiles, GUI.returnGUIobjects()[path .. file])
    if not MENUMain then MENUMain = GUI.returnGUIobjects()[path .. file] end

    -- Add Functions
    if FILESYSTEM.isDirectory(path .. file) then
      GUI.returnGUIobjects()[path .. file].onTouch = function()
        FILESYSTEM.setCurrentPath(path .. file)
        showFiles(path .. file)
      end
    else
      GUI.returnGUIobjects()[path .. file].onE = function()
        doLoadFromBootFS("/Applications/DoorEditor.lua")(path .. file)
      end
    end
  end

  -- Add "Back" Button (If not at root)
  local _, resolvedPath = FILESYSTEM.seperatePathParts(path)
  if resolvedPath ~= "/" then
    GUI:new(path .. "Back", 3, "Back", UIoptions.backgroundColor, UIoptions.foregroundColor)
    GUI.returnGUIobjects()[path .. "Back"].onTouch = function()
      FILESYSTEM.setCurrentPath(FILESYSTEM.levelUp(path))
      showFiles(FILESYSTEM.levelUp(path))
    end

    if not MENUMain then MENUMain = GUI.returnGUIobjects()[path .. "Back"] end
  end

  table.insert(MENUFiles, GUI.returnGUIobjects()[path .. "Back"])

  local Menu = MENU:new(MENUFiles, MENUMain)
  Menu:render(true)
end

showFiles(FILESYSTEM.getCurrentPath())

while true do
  local code = KEYBOARD.keyboardGenericMenuHandle(code)
  if code == 18 then -- E (This is here because its not a "generic menu" thing but a specifically a DoorFiles thing)
    selectedObject.onE()
    showFiles(FILESYSTEM.getCurrentPath())
  end
end
