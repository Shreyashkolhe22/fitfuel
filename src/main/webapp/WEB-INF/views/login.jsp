<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitFuel - Login</title>
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

        /* Overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: -1;
        }

        /* Custom Cursor */
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
            height: 400px;
            width: 400px;
            background-color: rgba(149, 193, 30, 0.2);
            border-radius: 50%;
            position: fixed;
            filter: blur(60px);
            z-index: 9;
            transition: all linear 0.4s;
            pointer-events: none;
        }

        /* Navigation */
        #nav {
            height: 90px;
            width: 100%;
            display: flex;
            align-items: center;
            padding: 0 50px;
            position: fixed;
            top: 0;
            z-index: 99;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            transition: all ease 0.3s;
        }

        #nav img {
            height: 90px;
        }

        #nav .nav-brand {
            font-size: 24px;
            font-weight: 800;
            color: #95c11e;
            margin-left: 15px;
            text-transform: uppercase;
        }

        .back-home {
            margin-left: auto;
            color: #fff;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 20px;
            border: 2px solid #95c11e;
            border-radius: 25px;
            transition: all ease 0.3s;
            text-transform: uppercase;
            font-size: 14px;
        }

        .back-home:hover {
            background: #95c11e;
            color: #000;
            transform: translateY(-2px);
        }

        /* Main Container */
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 20px 20px;
            position: relative;
            z-index: 10;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 50px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            transition: all ease 0.3s;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(149, 193, 30, 0.2);
        }

        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-header h1 {
            font-size: 48px;
            font-weight: 900;
            margin-bottom: 10px;
            text-transform: uppercase;
            position: relative;
        }

        .form-header h1::before {
            content: "LOGIN";
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
        }

        .form-group {
            margin-bottom: 25px;
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

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #95c11e;
        }

        .checkbox-group label {
            color: rgba(255, 255, 255, 0.8);
            margin: 0;
            cursor: pointer;
            text-transform: none;
            font-size: 14px;
            font-weight: 500;
        }

        .forgot-link {
            color: #95c11e;
            text-decoration: none;
            font-weight: 600;
            transition: all ease 0.3s;
        }

        .forgot-link:hover {
            color: #fff;
            text-shadow: 0 0 10px #95c11e;
        }

        .login-btn {
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
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(149, 193, 30, 0.4);
            background: linear-gradient(135deg, #a8d424, #95c11e);
        }

        .login-btn:active {
            transform: translateY(-1px);
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            font-weight: 500;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: rgba(255, 255, 255, 0.2);
            z-index: 1;
        }

        .divider span {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 0 20px;
            position: relative;
            z-index: 2;
        }

        .social-login {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .social-btn {
            flex: 1;
            padding: 15px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            cursor: pointer;
            transition: all ease 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            font-size: 14px;
        }

        .social-btn:hover {
            border-color: #95c11e;
            background: rgba(149, 193, 30, 0.1);
            transform: translateY(-2px);
        }

        .signup-link {
            text-align: center;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            font-weight: 500;
        }

        .signup-link a {
            color: #95c11e;
            text-decoration: none;
            font-weight: 700;
            transition: all ease 0.3s;
        }

        .signup-link a:hover {
            color: #fff;
            text-shadow: 0 0 10px #95c11e;
        }

        /* Floating Elements */
        .floating-element {
            position: absolute;
            background: rgba(149, 193, 30, 0.1);
            border: 1px solid rgba(149, 193, 30, 0.3);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            top: 20%;
            left: 10%;
            width: 60px;
            height: 60px;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            top: 60%;
            right: 15%;
            width: 80px;
            height: 80px;
            animation-delay: 2s;
        }

        .floating-element:nth-child(3) {
            bottom: 20%;
            left: 20%;
            width: 40px;
            height: 40px;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Error Message */
        .error-message {
            background: rgba(255, 0, 0, 0.1);
            border: 1px solid rgba(255, 0, 0, 0.3);
            color: #ff6b6b;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 500;
            display: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            #nav {
                padding: 0 20px;
            }

            .login-card {
                padding: 30px 25px;
                margin: 0 10px;
            }

            .form-header h1 {
                font-size: 36px;
            }

            .social-login {
                flex-direction: column;
            }

            .form-options {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
        }

        /* Loading Animation */
        .loading {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .loading::after {
            content: '';
            width: 20px;
            height: 20px;
            border: 2px solid #95c11e;
            border-top: 2px solid transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

<!-- Overlay -->
<div class="overlay"></div>

<!-- Custom Cursors -->
<div id="cursor"></div>
<div id="cursor-blur"></div>

<!-- Floating Elements -->
<div class="floating-element"></div>
<div class="floating-element"></div>
<div class="floating-element"></div>

<!-- Navigation -->
<nav id="nav">
    <img src="${pageContext.request.contextPath}/logo1.png" alt="">
    <div class="nav-brand"></div>
    <a href="/" class="back-home">← Back to Home</a>
</nav>

<!-- Main Container -->
<div class="login-container">
    <div class="login-card">
        <div class="form-header">
            <h1>LOGIN</h1>
            <p>Enter your credentials to fuel your fitness journey</p>
        </div>

        <div class="error-message" id="errorMessage">
            Invalid email or password. Please try again.
        </div>

        <form action="/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-input" required placeholder="Enter your email">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-input" required placeholder="Enter your password">
            </div>

            <button type="submit" class="login-btn" id="loginBtn">
                <span>Sign In</span>
                <div class="loading"></div>
            </button>
        </form>

        <div class="divider">
            <span>or continue with</span>
        </div>
        <div class="signup-link">
            Don't have an account? <a href="/register">Sign up here</a>
        </div>
    </div>
</div>

<script>
    // Custom Cursor
    const cursor = document.querySelector("#cursor");
    const cursorBlur = document.querySelector("#cursor-blur");

    document.addEventListener("mousemove", function (e) {
        cursor.style.left = e.x + "px";
        cursor.style.top = e.y + "px";
        cursorBlur.style.left = e.x - 200 + "px";
        cursorBlur.style.top = e.y - 200 + "px";
    });

    // Enhanced cursor effects
    const interactiveElements = document.querySelectorAll("input, button, a, .social-btn");
    interactiveElements.forEach(function (elem) {
        elem.addEventListener("mouseenter", function () {
            cursor.style.scale = "3";
            cursor.style.border = "1px solid #fff";
            cursor.style.backgroundColor = "transparent";
        });
        elem.addEventListener("mouseleave", function () {
            cursor.style.scale = "1";
            cursor.style.border = "0px solid #95C11E";
            cursor.style.backgroundColor = "#95C11E";
        });
    });

    // Form handling
    const loginForm = document.getElementById('loginForm');
    const loginBtn = document.getElementById('loginBtn');
    const errorMessage = document.getElementById('errorMessage');

    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        if (!email || !password) {
            showError('Please fill in all fields');
            return;
        }

        // Show loading state
        loginBtn.classList.add('loading');
        loginBtn.disabled = true;

        // Simulate API call
        setTimeout(() => {
            // Hide loading state
            loginBtn.classList.remove('loading');
            loginBtn.disabled = false;

            // For demo - you would replace this with actual form submission
            // loginForm.submit();

            // Demo success
            window.location.href = '/dashboard';
        }, 2000);
    });

    function showError(message) {
        errorMessage.textContent = message;
        errorMessage.style.display = 'block';
        setTimeout(() => {
            errorMessage.style.display = 'none';
        }, 5000);
    }

    function loginWithGoogle() {
        alert('Google login integration would be implemented here');
    }

    function loginWithFacebook() {
        alert('Facebook login integration would be implemented here');
    }

    // Input animations
    document.querySelectorAll('.form-input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'translateY(-2px)';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'translateY(0)';
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

    // Parallax effect for floating elements
    window.addEventListener('mousemove', function(e) {
        const elements = document.querySelectorAll('.floating-element');
        const x = e.clientX / window.innerWidth;
        const y = e.clientY / window.innerHeight;

        elements.forEach((element, index) => {
            const speed = (index + 1) * 0.5;
            element.style.transform = `translate(${x * speed * 50}px, ${y * speed * 50}px)`;
        });
    });
</script>
</body>
</html>