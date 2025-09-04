package com.app.fitfuel.service;

import com.app.fitfuel.entity.Food;
import com.app.fitfuel.repository.FoodRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FoodService {

    private final FoodRepository foodRepository;

    public FoodService(FoodRepository foodRepository) {
        this.foodRepository = foodRepository;
    }

    public List<Food> searchFoodsByName(String name) {
        return foodRepository.findByNameContainingIgnoreCase(name);
    }

    public List<Food> getAllFoods() {
        return foodRepository.findAll();
    }

    public Food saveFood(Food food) {
        // Basic validation
        if (food.getName() == null || food.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Food name cannot be empty");
        }

        // Ensure non-negative values
        if (food.getCalories() < 0) food.setCalories(0);
        if (food.getCarbs() < 0) food.setCarbs(0);
        if (food.getProtein() < 0) food.setProtein(0);
        if (food.getFat() < 0) food.setFat(0);

        return foodRepository.save(food);
    }

    public void deleteFood(Long id) {
        if (!foodRepository.existsById(id)) {
            throw new IllegalArgumentException("Food not found with ID: " + id);
        }
        foodRepository.deleteById(id);
    }

    public Food getFoodById(Long id) {
        return foodRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Food not found with ID: " + id));
    }
}