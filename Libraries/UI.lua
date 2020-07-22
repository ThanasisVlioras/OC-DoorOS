local GUI = {}
local GUIobjects = {}
UIoptions = doLoadFromBootFS("/Options/UI")

function GUI.centrizeObject(fx) -- Gives the proper x value that puts the object's center through the screen's center
  return 80 - (fx / 2)
end

function GUI:new(name, y, text, rectColor, textColor)
  local object = {}
  setmetatable(object, self)
  self.__index = self

  object.x = GUI.centrizeObject(#text)
  object.y = y
  object.text = text
  object.fx = #object.text + UIoptions.horizontalPadding
  object.rectColor = rectColor
  object.textColor = textColor
  GUIobjects[name] = object

  return object
end

function GUI:render()
  GPU.setBackground(self.rectColor)
  GPU.setForeground(self.textColor)

  GPU.fill(self.x, self.y, self.fx, UIoptions.verticalPadding, " ")

  local yTextCentrized = self.y + math.floor(UIoptions.verticalPadding / 2)
  GPU.set(self.x + UIoptions.horizontalPadding / 2, yTextCentrized, self.text)
end

function GUI:unRender()
  GPU.setBackground(0x097A2D)
  GPU.fill(self.x, self.y, self.fx, 3, " ")
end

function GUI:setAdjacentObjects(up, down, left, right)
  if up then self.up = up end -- Do not accidentally set the others to nil if you try to change a single option
  if down then self.down = down end
  if left then self.left = left end
  if right then self.right = right end
end

function GUI:connect(up, down, left, right)
  if up then
    self.up = up
    up.down = self
  end

  if down then
    self.down = down
    down.up = self
  end

  if left then
    self.left = left
    left.right = self
  end

  if right then
    self.right = right
    right.left = self
  end
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

function GUI:clearScreen()
  GPU.setBackground(UIoptions.backgroundColor)
  GPU.setForeground(UIoptions.foregroundColor)
  GPU.fill(1, 1, 160, 50, " ")
end

return GUI
