local autoBootInterval = 2
local backgroundColor = 0x097A2D
local foregroundColor = 0xC4FFAD
local horizontalPadding = 2
local verticalPadding = 3
local verticalMargin = 2
-- Config ^^^

local bootAddr = nil
local gpu = component.proxy(component.list("gpu")())
local eeprom = component.proxy(component.list("eeprom")())
local internet = component.proxy(component.list("internet")())
local GUI = {}
local MENU = {}
local GUIobjects = {}
verticalMargin = verticalMargin + verticalPadding -- Avoids button collisions and ensures intented functionality

local function centrizeObject(fx) -- Gives the proper x value that puts the object's center through the screen's center
  return 80 - (#fx / 2)
end

function GUI:new(name, y, text, rectColor, textColor)
  local object = {}
  setmetatable(object, self)
  self.__index = self
  object.x = centrizeObject(text)
  object.y = y
  object.text = text
  object.fx = #object.text + horizontalPadding
  object.rectColor = rectColor
  object.textColor = textColor
  GUIobjects[name] = object
end

function GUI:render()
  gpu.setBackground(self.rectColor)
  gpu.setForeground(self.textColor)

  gpu.fill(self.x, self.y, self.fx, verticalPadding, " ")

  local yTextCentrized = self.y + math.floor(verticalPadding / 2)
  gpu.set(self.x + horizontalPadding / 2, yTextCentrized, self.text)
end

function GUI:unRender()
  gpu.setBackground(backgroundColor)
  gpu.fill(self.x, self.y, self.fx, verticalPadding, " ")
end

function GUI:unRenderAll()
  for _, object in pairs(GUIobjects) do
    object:unRender()
  end
end

function GUI:setAdjacentObjects(up, down, left, right)
  if up then self.up = up end -- Do not accidentally set the others to nil if you try to change a single option
  if down then self.down = down end
  if left then self.left = left end
  if right then self.right = right end
end

function GUI:setHighlight(input)
  if input then
    self.rectColor = foregroundColor
    self.textColor = backgroundColor
  else
    self.rectColor = backgroundColor
    self.textColor = foregroundColor
  end

  self:render()
end

function MENU:new(objects, mainObject)
  local object = {}

  setmetatable(object, self)
  self.__index = self

  object.attached = objects
  object.mainObject = mainObject
  return object
end

function MENU:render()
  GUI:unRenderAll()

  for _, object in pairs(self.attached) do
    object:render()
  end

  selectedObject = self.mainObject
  selectedObject:setHighlight(true)
end

computer.getBootAddress = function()
  return eeprom.getData()
end

computer.setBootAddress = function(input)
  eeprom.setData(input)
end

local function readBootFS(fs, path)
  local handle = fs.open(path, "r")
  if not handle then return nil end

  local content = ""
  repeat
    local data = fs.read(handle, math.huge)
    content = content .. (data or "")
  until not data
  fs.close(handle)

  return content
end

local function returnOSfunction(address)
  local fs = component.proxy(address)
  if not fs then return nil end -- Lets the booter know to find a new disk

  local code = readBootFS(fs, "/init.lua") or readBootFS(fs, "/OS.lua")
  return load(code, "=init")
end


local function findOperatingSystems()
  local addr = {}
  for address, componentType in component.list("filesystem") do
    local fs = component.proxy(address)
    if fs.exists("/init.lua") or fs.exists("/OS.lua") then -- Selects the first operating system it finds
      table.insert(addr, address)
    end
  end
  return addr
end

local function boot(fs)
  if fs then -- If a specific filesystem is stated try booting from that one
    computer.setBootAddress(fs)
  end

  local os
  -- If there is already a boot address saved use that in order to not randomly select systems if there are many
  if computer.getBootAddress() then
    os = returnOSfunction(computer.getBootAddress())
  end
  if not os then
    computer.setBootAddress(findOperatingSystems()[1])
    os = returnOSfunction(computer.getBootAddress())
  end -- If the saved OS is gone / does not exist then find a new one !
  os()
end

local function keyboardHandle(code)
  if code == 200 then -- Up Arrow
    if selectedObject.up ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.up
      selectedObject:setHighlight(true)
    end
  elseif code == 208 then -- Down Arrow
    if selectedObject.down ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.down
      selectedObject:setHighlight(true)
    end
  elseif code == 203 then
    if selectedObject.left ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.left
      selectedObject:setHighlight(true)
    end
  elseif code == 205 then
    if selectedObject.right ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.right
      selectedObject:setHighlight(true)
    end
  elseif code == 28 then -- Enter
    selectedObject.onTouch()
  end
end

local function keyboardReadString()
  local buffer = ""

  repeat
    local type, _, code = computer.pullSignal()
    local char = string.char(code)

    gpu.fill(1, 50, 160, 1, " ") -- Clear line (For use with backspace)
    if type == "key_up" and string.match(char, "[%w%p%u]") then
      buffer = buffer .. char or ""
    end

    if type == "key_up" and code == 8 then -- Backspace
      buffer = string.sub(buffer, 1, #buffer - 1)
    end

    gpu.set(1, 50, buffer)
  until code == 13


  return buffer
end

-- GUIObject Inits

-- Main Menu
GUI:new("filesystem", 24, "Filesystem Menu", backgroundColor, foregroundColor)
GUI:new("power", GUIobjects.filesystem.y + verticalMargin, "Power Down", backgroundColor, foregroundColor)
function GUIobjects.power.onTouch() computer.shutdown() end
GUI:new("internet", GUIobjects.power.y + verticalMargin, "Boot From The Internet", backgroundColor, foregroundColor)
function GUIobjects.internet.onTouch()
  local handle = internet.request(keyboardReadString())
  if not handle then
    gpu.fill(1, 50, 1, 1, " ")
    gpu.set(1, 50, "Invalid IP")
    return
  end

  local code = ""
  repeat
    local data = handle.read(999)
    code = code .. (data or "")
  until data == nil

  handle.close()

  local func = load(code, "=init")
  func()
end

-- Filesystem Menu
local yFilesystemRenderCount = 24
local operatingSystems = findOperatingSystems()
local filesystemButtons = {}

GUI:new("fsBack", yFilesystemRenderCount, "Back", backgroundColor, foregroundColor) -- This needs to be at the top as it is refrenced

for key, address in ipairs(operatingSystems) do
  local label = component.proxy(address).getLabel()

  GUI:new(label, yFilesystemRenderCount, label, backgroundColor, foregroundColor)

  GUIobjects[label].onTouch = function () boot(address) end

  local up
  if key ~= 1 then -- Component.proxy breaks if given nil
    local previousObject = GUIobjects[component.proxy(operatingSystems[key - 1]).getLabel()]
    up = previousObject
    previousObject:setAdjacentObjects(previousObject.up, GUIobjects[label]) -- This needs to be set now, because the new object started existing just now
  end

  if key == #operatingSystems then -- Connect the "back" button to the bottom fs filesystemButtons
    GUIobjects[label]:setAdjacentObjects(GUIobjects[label].up, GUIobjects.fsBack)
  end
  GUIobjects[label]:setAdjacentObjects(up)

  table.insert(filesystemButtons, GUIobjects[label])
  yFilesystemRenderCount = yFilesystemRenderCount + verticalMargin

end

table.insert(filesystemButtons, GUIobjects.fsBack)

GUIobjects.fsBack.y = yFilesystemRenderCount -- We need to re-set this so that it appears on the bottom

-- GUIObject Extra Adjacent Objects Inits
GUIobjects.filesystem:setAdjacentObjects(nil, GUIobjects.power) -- nil means that there is no adjacent object
GUIobjects.power:setAdjacentObjects(GUIobjects.filesystem, GUIobjects.internet)
GUIobjects.internet:setAdjacentObjects(GUIobjects.power)
GUIobjects.fsBack:setAdjacentObjects(GUIobjects[component.proxy(operatingSystems[#operatingSystems]).getLabel()])
-- Menu Inits
local mainMenu = MENU:new({GUIobjects.filesystem, GUIobjects.power, GUIobjects.internet}, GUIobjects.filesystem)
local filesystemMenu = MENU:new(filesystemButtons, GUIobjects.fsBack)

-- GUIObject Extra Function Inits (Used for objects that require menus)
function GUIobjects.filesystem.onTouch() filesystemMenu:render() end
function GUIobjects.fsBack.onTouch() mainMenu:render() end

local function optionsMenu()
  -- Prepare UI
  gpu.fill(1, 1, 160, 50, " ")
  mainMenu:render()

  while true do -- Keyboard Handler
    local signal, _, _, code = computer.pullSignal()
    if signal == "key_up" then
      keyboardHandle(code)
    end
  end
end

-- START CODE

gpu.setBackground(backgroundColor)
gpu.setForeground(foregroundColor)
gpu.fill(1, 1, 160, 50, " ")
gpu.set(centrizeObject("Press TAB or DEL to enter the BIOS options menu"), 24, "Press TAB or DEL to enter the BIOS options menu")
gpu.set(centrizeObject("Press anything else to boot normally"), 26, "Press anything else to boot normally")

local signal, _, _, code = computer.pullSignal(autoBootInterval)
if code == 15 or code == 211 then
  optionsMenu()
else
  boot()
end
