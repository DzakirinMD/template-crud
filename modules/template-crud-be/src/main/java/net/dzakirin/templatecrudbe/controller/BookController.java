package net.dzakirin.templatecrudbe.controller;

import net.dzakirin.templatecrudbe.model.Book;
import net.dzakirin.templatecrudbe.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/books")
public class BookController {
    @Autowired
    private BookRepository bookRepository;

    @PostMapping("/add")
    public ResponseEntity<Book> addBook(@RequestBody Book book) {
        return ResponseEntity.ok(bookRepository.save(book));
    }

    @GetMapping("/")
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }
}

