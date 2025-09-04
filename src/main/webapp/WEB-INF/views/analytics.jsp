<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    com.app.fitfuel.entity.User loggedInUser = (com.app.fitfuel.entity.User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>FitFuel - Nutrition Analytics</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Montserrat", sans-serif;
        }
        html, body {
            height: 100%;
            width: 100%;
            overflow-x: hidden;
        }
        body {
            background: #000;
            color: #fff;
            position: relative;
        }
        #nav {
            height: 90px;
            width: 100%;
            display: flex;
            align-items: center;
            padding: 0 150px;
            gap: 40px;
            justify-content: flex-start;
            position: fixed;
            z-index: 99;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            transition: all ease 0.3s;
        }
        #nav img {
            height: 125px;
        }
        #nav h4 {
            text-transform: uppercase;
            font-weight: 800;
            font-size: 14px;
            color: #fff;
        }
        #nav h4 a {
            color: #fff;
            text-decoration: none;
            transition: all ease 0.3s;
        }
        #nav h4:hover {
            color: #95c11e;
        }
        #cursor {
            height: 20px;
            width: 20px;
            background-color: #95c11e;
            border-radius: 50%;
            position: fixed;
            z-index: 99;
            transition: all linear 0.1s;
            pointer-events: none;
        }
        #cursor-blur {
            height: 500px;
            width: 500px;
            background-color: rgba(149, 193, 30, 0.3);
            border-radius: 50%;
            position: fixed;
            filter: blur(80px);
            z-index: 9;
            transition: all linear 0.4s;
            pointer-events: none;
        }
        .page-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 20px 20px;
            position: relative;
            z-index: 10;
        }
        .analytics-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 30px;
            width: 100%;
            max-width: 1200px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            transition: all ease 0.3s;
            text-align: center;
            margin-bottom: 20px;
        }
        .analytics-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(149, 193, 30, 0.2);
        }
        .analytics-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .analytics-header h1 {
            font-size: 48px;
            font-weight: 900;
            margin-bottom: 10px;
            text-transform: uppercase;
            position: relative;
            color: #fff;
            -webkit-text-stroke: 1.5px #95c11e;
        }

        .analytics-header p {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
            margin-bottom: 20px;
        }
        .date-selector {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-bottom: 30px;
            background: rgba(255, 255, 255, 0.1);
            padding: 10px 20px;
            border-radius: 10px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .date-selector label {
            color: #fff;
            font-weight: 600;
        }
        .date-selector input {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            color: #fff;
            font-size: 14px;
        }
        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 40px;
        }
        .card-title {
            font-size: 24px;
            font-weight: 800;
            color: #fff;
            margin-bottom: 20px;
            text-align: center;
        }
        .progress-container {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            height: 200px;
        }
        .progress-circle {
            width: 180px;
            height: 180px;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .progress-circle svg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            transform: rotate(-90deg);
        }
        .progress-circle .circle-bg {
            fill: none;
            stroke: rgba(255, 255, 255, 0.25);
            stroke-width: 8;
        }
        .progress-circle .circle-progress {
            fill: none;
            stroke: #95c11e;
            stroke-width: 8;
            stroke-linecap: round;
            transition: stroke-dasharray 0.3s ease;
        }
        .progress-text {
            position: relative;
            z-index: 1;
            text-align: center;
            color: #fff;
        }
        .progress-calories {
            font-size: 2rem;
            font-weight: bold;
        }
        .progress-label {
            font-size: 0.9rem;
            margin-top: 0.25rem;
        }
        .progress-goal {
            font-size: 0.85rem;
            margin-top: 0.25rem;
            color: rgba(255, 255, 255, 0.7);
        }
        .summary-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin: 20px 0;
        }
        .stat-item {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 15px;
            text-align: center;
        }
        .stat-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: #fff;
        }
        .stat-label {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.7);
            text-transform: uppercase;
            font-weight: 600;
            margin-top: 0.25rem;
        }
        .chart-container {
            height: 300px;
            position: relative;
        }
        .macros-chart {
            height: 200px;
        }
        @media (max-width: 768px) {
            .analytics-grid {
                grid-template-columns: 1fr;
            }
            .summary-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div id="cursor"></div>
<div id="cursor-blur"></div>
<nav id="nav">
    <img src="${pageContext.request.contextPath}/logo1.png" alt="">
    <h4><a href="/dashboard">Home</a></h4>
    <h4><a href="/track-nutrition">Track Nutrition</a></h4>
    <h4><a href="/analytics">Analytics</a></h4>
    <h4 style="margin-left: auto;"><a href="/logout" style="color: #95c11e;">Logout</a></h4>
</nav>
<div class="page-container">
    <div class="analytics-card">
        <div class="analytics-header">
            <h1>NUTRITION ANALYTICS</h1>
            <p>Track your daily nutrition progress and insights</p>
        </div>
        <div class="date-selector">
            <label for="analyticsDate">📅 Select Date:</label>
            <input type="date" id="analyticsDate" />
        </div>
        <div class="analytics-grid">
            <!-- Calories Progress Card -->
            <div class="analytics-card">
                <h3 class="card-title">🎯 Calories Progress</h3>
                <div class="progress-container">
                    <div class="progress-circle">
                        <svg>
                            <circle class="circle-bg" cx="90" cy="90" r="75"></circle>
                            <circle class="circle-progress" cx="90" cy="90" r="75" stroke-dasharray="0 471" id="caloriesProgressCircle"></circle>
                        </svg>
                        <div class="progress-text">
                            <div class="progress-calories" id="consumedCalories">0</div>
                            <div class="progress-label">consumed</div>
                            <div class="progress-goal" id="caloriesGoal">of 2000 kcal</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Macronutrients Summary -->
            <div class="analytics-card">
                <h3 class="card-title">🥗 Macronutrients</h3>
                <div class="summary-stats">
                    <div class="stat-item">
                        <div class="stat-value" style="color: #fbbf24;" id="totalCarbs">0g</div>
                        <div class="stat-label">Carbs</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value" style="color: #3b82f6;" id="totalProtein">0g</div>
                        <div class="stat-label">Protein</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value" style="color: #6b7280;" id="totalFat">0g</div>
                        <div class="stat-label">Fat</div>
                    </div>
                </div>
                <div class="macros-chart">
                    <canvas id="macrosChart"></canvas>
                </div>
            </div>
            <!-- Food Distribution Pie Chart -->
            <div class="analytics-card">
                <h3 class="card-title">🍽️ Food Distribution</h3>
                <div class="chart-container">
                    <canvas id="foodDistributionChart"></canvas>
                </div>
            </div>
            <!-- Meal Breakdown -->
            <div class="analytics-card">
                <h3 class="card-title">🕐 Meal Breakdown</h3>
                <div class="chart-container">
                    <canvas id="mealBreakdownChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    const base = '<%=request.getContextPath()%>';
    const userId = <%= loggedInUser.getId() %>;
    let macrosChart = null;
    let foodChart = null;
    let mealChart = null;
    // Set today's date as default
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('analyticsDate').value = today;
        loadAnalytics(today);
        // Listen for date changes
        document.getElementById('analyticsDate').addEventListener('change', function() {
            loadAnalytics(this.value);
        });
    });
    async function loadAnalytics(date) {
        try {
            console.log('Loading analytics for date:', date);
            showLoading();
            // Fetch meals for the selected date - try both endpoints
            let mealsRes = await fetch(`${base}/api/meals?date=${date}`);
            console.log('First attempt - Meals response status:', mealsRes.status);
            // If the first endpoint doesn't work, try the alternative
            if (!mealsRes.ok) {
                console.log('First endpoint failed, trying alternative...');
                mealsRes = await fetch(`${base}/api/meals/date?date=${date}`);
                console.log('Second attempt - Meals response status:', mealsRes.status);
            }
            if (mealsRes.status === 401) {
                window.location.href = base + '/login';
                return;
            }
            let meals = [];
            if (mealsRes.ok) {
                meals = await mealsRes.json();
                console.log('Meals data received:', meals);
                console.log('Number of meals:', meals.length);
            } else {
                console.error('Failed to fetch meals:', await mealsRes.text());
            }
            // Fetch user goal
            const goalRes = await fetch(`${base}/api/goals/user/${userId}`);
            let dailyGoal = 2000;
            if (goalRes.ok) {
                const goal = await goalRes.json();
                dailyGoal = goal.dailyCalorieGoal || 2000;
                console.log('Daily goal:', dailyGoal);
            } else {
                console.error('Failed to fetch goal:', await goalRes.text());
            }
            // Process and display data
            processAnalyticsData(meals, dailyGoal);
        } catch (error) {
            console.error('Error loading analytics:', error);
            showError();
        }
    }
    function processAnalyticsData(meals, dailyGoal) {
        console.log('Processing analytics data...');
        console.log('Meals array:', meals);
        console.log('Daily goal:', dailyGoal);
        if (!meals || meals.length === 0) {
            console.log('No meals found - showing no data state');
            showNoData();
            return;
        }
        // Calculate totals
        const totals = meals.reduce((acc, meal) => {
            console.log('Processing meal:', meal);
            acc.calories += meal.calories || 0;
            acc.carbs += meal.carbs || 0;
            acc.protein += meal.protein || 0;
            acc.fat += meal.fat || 0;
            return acc;
        }, { calories: 0, carbs: 0, protein: 0, fat: 0 });
        console.log('Calculated totals:', totals);
        // Update calories progress
        updateCaloriesProgress(totals.calories, dailyGoal);
        // Update macronutrients
        updateMacronutrients(totals);
        // Create charts
        createMacrosChart(totals);
        createFoodDistributionChart(meals);
        createMealBreakdownChart(meals);
    }
    function updateCaloriesProgress(consumed, goal) {
        document.getElementById('consumedCalories').textContent = consumed;
        document.getElementById('caloriesGoal').textContent = `of ${goal} kcal`;
        // Update progress circle
        const percentage = Math.min((consumed / goal) * 100, 100);
        const radius = 75;
        const circumference = 2 * Math.PI * radius;
        const strokeLength = (percentage / 100) * circumference;
        document.getElementById('caloriesProgressCircle').style.strokeDasharray = `${strokeLength} ${circumference}`;
    }
    function updateMacronutrients(totals) {
        document.getElementById('totalCarbs').textContent = totals.carbs + 'g';
        document.getElementById('totalProtein').textContent = totals.protein + 'g';
        document.getElementById('totalFat').textContent = totals.fat + 'g';
    }
    function createMacrosChart(totals) {
        const ctx = document.getElementById('macrosChart').getContext('2d');
        if (macrosChart) {
            macrosChart.destroy();
        }
        macrosChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Carbs', 'Protein', 'Fat'],
                datasets: [{
                    label: 'Grams',
                    data: [totals.carbs, totals.protein, totals.fat],
                    backgroundColor: ['#fbbf24', '#3b82f6', '#6b7280'],
                    borderRadius: 6,
                    borderSkipped: false,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.2)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
    }
    function createFoodDistributionChart(meals) {
        const ctx = document.getElementById('foodDistributionChart').getContext('2d');
        if (foodChart) {
            foodChart.destroy();
        }
        // Group by food name and sum calories
        const foodMap = {};
        meals.forEach(meal => {
            const foodName = meal.foodName || 'Unknown';
            if (foodMap[foodName]) {
                foodMap[foodName] += meal.calories || 0;
            } else {
                foodMap[foodName] = meal.calories || 0;
            }
        });
        // Convert to arrays for chart
        const labels = Object.keys(foodMap);
        const data = Object.values(foodMap);
        const colors = generateColors(labels.length);
        foodChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: colors,
                    borderWidth: 2,
                    borderColor: '#ffffff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 15,
                            usePointStyle: true,
                            color: '#fff'
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = ((context.raw / total) * 100).toFixed(1);
                                return `${context.label}: ${context.raw} kcal (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });
    }
    function createMealBreakdownChart(meals) {
        const ctx = document.getElementById('mealBreakdownChart').getContext('2d');
        if (mealChart) {
            mealChart.destroy();
        }
        // Group by meal type
        const mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
        const mealData = mealTypes.map(type => {
            return meals
                .filter(meal => meal.mealType === type)
                .reduce((sum, meal) => sum + (meal.calories || 0), 0);
        });
        mealChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: mealTypes,
                datasets: [{
                    data: mealData,
                    backgroundColor: ['#95c11e', '#34D399', '#60A5FA', '#FBBF24'],
                    borderWidth: 2,
                    borderColor: '#ffffff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '50%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 15,
                            usePointStyle: true,
                            color: '#fff'
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = total > 0 ? ((context.raw / total) * 100).toFixed(1) : 0;
                                return `${context.label}: ${context.raw} kcal (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });
    }
    function generateColors(count) {
        const colors = [
            '#95c11e', '#34D399', '#60A5FA', '#FBBF24', '#A855F7',
            '#EF4444', '#10B981', '#3B82F6', '#F59E0B', '#8B5CF6'
        ];
        const result = [];
        for (let i = 0; i < count; i++) {
            result.push(colors[i % colors.length]);
        }
        return result;
    }
    function showLoading() {
        // You can implement loading states here
    }
    function showNoData() {
        // Clear all displays
        document.getElementById('consumedCalories').textContent = '0';
        document.getElementById('totalCarbs').textContent = '0g';
        document.getElementById('totalProtein').textContent = '0g';
        document.getElementById('totalFat').textContent = '0g';
        document.getElementById('caloriesProgressCircle').style.strokeDasharray = '0 471';
        // Destroy existing charts
        if (macrosChart) macrosChart.destroy();
        if (foodChart) foodChart.destroy();
        if (mealChart) mealChart.destroy();
    }
    function showError() {
        console.log('Error loading analytics data');
    }
    // Custom Cursor
    const cursor = document.querySelector("#cursor");
    const cursorBlur = document.querySelector("#cursor-blur");
    document.addEventListener("mousemove", function(e) {
        cursor.style.left = e.x + "px";
        cursor.style.top = e.y + "px";
        cursorBlur.style.left = e.x - 250 + "px";
        cursorBlur.style.top = e.y - 250 + "px";
    });
    // Enhanced cursor effects
    const interactiveElements = document.querySelectorAll("input, button, .add-btn, .delete-btn, .remove-btn, .close-btn, .save-btn, .edit-btn, .delete-food-btn");
    interactiveElements.forEach(function(elem) {
        elem.addEventListener("mouseenter", function() {
            cursor.style.scale = "3";
            cursor.style.border = "1px solid #fff";
            cursor.style.backgroundColor = "transparent";
        });
        elem.addEventListener("mouseleave", function() {
            cursor.style.scale = "1";
            cursor.style.border = "0px solid #95C11E";
            cursor.style.backgroundColor = "#95C11E";
        });
    });
</script>
</body>
</html>
