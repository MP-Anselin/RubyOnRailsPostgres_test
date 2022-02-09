# Task description

The project is a job search solution where users can apply for jobs. The application contains
the following features and functions:

1. User registration
   a. Email (unique)
   b. Password
2. User authentication
3. Job creation
   a. Title
   b. Salary per hour
   c. Spoken languages (minimum 1 and no maximum)
   d. Shift dates (minimum 1 and maximum 7)
   i. Note: “Shift” is one period of work on a Job
4. Jobs list
   a. Show the following job attributes
   i. Title
   ii. Salary per hour * Total shifts hours
   iii. Spoken languages
   b. Can be searched by Title
   c. Can be searched by spoken languages
5. A user applies for a job (item 3)
   a. Need to be logged in (item 2)
   b. User isn’t allowed to apply for the same job twice

# Requirements

```
❏ Rails (latest)
❏ Tests (unit, controllers)
❏ Postgres
❏ SOLID principles
```
# Optional

```
❏ Open API 3 (http://spec.openapis.org/oas/v3.0.3)
❏ Rails Event Store (https://github.com/RailsEventStore/rails_event_store)
❏ Implement cache when necessary
❏ API Documentation
❏ Pagination
```

