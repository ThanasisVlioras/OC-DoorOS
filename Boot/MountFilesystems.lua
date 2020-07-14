for fs in component.list("filesystem") do
  local normalFS = doLoadFromBootFS("/Libraries/Filesystem/Normal.lua")()
  FILESYSTEM.mount(normalFS:new(fs))
end
