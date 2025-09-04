package com.app.fitfuel.service;

import com.app.fitfuel.entity.Food;
import com.app.fitfuel.entity.Meal;
import com.app.fitfuel.entity.User;
import com.app.fitfuel.repository.FoodRepository;
import com.app.fitfuel.repository.MealRepository;
import com.app.fitfuel.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class MealService {

    @Autowired
    private MealRepository mealRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FoodRepository foodRepository;

    // Add a meal directly from a foodId
    public Meal addMealFromFood(Long foodId, String mealType, Long userId) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) {
            throw new IllegalArgumentException("User not found with ID: " + userId);
        }
        User user = userOpt.get();

        Optional<Food> foodOpt = foodRepository.findById(foodId);
        if (foodOpt.isEmpty()) {
            throw new IllegalArgumentException("Food not found with ID: " + foodId);
        }
        Food food = foodOpt.get();

        Meal meal = new Meal();
        meal.setFoodName(food.getName());
        meal.setCalories(food.getCalories());
        meal.setCarbs(food.getCarbs());
        meal.setProtein(food.getProtein());
        meal.setFat(food.getFat());
        meal.setMealType(mealType);
        meal.setDate(LocalDate.now());
        meal.setUser(user);

        return mealRepository.save(meal);
    }

    // Get meals for today for a specific user
    public List<Meal> getMealsForToday(Long userId) {
        Optional<User> userOptional = userRepository.findById(userId);
        if (userOptional.isEmpty()) {
            throw new IllegalArgumentException("User not found with ID: " + userId);
        }
        User user = userOptional.get();
        return mealRepository.findByUserAndDate(user, LocalDate.now());
    }

    // Get total calories for today
    public int getTotalCaloriesForToday(Long userId) {
        List<Meal> meals = getMealsForToday(userId);
        return meals.stream().mapToInt(Meal::getCalories).sum();
    }
}