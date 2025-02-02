-- Changeset dzakirin:0001-initial-structure

-- Create `users` table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    mobile BIGINT NOT NULL UNIQUE,
    address TEXT NOT NULL
);

-- Create `authors` table
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- Create `categories` table
CREATE TABLE categories (
    cat_id SERIAL PRIMARY KEY,
    cat_name VARCHAR(255) NOT NULL
);

-- Create `books` table (Stores book titles, not physical copies)
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    cat_id INT NOT NULL,
    book_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id) ON DELETE CASCADE
);

-- Create `book_copies` table (Represents physical copies of books)
CREATE TABLE book_copies (
    copy_id SERIAL PRIMARY KEY,
    book_id INT NOT NULL,
    status VARCHAR(50) DEFAULT 'Available',  -- Available, Borrowed, Lost, etc.
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- Create `borrowed_books` (Tracks borrowing of book copies)
CREATE TABLE borrowed_books (
    borrow_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    copy_id INT NOT NULL,
    borrow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    return_date TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (copy_id) REFERENCES book_copies(copy_id) ON DELETE CASCADE,
    CONSTRAINT unique_borrow UNIQUE (user_id, copy_id, borrow_date)
);
