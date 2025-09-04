package com.app.fitfuel.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "meals")
public class Meal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String foodName;
    private int calories;
    private int carbs;
    private int protein;
    private int fat;

    private String mealType; // Breakfast, Lunch, Snack, etc.

    private LocalDate date;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private com.app.fitfuel.entity.User user;

    // Constructors
    public Meal() {}

    public Meal(String foodName, int calories, int carbs, int protein, int fat,
                String mealType, LocalDate date, User user) {
        this.foodName = foodName;
        this.calories = calories;
        this.carbs = carbs;
        this.protein = protein;
        this.fat = fat;
        this.mealType = mealType;
        this.date = date;
        this.user = user;
    }

    // Getters & Setters
    public Long getId() { return id; }

    public String getFoodName() { return foodName; }
    public void setFoodName(String foodName) { this.foodName = foodName; }

    public int getCalories() { return calories; }
    public void setCalories(int calories) { this.calories = calories; }

    public String getMealType() { return mealType; }
    public void setMealType(String mealType) { this.mealType = mealType; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public com.app.fitfuel.entity.User getUser() { return user; }
    public void setUser(com.app.fitfuel.entity.User user) { this.user = user; }

    public int getCarbs() { return carbs; }
    public void setCarbs(int carbs) { this.carbs = carbs; }

    public int getProtein() { return protein; }
    public void setProtein(int protein) { this.protein = protein; }

    public int getFat() { return fat; }
    public void setFat(int fat) { this.fat = fat; }
}