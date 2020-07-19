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

FILESYSTEM = doLoadFromBootFS("/Libraries/Filesystem/Filesystem.lua")()

GUI = doLoadFromBootFS("/Libraries/UI.lua")()
TEXTUI = doLoadFromBootFS("/Libraries/TextUI.lua")()
MENU = doLoadFromBootFS("/Libraries/MENU.lua")()
UIoptions = doLoadFromBootFS("/Options/UI")()

KEYBOARD = doLoadFromBootFS("/Libraries/Keyboard.lua")()

-- Load Components
GPU = component.proxy(component.list("gpu")())

-- Boot
doLoadFromBootFS("/Boot/MountFilesystems.lua")()

-- Finally, open DoorFiles
doLoadFromBootFS("/Applications/DoorFiles.lua")()
