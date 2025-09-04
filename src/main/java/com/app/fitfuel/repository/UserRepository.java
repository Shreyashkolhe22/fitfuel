package com.app.fitfuel.repository;

import com.app.fitfuel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email); // For login
    User findByEmailAndPassword(String email, String password);

}