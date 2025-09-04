package com.app.fitfuel.service;

import com.app.fitfuel.entity.Goal;
import com.app.fitfuel.repository.GoalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class GoalService {

    @Autowired
    private GoalRepository goalRepository;

    public Goal saveGoal(Goal goal) {
        return goalRepository.save(goal);
    }

    public List<Goal> getGoalsByUserId(Long userId) {
        return goalRepository.findByUserId(userId);
    }

    public void deleteGoal(Long goalId) {
        goalRepository.deleteById(goalId);
    }

    public Goal calculateDailyCalorieGoal(Goal goal) {
        double bmr;
        if ("male".equals(goal.getGender())) {
            bmr = 88.362 + (13.397 * goal.getWeight()) + (4.799 * goal.getHeight()) - (5.677 * goal.getAge());
        } else {
            bmr = 447.593 + (9.247 * goal.getWeight()) + (3.098 * goal.getHeight()) - (4.330 * goal.getAge());
        }

        double activityFactor;
        switch (goal.getActivityLevel()) {
            case "sedentary":
                activityFactor = 1.2;
                break;
            case "lightly_active":
                activityFactor = 1.375;
                break;
            case "moderately_active":
                activityFactor = 1.55;
                break;
            case "very_active":
                activityFactor = 1.725;
                break;
            default:
                activityFactor = 1.2;
        }

        double dailyCalorieGoal = bmr * activityFactor;

        // Adjust based on goal type
        switch (goal.getGoalType()) {
            case "weight_loss":
                dailyCalorieGoal -= 500; // Create a calorie deficit
                break;
            case "muscle_gain":
                dailyCalorieGoal += 500; // Create a calorie surplus
                break;
            // No adjustment for weight maintenance
        }

        goal.setDailyCalorieGoal((int) dailyCalorieGoal);
        return goal;
    }



}