local MENU = {}

function MENU:new(objects, mainObject)
  local object = {}

  setmetatable(object, self)
  self.__index = self

  object.attached = objects
  object.mainObject = mainObject
  return object
end

local function centrizeObject(fx) -- Gives the proper x value that puts the object's center through the screen's center
  return 80 - (fx / 2)
end

function MENU:tileArrange()
  local toArrange = self.attached

  -- Calculate Row
  local inRow = {}
  local fx = 0
  repeat
    local object = toArrange[1] -- We just need to index [1] because table.remove puts all the values there
    if not object then break end -- If there are no more objects then break the loop

    inRow[#inRow + 1] = object
    table.remove(toArrange, 1)

    fx = fx + inRow[#inRow].fx

    -- Calculate Margins (Work In Progress)
    if #inRow % 2 then
      fx = fx + (#inRow / 2 + 1) * 0
    else
      fx = fx + math.ceil(#inRow / 2) * 0
    end
  until fx >= 160

  if fx > 160 then -- Remove any extra items and keep as many as you can in the row, not requiring to fill all the 160 though
    repeat
      table.remove(inRow, #inRow)
    until fx <= 160
  end

  -- Arrange Row

  local x = centrizeObject(fx)
  for _, object in ipairs(inRow) do
    object.x = x
    object:render()

    x = x + object.fx + 3
  end

  selectedObject = self.mainObject
  selectedObject:setHighlight(true)
end

function MENU:render(bool)
  GUI:unRenderAll()

  if bool then self:tileArrange() return end

  for _, object in pairs(self.attached) do
    object:render()
  end

  selectedObject = self.mainObject
  selectedObject:setHighlight(true)
end

return MENU
