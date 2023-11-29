# top_stock_manager

Stock Management system for a small shop that runs locally, offline.

## Getting Started

This project is a local stock management system for a small business that buys and sells goods. This system will enable
them
manage the movement of goods, the flow of money and will also help them know if to restock which product.

## Software name

The name of the software is `Top Stock Manager : Offline`

## Main Features

This will be a fully fledged system that reinforce access and permissions.
These features involve data handling.

### 1. Permissions

Each action of the system will be bundled with a permission. These permissions will be preset.

### 2. Roles

Each user role will group a set of permissions. These permissions can overlap among roles.
One role will be preset and cannot be modified nor deleted, and permissions attached will not be changed.
This will generally be the role of `Manager`.

- [x] View all roles ;
- [x] View one role ;
- [x] Create a role ;
- [x] Update a role ;
- [x] Delete a role ;
- [x] Attach or detach permissions to a role ;

### 3. Users

Users will be created and roles will be attached to them. The concept is that a user must have only one role attached.
But we may evolve in the logic of one user with multiple roles.

- [x] View all users ;
- [ ] View one user ;
- [x] Create a user ;
- [x] Update a user ;
- [x] Delete a user ;
- [ ] Attach or detach role to a user ;
- [ ] Attach or detach permissions directly to a user (this is optional !) ;

### 4. Products

Products will be registered. The logic is that a product can constitute a category for other products.
E.g. `Biscuit` can be a product as well as a group of other biscuits
like `Mousa Biscuit`, `Eat-sum-more Biscuit`, `Vap Biscuit`, etc

- [x] View all products ;
- [ ] View one product ;
- [x] Create a product ;
- [x] Update a product ;
- [x] Delete a product ;

### 5. Suppliers

Suppliers will be registered. Goods that are purchased will be recorded with their suppliers

- [x] View all suppliers ;
- [ ] View one supplier ;
- [x] Create a supplier ;
- [x] Update a supplier ;
- [x] Delete a supplier ;

### 6. Clients

Clients will be registered. Goods that are sold will be recorded with their clients

- [x] View all clients ;
- [ ] View one client ;
- [x] Create a client ;
- [x] Update a client ;
- [x] Delete a client ;

### 7. Purchases

A purchase is a set of different products purchased at once, usually from the same supplier. A purchase can have no
supplier if that is not necessary

- [x] View all purchases ;
- [ ] View one purchase : Printable display ;
- [x] Create a purchase ;
- [x] Update a purchase ;
- [x] Delete a purchase ;
- [x] Add, edit and remove items to a purchase list ;

### 8. Sales

A sale is a set of different products sold at once, usually to the same client. A sale can have no client if that is not
necessary

- [x] View all sales ;
- [ ] View one sale ;
- [ ] Create a sale : en cours ;
- [ ] Update a sale : en cours ;
- [ ] Delete a sale : en cours ;

### 9. Inputs

An input is a set of many quantities of the same product purchased at once, usually many inputs done at the same time
from the same supplier will constitute a purchase.
A purchase may have only a single input, and that single input can be constituted of one item of one product.

- [ ] View all inputs ;
- [x] Create a input ;
- [x] Update a input ;
- [x] Delete a input ;

### 10. Outputs

An output is a set of many quantities of the same product sold at once, usually many outputs done at the same time to
the same client will constitute a sale.
A sale may have only a single output, and that single output can be constituted of one item of one product.

- [ ] View all outputs ;
- [ ] Create a output ;
- [ ] Update a output ;
- [ ] Delete a output ;

## Secondary Features

Apart from the main features mentioned above, other features will be included.
These are the treatment of data.

### 1. Login and Logout

Users will log in and out of the system to use it for security reason.

### 2. Dashboard

Dashboard will display daily purchases and sales of products.
It will show a list of 5 most sold products.
It will signal products that have reached critical minimum or maximum stock.

### 3. Reporting

#### 1. Sales Reporting

Sales will be reported in different ways :

- [ ] Daily reporting ;
- [ ] Weekly reporting ;
- [ ] Monthly reporting ;
- [ ] Custom date range reporting ;

#### 2. Purchases Reporting

Purchases will be reported in different ways :

- [ ] Monthly reporting ;
- [ ] Custom date range reporting ;

#### 3. Critical Stock Reporting

Critical stock level will be reported in :

- [ ] List reporting : indicating the product, the quantity level, percentage of the minimum level, better if above
  1OO% ;

## Other Features

We may include other features.

- [ ] Printing of sale's receipt ;
- [ ] Viewing level of sales done by a user fo a given period: e.g. a month ;
- [ ] System software update ;
- [ ] Developer communication with users ;
- [ ] Developer notification to user ;

## Database backup

Backup features may include database exporting and importing, as well as online syncing for backup purposes only.

## Database Modeling

![db_model.png](db_model.png)

## Technologies used

### 1. Language and Framework

- [x] Dart,
- [x] Flutter 3,

### 2. Platforms

The software will be compatible with :

- [x] Windows
- [x] Linux
- [x] MacOS

### 3. Packages

- [x] Database : [Drift](https://pub.dev/packages/drift) (sqlite3_flutter_libs)
- [x] Complex Relational queries : [RxDart](https://pub.dev/packages/rxdart)
- [x] State Management : [GetX](https://pub.dev/packages/get)
- [x] Navigation Management :  [GetX](https://pub.dev/packages/get)
- [x] Dependencies Management :  [GetX](https://pub.dev/packages/get)
- [x] Local Storage Manager : [GetStorage](https://pub.dev/packages/get_storage)
- [x] Collection for indexed map : [Collection](https://pub.dev/packages/collection)

This software is the product of [Smirltech](https://www.smirltech.com) sarl
