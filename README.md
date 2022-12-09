## Overview
The Coffee-Shop platform for all of the order management, API´s and sites that will be built on.


## Quickstart
Visit the code base and bundle

    cd coffee-shop-challenge
    bundle install

Setting up `database.yml` based on your needs. (Use the default settings if you're not sure what to change)

    cp config/database.yml.sample config/database.yml

### Using `.env` file

[dotenv](https://github.com/bkeepers/dotenv "dotenv") loads environment variables on an application-basis. Follow the instructions to use it

1. Create a new `.env` file based on `dotenv.sample`

        cp .env.sample .env

2. Value for `DEVISE_SECRET_KEY` can be obtained by running (Optional)

        rake secret

3. Ask the project administrator for the other env values. (If applicable)

	Create the database and run migrate

	    rake db:create
	    rake db:migrate
	    rake db:seed


## Testing
You have to prepare the test database before running tests.

# Branching

* `master` is the active development branch

All local development should be done in the appropriately named branches:

* `feature_<branch_name>` for substantial new features or functions, create it from dev
* `hotfixes_<branch_name>` for bug fixes (If any issue happen in production `master` branch)
* `production_<yyymmdd>_<version>` After deploy make a branchforit 


# Postman APIs Documents

Get All Products
 
 GET: `{URL}/user/products`

 * Response

 `{
    "response_status": {
        "response_code": 200,
        "response_type": "success"
    },
    "response_data": [
        {
            "product": {
                "id": 1,
                "title": "Brisket",
                "description": "Brisket",
                "category_id": 3,
                "status": 1,
                "created_at": "2022-12-06T19:51:09.835Z",
                "updated_at": "2022-12-06T19:51:09.835Z",
                "price": null,
                "aval_week": [
                    "0",
                    "2",
                    "3",
                    "5"
                ],
                "row_order": 1
            },
            "product_item": [
                {
                    "id": 1,
                    "product_id": 1,
                    "price": 20.0,
                    "qty_type": "lbs",
                    "created_at": "2022-12-06T19:51:09.840Z",
                    "updated_at": "2022-12-06T19:51:09.840Z"
                }
            ]
        }]
  }`

Get All Categories
 
 GET: `{URL}/user/categories`

  * Response
  `{
    "response_status": {
        "response_code": 200,
        "response_type": "success"
    },
    "response_data": [
        {
            "id": 3,
            "title": "Meat by Weight",
            "description": "Meat by Weight",
            "sub_category_id": 1,
            "status": 1,
            "created_at": "2022-12-06T19:51:09.721Z",
            "updated_at": "2022-12-06T19:51:09.721Z",
            "row_order": null
        }
      ]
   }`



Add to Cart Item
 
 POST: `{URL}/user/pre_order/add_cart`

 * Body Json Params
 `{
 	"products": {
    "id":1,
    "product_item_id":1,
    "quantity":1,
    "sub_category_id":"1"
    }
  }`

 * Response

 `{
    "response_status": {
        "response_code": 200,
        "response_type": "success",
        "message": "Item has been successfully added to your cart"
    },
    "response_data": {
        "data": {
            "id": 1,
            "product_item_id": 1,
            "quantity": 1,
            "sub_category_id": "1",
            "session_id": "4f9cgya0",
            "total": 20.0
        },
        "count": 1,
        "grand_total": 20.0,
        "grand_total_tax": 2.8000000000000003,
        "grand_total_wtax": 22.8,
        "update": true
    }
}`