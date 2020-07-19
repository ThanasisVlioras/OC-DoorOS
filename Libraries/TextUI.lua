function print(string)
  local x, y = 1, 1

  for i = 1, #string do
    local c = string:sub(i, i)
    if c == "\n" then
      x = 1
      y = y + 1
    else
      GPU.set(x, y, c)
      x = x + 1
    end
  end
end
