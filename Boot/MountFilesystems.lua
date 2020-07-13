for fs in component.list("filesystem") do
  local normalFS = doLoadFromBootFS("/Libraries/Filesystem/Normal.lua")()
  filesystem.mount(normalFS:new(fs))
end
