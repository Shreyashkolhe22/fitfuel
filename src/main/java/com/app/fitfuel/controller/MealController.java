package com.app.fitfuel.controller;

import com.app.fitfuel.entity.Meal;
import com.app.fitfuel.entity.User;
import com.app.fitfuel.service.MealService;
import com.app.fitfuel.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.util.List;

@Controller
public class MealController {

    @Autowired
    private MealService mealService;

    @Autowired
    private UserService userService;

    // Handles adding a meal from the modal (one POST per food item)
    @PostMapping("/addmeal")
    public String addMeal(@RequestParam Long foodId,
                          @RequestParam String mealType,
                          HttpSession session) {

        // get logged-in user object from session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Long userId = loggedInUser.getId();
        mealService.addMealFromFood(foodId, mealType, userId);

        // After AJAX or form post you redirect back to page that shows today's meals.
        return "redirect:/track-nutrition";
    }

    // Show today's meals on the page
    @GetMapping("/track-nutrition")
    public String trackNutrition(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        Long userId = loggedInUser.getId();
        List<Meal> meals = mealService.getMealsForToday(userId);
        int totalCalories = mealService.getTotalCaloriesForToday(userId);

        model.addAttribute("meals", meals);
        model.addAttribute("totalCalories", totalCalories);

        return "track-nutrition";
    }
}