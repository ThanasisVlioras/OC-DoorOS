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

local handle = filesystem.open("C://test")
local content = filesystem.read(handle)
filesystem.close(handle)

component.proxy(component.list("gpu")()).fill(1, 1, 160, 50, " ")
while true do
  component.proxy(component.list("gpu")()).set(1, 1, content)
end
