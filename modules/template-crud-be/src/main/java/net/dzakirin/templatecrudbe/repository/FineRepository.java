package net.dzakirin.templatecrudbe.repository;

import net.dzakirin.templatecrudbe.model.Fine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface FineRepository extends JpaRepository<Fine, Long> {
    List<Fine> findByUserUserIdAndStatus(Long userId, String status);
}
