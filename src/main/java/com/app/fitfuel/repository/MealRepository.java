package com.app.fitfuel.repository;

import com.app.fitfuel.entity.Meal;
import com.app.fitfuel.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface MealRepository extends JpaRepository<Meal, Long> {
    List<Meal> findByUserAndDate(User user, LocalDate date);


}