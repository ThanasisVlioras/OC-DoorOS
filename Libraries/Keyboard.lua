local keyboard = {}

function keyboard.keyboardGenericMenuHandle()
  local type, _, _, code = computer.pullSignal()
  if type ~= "key_up" then return end

  if code == 200 and selectedObject then -- Up Arrow
    if selectedObject.up ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.up
      selectedObject:setHighlight(true)
    end
  elseif code == 208 and selectedObject then -- Down Arrow
    if selectedObject.down ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.down
      selectedObject:setHighlight(true)
    end
  elseif code == 203 and selectedObject then
    if selectedObject.left ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.left
      selectedObject:setHighlight(true)
    end
  elseif code == 205 and selectedObject then
    if selectedObject.right ~= nil then
      selectedObject:setHighlight(false)
      selectedObject = selectedObject.right
      selectedObject:setHighlight(true)
    end
  elseif code == 28 then -- Enter
    selectedObject.onTouch()
  else -- Return the code for local use if it does not conform with the above
    return code
  end
end

return keyboard
