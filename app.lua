local lapis = require("lapis")
local respond_to
respond_to = require("lapis.application").respond_to
local json_parser = require("lunajson")
local json_params = require("lapis.application").json_params
local products = {
  {
    name = "Computer one",
    price = 1999,
    description = "Test computer description",
    category = "Computers"
  },
  {
    name = "Computer two",
    price = 2999,
    description = "Test computer description",
    category = "Computers"
  }
}
local categories = {
  {
    name = "Computers"
  },
  {
    name = "Headphones"
  },
  {
    name = "Keyboards"
  }
}
local App
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/"] = respond_to({
      GET = function(self)
        return "My shop"
      end
    }),
    ["/products"] = respond_to({
      GET = json_params(function(self)
        local json_products = json_parser.encode(products)
        return json_products
      end),
      POST = json_params(function(self)
        products[#products + 1] = {
          name = self.params.name,
          price = self.params.price,
          description = self.params.description,
          category = self.params.category
        }
        return "Product " .. json_parser.encode(products[#products]) .. " has been added"
      end)
    }),
    ["/products/:id"] = respond_to({
      GET = json_params(function(self)
        return json_parser.encode(products[tonumber(self.params.id)])
      end),
      DELETE = json_params(function(self)
        table.remove(products, tonumber(self.params.id))
        local json_products = json_parser.encode(products)
        return json_products
      end),
      PUT = json_params(function(self)
        products[self.params.id] = {
          name = self.params.name,
          price = self.params.price,
          description = self.params.description,
          category = self.params.category
        }
        return "Product " .. json_parser.encode(products[self.params.id]) .. " has been modified"
      end)
    }),
    ["/categories"] = respond_to({
      GET = json_params(function(self)
        local json_categories = json_parser.encode(categories)
        return json_categories
      end),
      POST = json_params(function(self)
        categories[#categories + 1] = {
          name = self.params.name
        }
        return "Category " .. json_parser.encode(categories[#categories]) .. " has been added"
      end)
    }),
    ["/categories/:id"] = respond_to({
      GET = json_params(function(self)
        return json_parser.encode(categories[tonumber(self.params.id)])
      end),
      DELETE = json_params(function(self)
        table.remove(categories, tonumber(self.params.id))
        local json_categories = json_parser.encode(categories)
        return json_categories
      end),
      PUT = json_params(function(self)
        categories[self.params.id] = {
          name = self.params.name
        }
        return "Category " .. json_parser.encode(categories[self.params.id]) .. " has been modified"
      end)
    })
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "App",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  App = _class_0
  return _class_0
end
