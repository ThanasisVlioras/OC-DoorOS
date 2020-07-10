local component = require("component")
local eeprom = component.proxy(component.list("eeprom")())
local fs = require("filesystem")
local internet = require("internet")

local function crunch(code)
  local handle = io.open("/DoorEFItmp", "w")
  handle:write(code)
  handle:close()
  os.execute("crunch --lz77 --tree DoorEFItmp DoorEFItmp.comp")

  local handle = io.open("/DoorEFItmp.comp", "r")
  local ret = handle:read("*all")
  handle:close()

  fs.remove("/DoorEFItmp")
  fs.remove("/DoorEFItmp.comp")

  return ret
end

local function install(config)
  local url
  if config then
    print("Installing Custom Edition...")
    url = "https://raw.githubusercontent.com/ThanasisVlioras/OC-DoorOS/master/DoorEFI/DoorEFIcustom.lua"
  else
    print("Installing Default Edition...")
    url = "https://raw.githubusercontent.com/ThanasisVlioras/OC-DoorOS/master/DoorEFI/DoorEFImini.lua"
    config = ""
  end

  local handle = internet.request(url)
  local code = ""

  for chunk in handle do
    code = code .. chunk
  end

  code = config .. code

  if config ~= "" then
    code = crunch(code)
  end

  eeprom.set(code)
  eeprom.setLabel("DoorEFI")
  print("Done! Reboot ? (y)")

  if io.read() == "y" then
    require("computer").shutdown(true)
  end
end

print("Press y to insert a path to a EFI config file (Requires crunch compressor, found on oppm)")
local input = io.read()

if input ~= "y" then
  install()
else
  print("Waiting for path...")
  input = io.read()
  if not fs.exists(input) then
    print("The specified file does not exist !")
    return
  end
  if fs.isDirectory(input) then
    print("That is a folder, not a file")
    return
  end

  local handle = io.open(input, "r")
  local config = handle:read("*all")
  io.close(handle)
  install(config)
end
