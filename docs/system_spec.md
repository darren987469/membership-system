## Use cases

* A user can register as a normal user
* A user can browse products on this website
* A user can choose to purchase premium membership(can skip payment)
* A premium member can see products with discount prices
* A user can be set as admin
* An admin can create/edit products on this website
* A product would have product price/name/image(s)

### A user can register as a normal user

Every user register successfully is a normal user. A normal user can choose to upgrade to premium user, or be promoted to admin user by owner user (owner of the website/system).

### A user can browse products on this website

A normal user can see product name, price and images.

### A user can choose to purchase premium membership(can skip payment)

The use case is not clear. Does the purchase flow contain credit card input? Is it one time purchase or a subscription? Maybe it needs to store some information of the transaction. Before knowing more information, I choose just update user membership (from normal to premium) and leave the decision to make later.

### A premium member can see products with discount prices

Premium users can not only see product name, price, images, but also discount for them.

### A user can be set as admin

A user can be promoted by owner user. There is a admin page let owner user to do this.
Path: `/admin/users`.

### An admin can create/edit products on this website

Admin users and owner user can create/edit product information, such as name, price, images.
They can do it at `/admin/products`.

### A product would have product price/name/image(s)

In summary, there are four page for current use cases:

* `/sign_in`: user sign up, sign in
* `/products`: user browse products
* `/admin/users`: owner user manage users in website
* `/admin/products`: owner/admin user can create/edit products

## Database Schema

![](../images/Membership-system.png)

https://drive.google.com/file/d/1XtaacOhq8YCGmspAws1bZUJ0pyR_Kdyv/view?usp=sharing

### User roles and permissions

There are four roles of user: `normal`, `premium`, `admin`, `owner`.

Role | normal | premium | admin | owner
-----|--------|---------|-------|------
view Product | V | V | V | V
Product discount | X | V | V | V
enter admin pages | X | X | V | V
create/edit Product | X | X | V | V
promote admin | X | X | X | V

### 開發方式

1. 分析 use cases ，先確認需求是否明確清楚，如有模糊的地方則提出來確認
1. 解決方案分析或調查。確認需求後，有很多方法可以完成，分析其中的利弊，選擇適合的解決方法。如有不熟悉的技術也需先行調查，看看是否可以滿足需求。
1. 分工，依據手上的資源(如前端後端人力，技術成熟度)來細分工作，開成 issues 方便管理及追蹤。Issue 上有 use case (需求), 建議解決方法，system spec (比如說前後端溝通的 API，routes)。
1. 開發及測試，領取 issue 並著手進行。程式碼需有 test case，風格也須符合工具的規範。完成後開 PR 過 CI 及 review。
1. 部署到 `staging` 伺服器，進行最後測試準備上線。

本專案有採用 Rails 全端(Rails controller/Rails page)及前後端分離(Grape API/React page)的開發方式，旨在呈現靈活應用各種開發方式來完成專案需求。

原本有想要將 product image direct upload 的部分也做成前後端分離，但目前仍有一個未解的 [issue on ActiveStorage](https://github.com/rails/rails/issues/32208) ，會有 `CSRF` 問題，暫時保留原本的做法。

### Codebase style guide

#### Backend

We separate business logic to many abstraction layers: `authentication`, `validation`, `authorization`, `operation`, and `presentation`. Each layer has it responsibility:

* Authentication: Authenticate user.
* Validation: Validation request parameters whether fulfill the requirement.
* Authorization: Validate user authorization to do the operation (read/create/update/delete resource). They are defined in `app/policies` directory.
* Operation: Prepare the data (CRUD to resources).
* Presentation: Transform data format. They are defined in `app/apis/entity` directory.

For detailed explanation, please see the article [API style](https://darren987469.github.io/API-style/).

#### Frontend

Use react as UI framework. Components are defined in `app/assets/javascripts/components`. There are two types of components: `container` and `presenter`.

* Container: Hold all the data and API request (like controller in Rails). Naming convention: `XXX_container.jsx`. They are react components.
* Presenter: Present data from the container. Usually, they are stateless functional components.
