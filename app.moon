lapis = require "lapis"
import respond_to from require "lapis.application"
json_parser = require "lunajson"

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
  "/products": respond_to {
    GET: =>
      json_products = json_parser.encode(products)
      json_products

    POST: =>
      " test"
  }
  "/categories": respond_to {
    GET: =>
      json_categories = json_parser.encode(categories)
      return json_categories
  }