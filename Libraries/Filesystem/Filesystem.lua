local filesystems = {} -- Each key is a filesystem label, and each value is its handler table.
local handles = {} -- Each key is a handle and each value is its handler table
local API = {}

function API.seperatePathParts(path)
  local seperatorIndex, seperatorEndIndex = path:find("://")

  local label = path:sub(1, seperatorIndex - 1)
  local resolvedPath = path:sub(seperatorEndIndex + 1, - 1)

  return label, resolvedPath
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

local labels = {"C", "D", "E"}
local labelsIndex = 1
function API.mount(filesystemHandler)
  filesystems[labels[labelsIndex]] = filesystemHandler

  labelsIndex = labelsIndex + 1
end

return API
