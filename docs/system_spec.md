## Use cases

* A user can register as a normal user
* A user can browse products on this website
* A user can choose to purchase premium membership(can skip payment)
* A premium member can see products with discount prices
* A user can be set as admin
* An admin can create/edit products on this website
* A product would have product price/name/image(s)

### A user can register as a normal user

Every user register successfully is a normal user. A user can choose to upgrade to premium user, or be promoted to admin user by owner user (owner of the website/system).

### A user can browse products on this website

A normal user can see product name, price and images.

### A user can choose to purchase premium membership(can skip payment)

The use case is not clear. Does the purchase flow contain credit card input? Is it one time purchase or a subscription? Maybe need to store some information of transaction. Before knowing more information, I choose just update user membership (from normal to premium) and leave the decision to make later.

### A premium member can see products with discount prices

Premium users can not only see product name, price, images, but also discount for them.

### A user can be set as admin

A user can be promoted by owner user. There is a admin page let owner user to do this.
Path: `/admin/users`.

### An admin can create/edit products on this website

Admin users and owner user can create/edit product information, such as name, price, images.
They can do it at `/admin/products`

### A product would have product price/name/image(s)

In summary, there are four page for current use cases:

* `/sign_in`: user sign up, sign in
* `/products`: user browse products
* `/admin/users`: owner user manage users in website
* `/admin/products`: user create/edit products

## Database Schema

![](../images/Membership-system.png)

https://drive.google.com/file/d/1XtaacOhq8YCGmspAws1bZUJ0pyR_Kdyv/view?usp=sharing

### User

There are four roles of user: `normal`, `premium`, `admin`, `owner`.

Role | normal | premium | admin | owner
-----|--------|---------|-------|------
view Product | V | V | V | V
Product discount | X | V | V | V
create/edit Product | X | V | V | V
enter admin pages | X | X | V | V
promote admin | X | X | X | V
