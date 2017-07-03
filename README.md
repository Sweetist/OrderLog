# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Walkthrough:

- There's a page for each table: deliveries, orders, bakeries, and recipients. Each page displays all the data in the relevant table, as well as a form to create a new row. Currently, no fields are required so you can make an empty row.

- There are edit and delete buttons at the end of each row. 

- On the form, the "update" button is essentially upsert. It distinguishes between create and update based on the value in the id field, so that's read only on the edit page. 

- The "clear" button is self explanatory.

- The "find" button directs the user to the edit page for the first result that matches the value in the "name" field (for bakeries and recipients).

- There is a page called "unified" that shows all the data together (with options to show/hide columns and rows). It also has all the forms as well. This way, you can create everything at once or link to a preexisting recipient/bakery. You have to press "update"/"find" for each form individually.

- Also note that a row will only show on the "unified" data table when it is linked to a delivery. So a order, delivery, or recipient that doesn't have any deliveries will not show up on the table.

- The root is set to the page with the all the data on it. Since login is required and I didn't make another landing page, on first visit, it will redirect you to the login page.

https://rocky-coast-74448.herokuapp.com/
https://github.com/ivlin/OrderLog
