package net.dzakirin.templatecrudbe.repository;

import net.dzakirin.templatecrudbe.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

}

