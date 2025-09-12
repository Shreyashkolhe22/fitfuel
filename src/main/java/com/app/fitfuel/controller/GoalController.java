package com.app.fitfuel.controller;

import com.app.fitfuel.entity.Goal;
import com.app.fitfuel.entity.User;
import com.app.fitfuel.service.GoalService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/goals")
public class GoalController {
    private static final Logger logger = LoggerFactory.getLogger(GoalController.class);

    @Autowired
    private GoalService goalService;

    @PostMapping("/set-goal")
    public String setGoal(@ModelAttribute Goal goal,
                          @SessionAttribute("loggedInUser") User loggedInUser,
                          RedirectAttributes redirectAttributes) {
        logger.info("Setting goal for user: {}", loggedInUser.getId());
        goal.setUserId(loggedInUser.getId());
        logger.info("Goal userId set to: {}", goal.getUserId());

        Goal calculatedGoal = goalService.calculateDailyCalorieGoal(goal);
        goalService.saveGoal(calculatedGoal);

        // Add success message and calorie goal to redirect attributes
        redirectAttributes.addFlashAttribute("goalSuccess", true);
        redirectAttributes.addFlashAttribute("dailyCalorieGoal", calculatedGoal.getDailyCalorieGoal());

        return "redirect:/dashboard";
    }
}