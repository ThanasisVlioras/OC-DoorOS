local function showFiles(path)
  local MENUFiles = {}
  local MENUMain
  GUI.clearScreen()

  local files = FILESYSTEM.list(path)
  for _, file in ipairs(files) do
    -- Add UI
    local GUIobject = GUI:new(path .. file, 3, file, UIoptions.backgroundColor, UIoptions.foregroundColor)
    table.insert(MENUFiles, GUIobject)
    if not MENUMain then MENUMain = GUIobject end

    -- Add Functions
    if FILESYSTEM.isDirectory(path .. file) then
      GUIobject.onTouch = function()
        FILESYSTEM.setCurrentPath(path .. file)
        showFiles(path .. file)
      end
    else
      GUIobject.onE = function()
        doLoadFromBootFS("/Applications/DoorEditor.lua")(path .. file)
      end
    end
  end

  -- Add "Back" Button (If not at root)
  local _, resolvedPath = FILESYSTEM.seperatePathParts(path)
  if resolvedPath ~= "/" then
    local back = GUI:new(path .. "Back", 3, "Back", UIoptions.backgroundColor, UIoptions.foregroundColor)
    back.onTouch = function()
      FILESYSTEM.setCurrentPath(FILESYSTEM.levelUp(path))
      showFiles(FILESYSTEM.levelUp(path))
    end

    table.insert(MENUFiles, back)
    if not MENUMain then MENUMain = back end
  end

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
