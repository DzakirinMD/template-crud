package net.dzakirin.templatecrudbe.repository;

import net.dzakirin.templatecrudbe.model.BorrowedBook;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BorrowedBookRepository extends JpaRepository<BorrowedBook, Long> {

}

