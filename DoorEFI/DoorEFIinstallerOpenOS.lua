local component = require("component")
local eeprom = component.proxy(component.list("eeprom")())
local fs = require("filesystem")
local internet = require("internet")

local function crunch(code)
  local handle = io.open("DoorEFItmp", "w")
  handle:write(code)
  handle:close()
  os.execute("crunch --lz77 --tree DoorEFItmp DoorEFItmp.comp")

  local handle = io.open("DoorEFItmp.comp", "r")
  local ret = handle:read("*all")
  handle:close()

  fs.remove("DoorEFItmp")
  fs.remove("DoorEFItmp.comp")

  return ret
end

local function install(config)
  local url
  if config then
    url = "https://github.com/ThanasisVlioras/OC-DoorOS/blob/master/DoorEFI/DoorEFIcustom.lua"
  else
    url = "https://github.com/ThanasisVlioras/OC-DoorOS/blob/master/DoorEFI/DoorEFImini.lua"
    config = ""
  end

  local handle = internet.request(url)
  local code = ""

  for chunk in handle do
    code = code .. chunk
  end
  handle.close()

  code = config .. code

  if config ~= "" then
    code = crunch(code)
  end

  eeprom.set(code)
  eeprom.setLabel("DoorEFI")
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
