<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>FitFuel - Welcome</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Montserrat", sans-serif;
        }

        body {
            margin: 0;
            background-color: #000;
            color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .overlay {
            background: rgba(0, 0, 0, 0.65);
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .container {
            text-align: center;
            max-width: 600px;
            padding: 40px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(12px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
            animation: fadeIn 1.2s ease-in-out;
            border: 2px solid rgba(149, 193, 30, 0.3);
        }

        .logo {
            width: 120px;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 2.8rem;
            margin-bottom: 10px;
            color: #F5F5F5;
            font-weight: 900;
        }

        .brand {
            color: #95c11e; /* Green accent from home page */
        }

        p {
            font-size: 1.2rem;
            margin-bottom: 25px;
            color: #E0E0E0;
        }

        .quote {
            font-style: italic;
            font-size: 1rem;
            margin-bottom: 30px;
            color: #95c11e; /* Green accent */
            animation: fadeInUp 2s ease-in-out;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn {
            padding: 12px 28px;
            font-size: 1.1rem;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
            background-color: transparent;
            color: #95c11e;
            border: 2px solid #95c11e;
        }

        .btn:hover {
            background-color: #95c11e;
            color: #000;
            transform: scale(1.05);
        }

        .btn-secondary {
            background-color: transparent;
            border: 2px solid #F5F5F5;
            color: #F5F5F5;
        }

        .btn-secondary:hover {
            background-color: #F5F5F5;
            color: #000;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="overlay"></div>
<div class="container">
    <img src="${pageContext.request.contextPath}/logo1.png" alt="FitFuel Logo" class="logo">
    <h1>Welcome to <span class="brand">FitFuel</span></h1>
    <p>Your personal meal and calorie tracker.</p>
    <p class="quote">"Fuel your body, fuel your goals."</p>
    <div class="btn-group">
        <a href="login" class="btn">Login</a>
        <a href="register" class="btn btn-secondary">Register</a>
    </div>
</div>
</body>
</html>