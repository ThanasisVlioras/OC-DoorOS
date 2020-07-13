function doLoadFromBootFS(path) -- Global until dofile / require is implemented
  local fs = component.proxy(computer.getBootAddress())

  local handle = fs.open(path)
  local buffer = ""

  repeat -- We need to read this way to handle the fact that opencomputers read files in "chunks"
    local data = fs.read(handle, math.huge)
    buffer = buffer .. (data or "")
  until data == nil

  fs.close(handle)

  return load(buffer, "=" .. path)
end

-- Load Libraries

filesystem = doLoadFromBootFS("/Libraries/Filesystem/Filesystem.lua")()
doLoadFromBootFS("/Boot/MountFilesystems.lua")()

GUI = doLoadFromBootFS("/Libraries/UI.lua")()
MENU = doLoadFromBootFS("/Libraries/MENU.lua")()
keyboard = doLoadFromBootFS("/Libraries/Keyboard.lua")()
UIoptions = doLoadFromBootFS("/Options/UI")()

gpu = component.proxy(component.list("gpu")())
local MENUFiles = {}
local MENUMain

gpu.setBackground(UIoptions.backgroundColor)
gpu.setForeground(UIoptions.foregroundColor)
gpu.fill(1, 1, 160, 50, " ")

local files = filesystem.list("DoorOS://")
for _, file in ipairs(files) do
  GUI:new("DoorOS://" .. file, 3, file, UIoptions.backgroundColor, UIoptions.foregroundColor)
  table.insert(MENUFiles, GUI.returnGUIobjects()["DoorOS://" .. file])
  if not MENUMain then MENUMain = GUI.returnGUIobjects()["DoorOS://" .. file] end
end

local testMENU = MENU:new(MENUFiles, MENUMain)
testMENU:render(true)

while true do
  local type, _, _, code = computer.pullSignal()
  if type == "key_up" then
    keyboard.keyboardHandle(code)
  end
end
