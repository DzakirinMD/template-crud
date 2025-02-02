# 📖 Library Management System

## 📌 Overview
The Library Management System allows users to:

- Borrow books and track due dates.
- Return books and apply fines for late returns.
- Track borrowed books for each user.
- Calculate overdue fines before allowing future borrowing.

<br>
This system is scalable, supports multiple users and multiple book copies, and ensures only available books can be borrowed.

---------------------------------------------------------------------------------------------------

## 📋 Database Schema
The system consists of the following tables:

### 1️⃣ Users Table (`users`)
Stores library members and their details.

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    address TEXT
);
```

- 🔹 Each user has a unique user_id. 
- 🔹 Users can borrow and return books. 
- 🔹 Users cannot borrow if they have unpaid fines.

### 2️⃣ Books & Authors

#### A. Books Table (`books`)
Stores book titles, authors, and categories.

```sql
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    author_id INT REFERENCES authors(author_id),
    cat_id INT REFERENCES categories(cat_id),
    book_price DECIMAL(10,2) NOT NULL
);
```

- 🔹 Each book can have multiple copies in the library.
- 🔹 `author_id` and `cat_id` are foreign keys linking to authors and categories.

#### B. Book Copies Table (`book_copies`)
Tracks individual copies of books.

```sql
CREATE TABLE book_copies (
    copy_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id),
    status VARCHAR(20) CHECK (status IN ('Available', 'Borrowed')) DEFAULT 'Available'
);
```

- 🔹 Each physical copy of a book has a unique `copy_id`.
- 🔹 `status` can be:
  - `'Available'` → Ready to be borrowed.
  - `'Borrowed'` → Currently taken by a user.

### 3️⃣ Borrowing Table (`borrowed_books`)
Manages who borrowed which book copy and for how long.

```sql
CREATE TABLE borrowed_books (
    borrow_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    copy_id INT REFERENCES book_copies(copy_id),
    borrow_date TIMESTAMP DEFAULT NOW(),
    due_date TIMESTAMP,  -- When should the book be returned
    return_date TIMESTAMP,
    fine_amount DECIMAL(10,2) DEFAULT 0 -- Fine imposed for overdue books
);
```

- 🔹 Users borrow book copies (`copy_id`).
- 🔹 `due_date` is automatically set to 14 days from `borrow_date`.
- 🔹 If `return_date > due_date`, a fine is applied.

### 4️⃣ Fines Table (`fines`)
Tracks overdue book fines for users.

```sql
CREATE TABLE fines (
    fine_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    borrow_id INT REFERENCES borrowed_books(borrow_id),
    fine_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Unpaid', 'Paid')) DEFAULT 'Unpaid'
);
```

- 🔹 If a book is returned late, a fine is calculated.
- 🔹 The user must pay the fine before borrowing again.


Awesome! 🚀 Below is the Spring Boot API structure for managing the Library Management System based on our refactored schema.

## 📌 Spring Boot Implementation Plan

1. User Management (Register, Get Users)
2. Book Management (Add Books, Get Books, Get Book Copies)
3. Borrowing Management (Borrow a Book, Return a Book)
4. Fines Management (View and Pay Fines)

### 📦 Tech Stack
✅ Spring Boot <br>
✅ Spring Data JPA <br>
✅ PostgreSQL <br>
✅ Lombok (for clean models) <br>
✅ Spring Validation <br>
✅ RESTful API with OpenAPI (Swagger) <br>

## Project Structure
📂 library-management
┣ 📂 src/main/java/com/example/library
┃ ┣ 📂 controller        # Handles API requests
┃ ┣ 📂 service           # Business logic
┃ ┣ 📂 repository        # JPA Repositories (Spring Data)
┃ ┣ 📂 entity            # JPA Entities (Mapped to DB tables)
┃ ┣ 📂 dto               # Data Transfer Objects (DTOs)
┃ ┗ 📂 config            # App configuration (Swagger, Database)
┣ 📂 src/main/resources
┃ ┗ 📜 application.yml   # Database Configurations
┣ 📜 pom.xml             # Dependencies
┗ 📜 README.md

## Swagger
http://localhost:10000/swagger-ui.html

## Further enhancement
- restructure back the project structure to follow controller/service/repo 
- add Spring Security with JWT Token
- implement the FE using NextJS
