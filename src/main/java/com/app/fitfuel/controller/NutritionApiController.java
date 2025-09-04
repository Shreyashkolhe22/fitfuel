package com.app.fitfuel.controller;

import com.app.fitfuel.entity.Food;
import com.app.fitfuel.entity.Goal;
import com.app.fitfuel.entity.Meal;
import com.app.fitfuel.entity.User;
import com.app.fitfuel.repository.FoodRepository;
import com.app.fitfuel.repository.GoalRepository;
import com.app.fitfuel.repository.MealRepository;
import com.app.fitfuel.repository.UserRepository;
import com.app.fitfuel.service.MealService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class NutritionApiController {

    @Autowired
    private FoodRepository foodRepository;

    @Autowired
    private MealRepository mealRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MealService mealService;

    @Autowired
    private GoalRepository goalRepository;

    // DTOs
    public static class FoodDto {
        public Long id;
        public String name;
        public int calories;
        public int carbs;
        public int protein;
        public int fat;

        public FoodDto(Long id, String name, int calories, int carbs, int protein, int fat) {
            this.id = id;
            this.name = name;
            this.calories = calories;
            this.carbs = carbs;
            this.protein = protein;
            this.fat = fat;
        }
    }

    public static class MealDto {
        public Long id;
        public String foodName;
        public int calories;
        public String mealType;
        public int carbs;
        public int protein;
        public int fat;

        public MealDto(Long id, String foodName, int calories, String mealType, int carbs, int protein, int fat) {
            this.id = id;
            this.foodName = foodName;
            this.calories = calories;
            this.mealType = mealType;
            this.carbs = carbs;
            this.protein = protein;
            this.fat = fat;
        }
    }

    public static class AddMealRequest {
        public Long foodId;
        public String mealType;

        public AddMealRequest() {}

        public Long getFoodId() { return foodId; }
        public void setFoodId(Long id) { this.foodId = id; }
        public String getMealType() { return mealType; }
        public void setMealType(String t) { this.mealType = t; }
    }

    public static class GoalDto {
        public Integer dailyCalorieGoal;
        public GoalDto(Integer dailyCalorieGoal) {
            this.dailyCalorieGoal = dailyCalorieGoal;
        }
    }

    // Search foods
    @GetMapping("/foods/search")
    public List<FoodDto> searchFoods(@RequestParam String query) {
        List<Food> foods = foodRepository.findByNameContainingIgnoreCase(query);
        return foods.stream()
                .map(f -> new FoodDto(f.getId(), f.getName(), f.getCalories(), f.getCarbs(), f.getProtein(), f.getFat()))
                .collect(Collectors.toList());
    }

    // Get today's meals for logged-in user (kept for backward compatibility)
    @GetMapping("/meals/today")
    public ResponseEntity<?> getTodaysMeals(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");

        LocalDate today = LocalDate.now();
        List<Meal> meals = mealRepository.findByUserAndDate(user, today);

        List<MealDto> dtos = meals.stream()
                .map(m -> new MealDto(m.getId(), m.getFoodName(), m.getCalories(), m.getMealType(), m.getCarbs(), m.getProtein(), m.getFat()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(dtos);
    }

    // Get meals for a specific date (or today if no date provided)
    @GetMapping("/meals")
    public ResponseEntity<?> getMealsByDate(
            HttpSession session,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date
    ) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
        }

        LocalDate queryDate = (date != null) ? date : LocalDate.now();
        System.out.println("Querying meals for user: " + user.getId() + ", date: " + queryDate);

        List<Meal> meals = mealRepository.findByUserAndDate(user, queryDate);
        List<MealDto> mealDtos = meals.stream()
                .map(m -> new MealDto(m.getId(), m.getFoodName(), m.getCalories(), m.getMealType(), m.getCarbs(), m.getProtein(), m.getFat()))
                .collect(Collectors.toList());

        return ResponseEntity.ok(mealDtos);
    }

    // Alternative endpoint with 'date' in path for analytics page
    @GetMapping("/meals/date")
    public ResponseEntity<?> getMealsByDateParam(
            HttpSession session,
            @RequestParam String date
    ) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
        }

        try {
            LocalDate queryDate = LocalDate.parse(date);
            System.out.println("Analytics: Querying meals for user: " + user.getId() + ", date: " + queryDate);

            List<Meal> meals = mealRepository.findByUserAndDate(user, queryDate);
            List<MealDto> mealDtos = meals.stream()
                    .map(m -> new MealDto(m.getId(), m.getFoodName(), m.getCalories(), m.getMealType(), m.getCarbs(), m.getProtein(), m.getFat()))
                    .collect(Collectors.toList());

            return ResponseEntity.ok(mealDtos);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Invalid date format. Use YYYY-MM-DD");
        }
    }

    // Add meal (foodId + mealType) -> saved with today's date and logged-in user
    @PostMapping("/meals")
    public ResponseEntity<?> addMeal(@RequestBody AddMealRequest req, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");

        if (req == null || req.foodId == null || req.mealType == null) {
            return ResponseEntity.badRequest().body("Invalid payload");
        }

        Food food = foodRepository.findById(req.foodId).orElse(null);
        if (food == null) return ResponseEntity.badRequest().body("Food not found");

        Meal meal = new Meal();
        meal.setFoodName(food.getName());
        meal.setCalories(food.getCalories());
        meal.setCarbs(food.getCarbs());
        meal.setProtein(food.getProtein());
        meal.setFat(food.getFat());
        meal.setMealType(req.mealType);
        meal.setDate(LocalDate.now());
        meal.setUser(user);

        Meal saved = mealRepository.save(meal);
        MealDto dto = new MealDto(saved.getId(), saved.getFoodName(), saved.getCalories(), saved.getMealType(), saved.getCarbs(), saved.getProtein(), saved.getFat());
        return ResponseEntity.ok(dto);
    }

    // Delete meal by id (only by owner)
    @DeleteMapping("/meals/{id}")
    public ResponseEntity<?> deleteMeal(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");

        return mealRepository.findById(id).map(m -> {
            if (!m.getUser().getId().equals(user.getId())) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Not allowed");
            }
            mealRepository.delete(m);
            return ResponseEntity.ok().build();
        }).orElse(ResponseEntity.notFound().build());
    }

    // Get user's daily calorie goal
    @GetMapping("/goals/user/{userId}")
    public ResponseEntity<?> getUserGoal(@PathVariable Long userId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
        }
        if (!user.getId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Access denied");
        }

        List<Goal> goals = goalRepository.findByUserId(userId);
        if (goals.isEmpty()) {
            return ResponseEntity.ok(new GoalDto(2000)); // Default goal
        }

        Goal latestGoal = goals.get(goals.size() - 1);
        return ResponseEntity.ok(new GoalDto(latestGoal.getDailyCalorieGoal()));
    }
}