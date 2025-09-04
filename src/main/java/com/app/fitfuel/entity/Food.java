package com.app.fitfuel.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "foods")
public class Food {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable=false)
    private String name;

    private int calories;
    private int carbs;
    private int protein;
    private int fat;

    public Food() {}

    public Food(String name, int calories, int carbs, int protein, int fat) {
        this.name = name;
        this.calories = calories;
        this.carbs = carbs;
        this.protein = protein;
        this.fat = fat;
    }

    // Getters & Setters
    public Long getId(){ return id; }
    public void setId(Long id){ this.id = id; }

    public String getName(){ return name; }
    public void setName(String name){ this.name = name; }

    public int getCalories(){ return calories; }
    public void setCalories(int c){ this.calories = c; }

    public int getCarbs(){ return carbs; }
    public void setCarbs(int c){ this.carbs = c; }

    public int getProtein(){ return protein; }
    public void setProtein(int p){ this.protein = p; }

    public int getFat(){ return fat; }
    public void setFat(int f){ this.fat = f; }
}