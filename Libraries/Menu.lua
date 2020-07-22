local MENU = {}

function MENU:new(objects, mainObject)
  local object = {}

  setmetatable(object, self)
  self.__index = self

  object.attached = objects
  object.mainObject = mainObject
  return object
end

function MENU:tileArrange()
  local toArrange = self.attached
  local tiles = {}
  local currentRow = 1

  repeat
    tiles[currentRow] = {}
    -- Calculate Row

    local fx = 0
    repeat
      local object = toArrange[1] -- We just need to index [1] because table.remove puts all the values there
      if not object then break end -- If there are no more objects then break the loop

      tiles[currentRow][#tiles[currentRow] + 1] = object
      table.remove(toArrange, 1)

      fx = fx + tiles[currentRow][#tiles[currentRow]].fx + 3
    until fx >= 160

    fx = fx - 3 -- Remove margin of last item as nothing follows it
    if fx > 160 then -- Remove any extra items and keep as many as you can in the row, not requiring to fill all the 160 though
      repeat
        fx = fx - tiles[currentRow][#tiles[currentRow]].fx

        table.insert(self.attached, tiles[currentRow][#tiles[currentRow]]) -- We need this object back here for rendering on the next row
        table.remove(tiles[currentRow], #tiles[currentRow])
      until fx <= 160
    end

    -- Arrange Row

    local x = GUI.centrizeObject(fx)
    for key, object in ipairs(tiles[currentRow]) do
      object.x = x
      object.y = currentRow * 3
      object:render()

      object:connect(nil, nil, tiles[currentRow][key - 1])

      if tiles[currentRow - 1] then -- If the previous row exists
        object:connect(tiles[currentRow - 1][key])
      end

      x = x + object.fx + 3
    end

    selectedObject = self.mainObject
    selectedObject:setHighlight(true)

    currentRow = currentRow + 1
  until #self.attached == 0
end

function MENU:render(bool)
  GUI:clearScreen()

  if bool then self:tileArrange() return end

  for _, object in pairs(self.attached) do
    object:render()
  end

  selectedObject = self.mainObject
  selectedObject:setHighlight(true)
end

return MENU
