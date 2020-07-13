local GUI = {}
local GUIobjects = {}

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
  object.fx = #object.text
  object.rectColor = rectColor
  object.textColor = textColor
  GUIobjects[name] = object
end

function GUI:render()
  gpu.setBackground(self.rectColor)
  gpu.setForeground(self.textColor)

  gpu.fill(self.x, self.y, self.fx, 3, " ")

  local yTextCentrized = self.y + math.floor(3 / 2)
  gpu.set(self.x + 0, yTextCentrized, self.text)
end

function GUI:unRender()
  gpu.setBackground(0x097A2D)
  gpu.fill(self.x, self.y, self.fx, 3, " ")
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
    self.rectColor = 0xC4FFAD
    self.textColor = 0x097A2D
  else
    self.rectColor = 0x097A2D
    self.textColor = 0xC4FFAD
  end

  self:render()
end

function GUI:returnGUIobjects()
  return GUIobjects
end

return GUI
