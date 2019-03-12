local multipart = require "multipart"
local cjson = require "cjson.safe"


local ngx = ngx
local kong = kong
local next = next
local type = type
local find = string.find
local upper = string.upper
local lower = string.lower
local pairs = pairs
local insert = table.insert
local noop = function() end


local _M = {}


local function iter(config_array)
  if type(config_array) ~= "table" then
    return noop
  end

  return function(config_array, i)
    i = i + 1

    local current_pair = config_array[i]
    if current_pair == nil then -- n + 1
      return nil
    end

    local current_name, current_value = current_pair:match("^([^:]+):*(.-)$")
    if current_value == "" then
      current_value = nil
    end

    return i, current_name, current_value
  end, config_array, 0
end


local function transform_headers(conf)
  local clear_header = kong.service.request.clear_header

  local rewrite  = 0 < #conf.rewrite.headers

  if not rewrite then 
    return
  end

  local rewrite

  local headers = kong.request.get_headers()
  --headers.host = nil


  if rewrite then
    for _, name, _ in iter(conf.rewrite.headers) do
      if headers[name] ~= nil then
        headers["Host"] = headers[name]
        headers[name] = nil
        clear_header(name)

        if not rewrite then
          rewrite = true
        end
      end
    end
  end

  if rewrite then
    kong.service.request.set_headers(headers)
  end
end

function _M.execute(conf)
  transform_headers(conf)
end

return _M
