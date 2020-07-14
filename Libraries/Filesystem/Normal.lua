local handlerAPI = {}

function handlerAPI:new(proxy)
  local object = {}
  setmetatable(object, self)
  self.__index = self

  object.proxy = component.proxy(proxy)

  return object
end

function handlerAPI:open(path)
  return self.proxy.open(path)
end

function handlerAPI:read(handle)
  local buffer = ""

  repeat
    local data = self.proxy.read(handle, math.huge)
    buffer = buffer .. (data or "")
  until data == nil

  return buffer
end

function handlerAPI:close(handle)
  self.proxy.close(handle)
end

function handlerAPI:list(path)
  return self.proxy.list(path)
end

function handlerAPI:isDirectory(path)
  return self.proxy.isDirectory(path)
end

function handlerAPI:getLabel()
  return self.proxy.getLabel()
end

return handlerAPI
