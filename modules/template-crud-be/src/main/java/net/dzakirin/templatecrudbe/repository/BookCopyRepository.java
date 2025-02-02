package net.dzakirin.templatecrudbe.repository;

import net.dzakirin.templatecrudbe.model.BookCopy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookCopyRepository extends JpaRepository<BookCopy, Long> {

}
