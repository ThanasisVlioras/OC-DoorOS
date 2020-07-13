local keyboard = {}

function keyboard.keyboardHandle(code)
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

return keyboard
