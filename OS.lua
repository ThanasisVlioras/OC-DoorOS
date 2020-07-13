function doLoadFromBootFS(path)
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
local normal = doLoadFromBootFS("/Libraries/Filesystem/Normal.lua")()
filesystem.mount(normal:new(computer.getBootAddress()))

GUI = doLoadFromBootFS("/Libraries/UI.lua")()
menu = doLoadFromBootFS("/Libraries/Menu.lua")()
keyboard = doLoadFromBootFS("/Libraries/Keyboard.lua")()

gpu = component.proxy(component.list("gpu")())

gpu.setBackground(0x097A2D)
gpu.setForeground(0xC4FFAD)
gpu.fill(1, 1, 160, 50, " ")

GUI:new("test1", 1, "test1", 0x097A2D, 0xC4FFAD)
GUI:new("test2", 1, "test2", 0x097A2D, 0xC4FFAD)
GUI:new("test3", 1, "test3", 0x097A2D, 0xC4FFAD)

local testMenu = menu:new({GUI.returnGUIobjects().test1, GUI.returnGUIobjects().test2, GUI.returnGUIobjects().test3}, GUI.returnGUIobjects().test1)
testMenu:render(true)

GUI.returnGUIobjects().test1:setAdjacentObjects(nil, nil, nil, GUI.returnGUIobjects().test2)
GUI.returnGUIobjects().test2:setAdjacentObjects(nil, nil, GUI.returnGUIobjects().test1, GUI.returnGUIobjects().test3)
GUI.returnGUIobjects().test3:setAdjacentObjects(nil, nil, GUI.returnGUIobjects().test2)

while true do
  local type, _, _, code = computer.pullSignal()
  if type == "key_up" then
    keyboard.keyboardHandle(code)
  end
end
