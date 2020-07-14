local function showFiles(path)
  local MENUFiles = {}
  local MENUMain

  local files = FILESYSTEM.list(path)
  for _, file in ipairs(files) do
    -- Add UI
    GUI:new(path .. file, 3, file, UIoptions.backgroundColor, UIoptions.foregroundColor)
    table.insert(MENUFiles, GUI.returnGUIobjects()[path .. file])
    if not MENUMain then MENUMain = GUI.returnGUIobjects()[path .. file] end

    -- Add Functions
    if FILESYSTEM.isDirectory(path .. file) then
      GUI.returnGUIobjects()[path .. file].onTouch = function()
        showFiles(path .. file)
      end
    end
  end

  -- Add "Back" Button (If not at root)
  local _, resolvedPath = FILESYSTEM.seperatePathParts(path)
  if resolvedPath ~= "/" then
    GUI:new(path .. "Back", 3, "Back", UIoptions.backgroundColor, UIoptions.foregroundColor)
    GUI.returnGUIobjects()[path .. "Back"].onTouch = function()
      showFiles(FILESYSTEM.levelUp(path))
    end
  end

  table.insert(MENUFiles, GUI.returnGUIobjects()[path .. "Back"])

  local Menu = MENU:new(MENUFiles, MENUMain)
  Menu:render(true)
end

showFiles(component.proxy(computer.getBootAddress()).getLabel() .. "://")

while true do
  local type, _, _, code = computer.pullSignal()
  if type == "key_up" then
    KEYBOARD.keyboardHandle(code)
  end
end
