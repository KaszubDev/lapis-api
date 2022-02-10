local lapis = require("lapis")
local app = lapis.Application()

app:get("index", "/", function(self)
  return "Hello Lua Lapis API"
end)

app:get("/user/:name", function(self)
  return "Welcome to " .. self.params.name .. "'s profile"
end)

app:get("/test.json", function(self)
  return { json = { status = "ok" } }
end)

return app