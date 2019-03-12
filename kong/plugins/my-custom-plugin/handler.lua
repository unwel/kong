local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.my-custom-plugin.access"

local RequestTransformerHandler = BasePlugin:extend()

function RequestTransformerHandler:new()
  RequestTransformerHandler.super.new(self, "my-custom-plugin")
end

function RequestTransformerHandler:access(conf)
  RequestTransformerHandler.super.access(self)
  access.execute(conf)
end

RequestTransformerHandler.PRIORITY = 801
RequestTransformerHandler.VERSION = "1.0.0"

return RequestTransformerHandler
