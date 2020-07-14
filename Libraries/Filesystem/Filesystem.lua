local filesystems = {} -- Each key is a filesystem label, and each value is its handler table.
local handles = {} -- Each key is a handle and each value is its handler table
local API = {}

function API.seperatePathParts(path)
  local seperatorIndex, seperatorEndIndex = path:find(":/")

  local label = path:sub(1, seperatorIndex - 1)
  local resolvedPath = path:sub(seperatorEndIndex + 1, - 1)

  return label, resolvedPath
end

function API.levelUp(path)
  local label, resolvedPath = API.seperatePathParts(path)
  resolvedPath = resolvedPath:reverse() .. "/" -- When we want to return to the root directory, we need this slash for endIndex to find

  local firstSlash = resolvedPath:find("/", 1)
  local secondSlash = resolvedPath:find("/", firstSlash + 1)
  local endIndex = resolvedPath:find("/", secondSlash + 1)
  local ret = resolvedPath:sub(secondSlash + 1, endIndex)
  ret = ret:reverse()

  return label .. ":/" .. ret
end

function API.open(path)
  local label, resolvedPath = API.seperatePathParts(path)
  local handle = filesystems[label]:open(resolvedPath)

  handles[handle] = filesystems[label] -- Register the handle here, so that it can be used without the rest of the API methods needing to also specify a path

  return handle
end

function API.read(handle)
  local filesystem = handles[handle]

  return filesystem:read(handle)
end

function API.close(handle)
  local filesystem = handles[handle]

  filesystem:close(handle)
  handles[handle] = nil -- Remove the entry
end

function API.list(path)
  local label, resolvedPath = API.seperatePathParts(path)

  return filesystems[label]:list(resolvedPath)
end

function API.isDirectory(path)
  local label, resolvedPath = API.seperatePathParts(path)

  return filesystems[label]:isDirectory(resolvedPath)
end

function API.mount(filesystemHandler)
  filesystems[filesystemHandler:getLabel()] = filesystemHandler
end

return API
