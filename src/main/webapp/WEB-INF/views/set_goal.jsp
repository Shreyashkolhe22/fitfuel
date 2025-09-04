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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitFuel - Set Your Goal</title>
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
        .bg-image {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
            opacity: 0.7;
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
        .goal-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 50px;
            width: 100%;
            max-width: 800px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            transition: all ease 0.3s;
            text-align: center;
        }
        .goal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(149, 193, 30, 0.2);
        }
        .form-header h1 {
            font-size: 48px;
            font-weight: 900;
            margin-bottom: 20px;
            text-transform: uppercase;
            position: relative;
        }
        .form-header h1::before {
            content: "SET GOAL";
            position: absolute;
            color: #000;
            top: -3px;
            left: 50%;
            transform: translateX(-50%);
            -webkit-text-stroke: 1.5px #95c11e;
            z-index: -1;
        }
        .form-header p {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
            margin-bottom: 40px;
        }
        .form-section {
            margin-bottom: 30px;
            text-align: left;
            width: 100%;
        }
        .section-title {
            font-size: 24px;
            font-weight: 800;
            margin-bottom: 20px;
            color: #95c11e;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            color: #95c11e;
            margin-bottom: 8px;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 1px;
        }
        .form-input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            transition: all ease 0.3s;
            font-weight: 500;
        }
        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        .form-input:focus {
            outline: none;
            border-color: #95c11e;
            background: rgba(149, 193, 30, 0.1);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(149, 193, 30, 0.2);
        }
        .radio-group {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin: 20px 0;
        }
        .radio-option {
            position: relative;
            cursor: pointer;
        }
        .radio-option input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
            z-index: 10;
        }
        .radio-card {
            padding: 20px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            text-align: center;
            transition: all ease 0.3s;
            background: rgba(255, 255, 255, 0.1);
            pointer-events: none;
            min-height: 120px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .radio-option input:checked + .radio-card {
            border-color: #95c11e;
            background: rgba(149, 193, 30, 0.1);
        }
        .radio-option:hover .radio-card {
            border-color: rgba(255, 255, 255, 0.4);
            transform: translateY(-2px);
        }
        .radio-option input:checked:hover + .radio-card {
            border-color: #95c11e;
        }
        .radio-icon {
            font-size: 24px;
            margin-bottom: 10px;
            color: #95c11e;
        }
        .radio-title {
            font-weight: 600;
            color: #fff;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .radio-description {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.8);
            text-align: center;
            line-height: 1.4;
        }
        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #95c11e, #7da018);
            color: #000;
            border: none;
            padding: 18px 20px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 800;
            cursor: pointer;
            transition: all ease 0.3s;
            margin-top: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(149, 193, 30, 0.4);
            background: linear-gradient(135deg, #a8d424, #95c11e);
        }
        .submit-btn:active {
            transform: translateY(-1px);
        }
        @media (max-width: 768px) {
            .goal-card {
                padding: 30px 25px;
                margin: 0 10px;
            }
            .form-grid, .radio-group {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            .form-header h1 {
                font-size: 36px;
            }
        }
    </style>
</head>
<body>
<img src="${pageContext.request.contextPath}/b153.jpg" alt="Background" class="bg-image">
<div id="cursor"></div>
<div id="cursor-blur"></div>
<nav id="nav">
    <img src="${pageContext.request.contextPath}/logo1.png" alt="">
    <h4><a href="/dashboard">Home</a></h4>
    <h4><a href="/user-track-nutrition">Track Nutrition</a></h4>
    <h4><a href="/analytics">Analysis</a></h4>
    <h4 style="margin-left: auto;"><a href="/logout" style="color: #95c11e;">Logout</a></h4>
</nav>
<div class="page-container">
    <div class="goal-card">
        <div class="form-header">
            <h1>SET GOAL</h1>
            <p>Let us calculate your personalized daily calorie target</p>
        </div>
        <form action="<%=request.getContextPath()%>/goals/set-goal" method="post">
            <!-- Personal Information Section -->
            <div class="form-section">
                <h2 class="section-title">Personal Information</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <label for="age">Age (years)</label>
                        <input type="number" id="age" name="age" class="form-input" min="13" max="120" required placeholder="Enter your age">
                    </div>
                    <div class="form-group">
                        <label for="weight">Weight (kg)</label>
                        <input type="number" id="weight" name="weight" class="form-input" step="0.1" min="20" max="300" required placeholder="Enter your weight">
                    </div>
                    <div class="form-group">
                        <label for="height">Height (cm)</label>
                        <input type="number" id="height" name="height" class="form-input" step="0.1" min="100" max="250" required placeholder="Enter your height">
                    </div>
                </div>
                <div class="form-group">
                    <label>Gender</label>
                    <div class="radio-group">
                        <div class="radio-option">
                            <input type="radio" id="male" name="gender" value="male" required>
                            <div class="radio-card">
                                <div class="radio-icon">👨</div>
                                <div class="radio-title">Male</div>
                            </div>
                        </div>
                        <div class="radio-option">
                            <input type="radio" id="female" name="gender" value="female" required>
                            <div class="radio-card">
                                <div class="radio-icon">👩</div>
                                <div class="radio-title">Female</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Activity Level Section -->
            <div class="form-section">
                <h2 class="section-title">Activity Level</h2>
                <div class="radio-group">
                    <div class="radio-option">
                        <input type="radio" id="sedentary" name="activityLevel" value="sedentary" required>
                        <div class="radio-card">
                            <div class="radio-icon">🪑</div>
                            <div class="radio-title">Sedentary</div>
                            <div class="radio-description">Little to no exercise, desk job</div>
                        </div>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="lightly_active" name="activityLevel" value="lightly_active" required>
                        <div class="radio-card">
                            <div class="radio-icon">🚶</div>
                            <div class="radio-title">Lightly Active</div>
                            <div class="radio-description">Light exercise 1-3 days/week</div>
                        </div>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="moderately_active" name="activityLevel" value="moderately_active" required>
                        <div class="radio-card">
                            <div class="radio-icon">🏃</div>
                            <div class="radio-title">Moderately Active</div>
                            <div class="radio-description">Moderate exercise 3-5 days/week</div>
                        </div>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="very_active" name="activityLevel" value="very_active" required>
                        <div class="radio-card">
                            <div class="radio-icon">💪</div>
                            <div class="radio-title">Very Active</div>
                            <div class="radio-description">Hard exercise 6-7 days/week</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Goal Type Section -->
            <div class="form-section">
                <h2 class="section-title">Fitness Goal</h2>
                <div class="radio-group">
                    <div class="radio-option">
                        <input type="radio" id="muscle_gain" name="goalType" value="muscle_gain" required>
                        <div class="radio-card">
                            <div class="radio-icon">💪</div>
                            <div class="radio-title">Muscle Gain</div>
                            <div class="radio-description">Build muscle mass and strength with a calorie surplus</div>
                        </div>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="weight_loss" name="goalType" value="weight_loss" required>
                        <div class="radio-card">
                            <div class="radio-icon">🔥</div>
                            <div class="radio-title">Weight Loss</div>
                            <div class="radio-description">Lose weight and burn fat with a calorie deficit</div>
                        </div>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="weight_maintenance" name="goalType" value="weight_maintenance" required>
                        <div class="radio-card">
                            <div class="radio-icon">⚖️</div>
                            <div class="radio-title">Maintain Weight</div>
                            <div class="radio-description">Maintain current weight with balanced calories</div>
                        </div>
                    </div>
                </div>
            </div>
            <button type="submit" class="submit-btn">Calculate My Daily Goal</button>
        </form>
    </div>
</div>
<script>
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
    const interactiveElements = document.querySelectorAll("input, button, .radio-option");
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
    // Navigation scroll effect
    window.addEventListener('scroll', function() {
        const nav = document.getElementById('nav');
        if (window.scrollY > 50) {
            nav.style.background = 'rgba(0, 0, 0, 0.9)';
            nav.style.backdropFilter = 'blur(20px)';
        } else {
            nav.style.background = 'rgba(0, 0, 0, 0.5)';
            nav.style.backdropFilter = 'blur(10px)';
        }
    });
    // Form validation
    document.querySelectorAll('.form-input').forEach(input => {
        input.addEventListener('blur', function() {
            if (!this.checkValidity()) {
                this.style.borderColor = '#ff6b6b';
            } else {
                this.style.borderColor = 'rgba(255, 255, 255, 0.2)';
            }
        });
        input.addEventListener('focus', function() {
            this.style.borderColor = '#95c11e';
        });
    });
</script>
</body>
</html>
