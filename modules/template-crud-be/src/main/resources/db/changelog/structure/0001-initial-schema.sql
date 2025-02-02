-- Changeset dzakirin:0001-initial-structure

-- 📌 Users Table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    address TEXT
);

-- 📌 Authors Table
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- 📌 Categories Table
CREATE TABLE categories (
    cat_id SERIAL PRIMARY KEY,
    cat_name VARCHAR(255) NOT NULL
);

-- 📌 Books Table
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    author_id INT REFERENCES authors(author_id) ON DELETE CASCADE,
    cat_id INT REFERENCES categories(cat_id) ON DELETE CASCADE,
    book_price DECIMAL(10,2) NOT NULL
);

-- 📌 Book Copies Table (Physical copies of books)
CREATE TABLE book_copies (
    copy_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id) ON DELETE CASCADE,
    status VARCHAR(20) CHECK (status IN ('Available', 'Borrowed')) DEFAULT 'Available'
);

-- 📌 Borrowing Table (Tracks which user borrowed which copy)
CREATE TABLE borrowed_books (
    borrow_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    copy_id INT REFERENCES book_copies(copy_id) ON DELETE CASCADE,
    borrow_date TIMESTAMP DEFAULT NOW(),
    due_date TIMESTAMP,  -- When should the book be returned
    return_date TIMESTAMP,
    fine_amount DECIMAL(10,2) DEFAULT 0 -- Fine imposed for overdue books
);

-- 📌 Fines Table (Tracks fines imposed for overdue books)
CREATE TABLE fines (
    fine_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    borrow_id INT REFERENCES borrowed_books(borrow_id) ON DELETE CASCADE,
    fine_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Unpaid', 'Paid')) DEFAULT 'Unpaid'
);
