# warehouse

## Table of contents
* [Introduction](#introduction)
* [Setup](#setup)
* [Usage](#usage)
* [Questions](#questions)

	
## Introduction
This is a basic implementation of warehousing software built in Ruby on Rails. This uses an SQLite database and exposes an RESTful JSON API for interacting with the warehouse. 

The features are limited but in this version, you can: 
 - Import the Inventory and Products from a file
 - View all Products and their available quantity based on articles in the warehouse
 - The ability to remove a product from the warehouse
	
## Setup
To run this app you will need Ruby [2.7.2](https://www.ruby-lang.org/en/downloads/). 

* Install dependencies

We're using [Bundler](https://bundler.io/) as a dependency manager.

```bash
gem install bundler
bundle install
```

* Migrate the database 
```bash
bundle exec rake db:create
bundle exec rake db:migrate
```

* Run Server

```bash
bundle exec rails s
```

* To Drop and Recreate the db

```bash
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
```

## Testing

To run the automated tests:

```bash
bundle exec rspec
```

## Usage

### Importing an Inventory and Products

2 [Rake](https://github.com/ruby/rake) tasks exist for this purpose. As a parameter provide a path to the file. 

#### Importing the inventory 
```bash
bundle exec rake import:inventory["lib/inventory.json"]
```
#### Importing the products

```bash
bundle exec rake import:products["lib/products.json"]
```

### API 

#### GET /products

Get all products including quantity available. 

Success response (Status code: 200)
```json
[
    {
        "id": 1,
        "name": "Dining Chair",
        "price": null,
        "created_at": "2021-01-17T14:41:38.985Z",
        "updated_at": "2021-01-17T14:41:38.985Z",
        "quantity_available": 2
    },
    {
        "id": 2,
        "name": "Dinning Table",
        "price": null,
        "created_at": "2021-01-17T14:41:39.059Z",
        "updated_at": "2021-01-17T14:41:39.059Z",
        "quantity_available": 1
    }
]
```

#### GET /products/:id

Returns a product details

Success response (Status code: 200)
```json
{
    "id": 2,
    "name": "Dinning Table",
    "price": null,
    "created_at": "2021-01-17T14:41:39.059Z",
    "updated_at": "2021-01-17T14:41:39.059Z",
    "quantity_available": 1
}
```

#### POST /products/:id/remove
Remove a product from the warehouse. Will respond with the updated product details including the new available quantity. 

Success response (Status code: 200)
```json
{
    "id": 2,
    "name": "Dinning Table",
    "price": null,
    "created_at": "2021-01-17T14:41:39.059Z",
    "updated_at": "2021-01-17T14:41:39.059Z",
    "quantity_available": 0
}
```
Bad response: no stock available (status code: 409):
```json
{
    "message": "Insufficient stock available"
}
```

## Questions 

Email me on [heinvogel@gmail.com](mailto:heinvogel@gmail.com)