-- Changeset dzakirin:0001-data

-- Insert Data into `users`
INSERT INTO users (name, email, password, mobile, address) VALUES
('Alice Johnson', 'alice@gmail.com', 'password123', 1123456789, '123 Main Street, KL'),
('Bob Smith', 'bob@gmail.com', 'securepass456', 1139876543, '456 Park Avenue, Selangor'),
('Charlie Brown', 'charlie@gmail.com', 'charliepass789', 1145678910, '789 Green Road, Johor');

-- Insert Data into `authors`
INSERT INTO authors (author_name) VALUES
('J.K. Rowling'),
('Frank Herbert'),
('George Orwell'),
('J.R.R. Tolkien');

-- Insert Data into `categories`
INSERT INTO categories (cat_name) VALUES
('Fantasy'),
('Science Fiction'),
('Dystopian'),
('Adventure');

-- Insert Data into `books` (Book Titles)
INSERT INTO books (book_name, author_id, cat_id, book_price) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 1, 59.99),  -- FIXED escaping issue
('Dune', 2, 2, 45.50),
('1984', 3, 3, 35.00),
('The Lord of the Rings', 4, 4, 89.99);

-- Insert Data into `book_copies` (Physical Copies of Books)
INSERT INTO book_copies (book_id, status) VALUES
(1, 'Available'),
(1, 'Available'),
(1, 'Borrowed'),
(2, 'Available'),
(2, 'Borrowed'),
(3, 'Available'),
(4, 'Available');

-- Insert Data into `borrowed_books` (Tracking Who Borrowed Which Copy)
INSERT INTO borrowed_books (user_id, copy_id, borrow_date, return_date) VALUES
(1, 3, '2024-02-01 10:00:00', NULL),
(2, 5, '2024-02-02 15:30:00', NULL);
