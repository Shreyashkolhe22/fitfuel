package com.app.fitfuel.controller;

import com.app.fitfuel.entity.Food;
import com.app.fitfuel.service.FoodService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/api/foods")
public class FoodController {

    private final FoodService foodService;

    public FoodController(FoodService foodService) {
        this.foodService = foodService;
    }

    // AJAX search method returning JSON
//    @GetMapping("/search")
//    @ResponseBody
//    public List<Food> searchFoods(@RequestParam("query") String query) {
//        return foodService.searchFoodsByName(query);
//    }

    // Get all foods for the food list modal
    @GetMapping("/all")
    @ResponseBody
    public List<Food> getAllFoods() {
        return foodService.getAllFoods();
    }

    // Add new food
    @PostMapping
    @ResponseBody
    public ResponseEntity<Food> addFood(@RequestBody Food food) {
        try {
            Food savedFood = foodService.saveFood(food);
            return ResponseEntity.ok(savedFood);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Update existing food
    @PutMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Food> updateFood(@PathVariable Long id, @RequestBody Food food) {
        try {
            food.setId(id);
            Food updatedFood = foodService.saveFood(food);
            return ResponseEntity.ok(updatedFood);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Delete food
    @DeleteMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Void> deleteFood(@PathVariable Long id) {
        try {
            foodService.deleteFood(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Get single food by ID
    @GetMapping("/{id}")
    @ResponseBody
    public ResponseEntity<Food> getFoodById(@PathVariable Long id) {
        try {
            Food food = foodService.getFoodById(id);
            return ResponseEntity.ok(food);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
}