package net.dzakirin.templatecrudbe.controller;

import net.dzakirin.templatecrudbe.model.BookCopy;
import net.dzakirin.templatecrudbe.model.BorrowedBook;
import net.dzakirin.templatecrudbe.model.Fine;
import net.dzakirin.templatecrudbe.model.User;
import net.dzakirin.templatecrudbe.repository.BookCopyRepository;
import net.dzakirin.templatecrudbe.repository.BorrowedBookRepository;
import net.dzakirin.templatecrudbe.repository.FineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/borrow")
public class BorrowController {

    @Autowired
    private BorrowedBookRepository borrowRepo;

    @Autowired
    private BookCopyRepository copyRepo;

    @Autowired
    private FineRepository fineRepo;

    @PostMapping("/{userId}/{copyId}")
    public ResponseEntity<?> borrowBook(@PathVariable Long userId, @PathVariable Long copyId) {
        BookCopy copy = copyRepo.findById(copyId).orElseThrow(() -> new RuntimeException("Copy Not Found"));
        if (!copy.getStatus().equals("Available")) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Book is already borrowed");
        }

        User user = User.builder()
                .userId(userId)
                .build();

        BorrowedBook borrowedBook = new BorrowedBook();
        borrowedBook.setUser(user);
        borrowedBook.setBookCopy(copy);
        borrowedBook.setBorrowDate(LocalDate.now().toString());
        borrowedBook.setDueDate(LocalDate.now().plusDays(14).toString()); // 2 Weeks Due

        copy.setStatus("Borrowed");
        copyRepo.save(copy);
        borrowRepo.save(borrowedBook);
        return ResponseEntity.ok("Book borrowed successfully");
    }

    @PutMapping("/return/{borrowId}")
    public ResponseEntity<?> returnBook(@PathVariable Long borrowId) {
        BorrowedBook borrowed = borrowRepo.findById(borrowId).orElseThrow();
        borrowed.setReturnDate(LocalDate.now().toString());

        // Check for overdue fine
        if (LocalDate.now().isAfter(LocalDate.parse(borrowed.getDueDate()))) {
            Double fineAmount = 10.00; // Fixed Fine
            Fine fine = new Fine(null, borrowed.getUser(), borrowed, fineAmount, "Unpaid");
            fineRepo.save(fine);
        }

        borrowRepo.save(borrowed);
        return ResponseEntity.ok("Book returned");
    }
}

