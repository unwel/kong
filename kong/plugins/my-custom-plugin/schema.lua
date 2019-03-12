local typedefs = require "kong.db.schema.typedefs"


local strings_array = {
  type = "array",
  default = {},
  elements = { type = "string" },
}


local strings_array_record = {
  type = "record",
  fields = {
    { headers = strings_array },
  },
}


local colon_strings_array = {
  type = "array",
  default = {},
  elements = { type = "string", match = "^[^:]+:.*$" },
}


local colon_strings_array_record = {
  type = "record",
  fields = {
    { headers = colon_strings_array },
  },
}


return {
  name = "my-custom-plugin",
  fields = {
    { run_on = typedefs.run_on_first },
    { config = {
        type = "record",
        fields = {
--          { http_method = typedefs.http_method },
          { rewrite  = strings_array_record },
--          { remove  = strings_array_record },
--          { rename  = colon_strings_array_record },
--          { replace = colon_strings_array_record },
--          { add     = colon_strings_array_record },
--          { append  = colon_strings_array_record },
--          { rewrite = colon_strings_array_record },
        }
      },
    },
  }
}
