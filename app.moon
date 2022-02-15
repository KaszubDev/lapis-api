lapis = require "lapis"
import respond_to from require "lapis.application"
json_parser = require "lunajson"
json_params = require("lapis.application").json_params

products = {{
    name: "Computer one",
    price: 1999,
    description: "Test computer description",
    category: "Computers"
  },
  {
    name: "Computer two",
    price: 2999,
    description: "Test computer description",
    category: "Computers"
  }
}

categories = {{
    name: "Computers"
  },
  {
    name: "Headphones"
  },
  {
    name: "Keyboards"
  }
}

class App extends lapis.Application
  "/": respond_to {
    GET: => return "My shop"
  }
  -- Get all products or add new one
  "/products": respond_to {
    GET: json_params =>
      json_products = json_parser.encode(products)
      return json_products
    POST: json_params =>
      products[#products+1]={
        name: self.params.name,
        price: self.params.price,
        description: self.params.description,
        category: self.params.category
      }
      return "Product "..json_parser.encode(products[#products]).." has been added"
  }
  -- Get / Delete / Modify product by ID
  "/products/:id": respond_to {
    GET: json_params =>
      return json_parser.encode(products[tonumber(@params.id)])
    DELETE: json_params =>
      table.remove(products,tonumber(@params.id))
      json_products=json_parser.encode(products)
      return json_products
    PUT: json_params =>
      products[@params.id]={
        name: self.params.name,
        price: self.params.price,
        description: self.params.description,
        category: self.params.category
      }
      return "Product "..json_parser.encode(products[@params.id]).." has been modified"
  }
  -- Get all categories or add new one
  "/categories": respond_to {
    GET: json_params =>
      json_categories = json_parser.encode(categories)
      return json_categories
    POST: json_params =>
      categories[#categories+1]={
        name: self.params.name
      }
      return "Category "..json_parser.encode(categories[#categories]).." has been added"
  }
  -- Get / Delete / Modify category by ID
  "/categories/:id": respond_to {
    GET: json_params =>
      return json_parser.encode(categories[tonumber(@params.id)])
    DELETE: json_params =>
      table.remove(categories,tonumber(@params.id))
      json_categories=json_parser.encode(categories)
      return json_categories
    PUT: json_params =>
      categories[@params.id]={
        name: self.params.name
      }
      return "Category "..json_parser.encode(categories[@params.id]).." has been modified"
  }