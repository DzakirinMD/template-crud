-- Changeset dzakirin:0001-data

-- 📌 Insert Users
INSERT INTO users (name, email, password, mobile, address) VALUES
('Alice Johnson', 'alice@gmail.com', 'password123', '1123456789', '123 Main Street, KL'),
('Bob Smith', 'bob@gmail.com', 'securepass456', '1139876543', '456 Park Avenue, Selangor');

-- 📌 Insert Authors
INSERT INTO authors (author_name) VALUES
('J.K. Rowling'),
('Frank Herbert');

-- 📌 Insert Categories
INSERT INTO categories (cat_name) VALUES
('Fantasy'),
('Science Fiction');

-- 📌 Insert Books
INSERT INTO books (book_name, author_id, cat_id, book_price) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 1, 59.99),
('Dune', 2, 2, 45.50);

-- 📌 Insert Book Copies
INSERT INTO book_copies (book_id, status) VALUES
(1, 'Available'),
(1, 'Available'),
(2, 'Borrowed');

-- 📌 Insert Borrowing Records
INSERT INTO borrowed_books (user_id, copy_id, borrow_date, due_date, return_date, fine_amount) VALUES
(1, 3, '2024-02-01 10:00:00', '2024-02-15 10:00:00', NULL, 0); -- Alice borrowed a book

-- 📌 Insert Reservations
INSERT INTO reservations (user_id, copy_id, reservation_date, status) VALUES
(2, 3, '2024-02-02 12:00:00', 'Pending'); -- Bob reserved a borrowed book

-- 📌 Insert Fines (If overdue)
INSERT INTO fines (user_id, borrow_id, fine_amount, status) VALUES
(1, 1, 5.00, 'Unpaid'); -- Alice has a fine
