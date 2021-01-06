# README

# SIMPLE CART APP
This project only contains API only.

**How to run :
1. Make sure you have install elasticsearch in your local machine and ruby 2.7.1
2. checkout project from github : https://github.com/syafik/my-simple-cart/tree/master
3. bundle install
4. rake db:create
5. rake db:migrate
6. rake db:seed
7. run elasticsearch in your local machine
8. rails s

**API path and sample how to call**

1. Registration.
  POST /api/v1/auth.
  Host: localhost:3000.
  Content-Type: application/json.
  { 
      "email": "your@email.com",
      "password": "yourpassword123",
      "passwrod_confirmation": "yourpassword123",
      "name": "Your Name"
  }

2. Login.
    POST /api/v1/auth/sign_in.
    Host: localhost:3000.
    Content-Type: application/json.
    {
        "email": "your@email.com",
        "password": "yourpassword123"
    }.

    ** From Registration and Login API we will have response headers that we will use to define user session in 
    each API request that required login user.
    1. access-token
    2. client
    3. token-type
    4. expiry
    5. uid

3. API for listing products.
   GET /api/v1/products.
   Host: localhost:3000.
   * for search by name of product: 
     GET /api/v1/products?q=shirt
   * for filter by store : 
     GET /api/v1/products?store_id=1

4. API for adding to cart
    POST /api/v1/carts/add/:product_variant_id
    Host: localhost:3000
    access-token: access_token_mu
    token-type: Bearer
    client: client_mu
    expiry: 1611053732
    uid: uid_mu
    Content-Type: application/json

    {
        "cart": {
            "quantity": 1,
            "notes": "test notes"
        }
    }

5. API for listing user cart
   GET /api/v1/carts
   Host: localhost:3000
   access-token: access_token_mu
   token-type: Bearer
   client: client_mu
   expiry: 1611053732
   uid: uid_mu

6. API for modifying cart
  PUT /api/v1/carts/item/updates/:cart_item_id
  Host: localhost:3000
  access-token: access_token_mu
  token-type: Bearer
  client: client_mu
  expiry: 1611053732
  uid: uid_mu
  Content-Type: application/json

  {
      "cart": {
          "quantity": 1,
          "notes": "hayang jago"
      }
  }

7. API for removing cart
  DELETE /api/v1/carts/item/delete/:cart_item_id
  Host: localhost:3000
  access-token: access_token_mu
  token-type: Bearer
  client: client_mu
  expiry: 1611053732
  uid: uid_mu
  Content-Type: application/json

8. API for checkout
  POST /api/v1/orders/checkout
  Host: localhost:3000
  access-token: access_token_mu
  token-type: Bearer
  client: client_mu
  expiry: 1611053732
  uid: uid_mu
  Content-Type: application/json

  {
    "checkout":[
        {
          "store_id": 1, 
          "items": [
              {"product_variant_id": 15, "quantity": 1, "notes": "test order"}
          ], 
          "courier": {"id": 1, "price": 10000}
        }
      ]
  } 

9 API for listing order
  GET /api/v1/orders 
  Host: localhost:3000
  access-token: access_token_mu
  token-type: Bearer
  client: client_mu
  expiry: 1611053732
  uid: uid_mu

** Running RSPEC Unit Test
bundle exec rspec -f d  spec/models/