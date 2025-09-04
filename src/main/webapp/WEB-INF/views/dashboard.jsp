<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>FitFuel - Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Montserrat", sans-serif;
            color: #fff;
        }
        html, body {
            height: 100%;
            width: 100%;
            overflow-x: hidden;
        }
        #nav {
            height: 90px;
            width: 100%;
            display: flex;
            align-items: center;
            padding: 0 150px;
            gap: 40px;
            justify-content: space-between;
            position: fixed;
            z-index: 99;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            transition: all ease 0.5s;
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
        #logout-btn {
            color: #95c11e;
            font-weight: 800;
            font-size: 14px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all ease 0.3s;
        }
        #logout-btn:hover {
            color: #fff;
        }
        video {
            height: 100%;
            width: 100%;
            object-fit: cover;
            z-index: -1;
            position: fixed;
        }
        #main {
            position: relative;
            background-color: rgba(0, 0, 0, 0.37);
        }
        #page1 {
            height: 100vh;
            width: 100%;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            z-index: 10;
        }
        #page1 h1 {
            font-size: 80px;
            font-weight: 900;
            position: relative;
        }
        #page1 h1::before {
            content: "EAT. TRAIN. REPEAT.";
            position: absolute;
            color: #000;
            top: -4px;
            left: -4px;
            -webkit-text-stroke: 1.5px #636763;
            z-index: -1;
        }
        #page1 h2 {
            font-size: 30px;
            font-weight: 800;
            margin-top: 10px;
            margin-bottom: 20px;
        }
        #page1 p {
            font-size: 1.2vw;
            font-weight: 500;
            width: 40%;
        }
        #page2 {
            min-height: 100vh;
            width: 100%;
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
            transition: all linear 0.2s;
            pointer-events: none;
        }
        #scroller {
            white-space: nowrap;
            overflow-x: auto;
            overflow-y: hidden;
            position: relative;
            z-index: 10;
        }
        #scroller::-webkit-scrollbar {
            display: none;
        }
        #scroller-in {
            display: inline-block;
            white-space: nowrap;
            animation-name: scroll;
            animation-duration: 40s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
        }
        #scroller h4 {
            display: inline-block;
            font-size: 120px;
            font-weight: 900;
            font-family: "Gilroy", sans-serif;
            margin-right: 20px;
            transition: all linear 0.3s;
            color: #000;
            -webkit-text-stroke: 2px #ffffff;
        }
        #scroller h4:hover {
            color: #95c11e;
            -webkit-text-stroke: 2px #95c11e;
        }
        @keyframes scroll {
            from {
                transform: translateX(0);
            }
            to {
                transform: translateX(-100%);
            }
        }
        #about-us {
            height: 40vh;
            width: 100%;
            display: flex;
            padding: 0 50px;
            align-items: center;
            position: relative;
            z-index: 10;
            justify-content: space-around;
        }
        #about-us img {
            height: 220px;
            width: 220px;
            border-radius: 20px;
            object-fit: cover;
        }
        #about-us-in {
            width: 50%;
            text-align: center;
        }
        #about-us-in h3 {
            font-size: 54px;
            font-weight: 800;
            margin-bottom: 30px;
        }
        #about-us-in p {
            font-size: 20px;
            line-height: 26px;
        }
        #cards-container {
            height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 70px;
            position: relative;
            z-index: 10;
        }
        .card {
            height: 80%;
            width: 24%;
            border-radius: 20px;
            background-size: cover;
            background-position: center;
            overflow: hidden;
            transition: all ease 0.6s;
            position: relative;
            cursor: pointer;
        }
        #card1 {
            background-image: url(${pageContext.request.contextPath}/card1.jpg);
        }
        #card2 {
            background-image: url(${pageContext.request.contextPath}/card2.jpg);
        }
        #card3 {
            background-image: url(${pageContext.request.contextPath}/card3.jpg);
        }
        .overlay {
            height: 100%;
            width: 100%;
            background-color: #95c11e;
            padding: 30px;
            padding-top: 160px;
            opacity: 0;
            transition: all ease 0.6s;
            position: relative;
        }
        .overlay h4 {
            color: #000;
            font-size: 30px;
            text-transform: uppercase;
            white-space: nowrap;
            margin-bottom: 20px;
            font-weight: 800;
        }
        .overlay p {
            color: #000;
            font-size: 18px;
        }
        .card:hover .overlay {
            opacity: 1;
        }
        .card:hover {
            transform: rotate3d(-1, 1, 0, 20deg);
        }
        .card::after {
            content: "→";
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 30px;
            color: #fff;
            opacity: 0;
            transition: all ease 0.6s;
            z-index: 20;
        }
        .card:hover::after {
            opacity: 1;
            color: #000;
        }
        #green-div {
            height: 30vh;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(to left bottom, #119f3a, #ace022);
        }
        #green-div h4 {
            width: 45%;
            line-height: 50px;
            color: #000;
            text-align: center;
            font-weight: 800;
            font-size: 27px;
            text-transform: uppercase;
        }
        #green-div img {
            height: 100%;
            object-fit: cover;
            width: 14%;
        }
        #page3 {
            height: 100vh;
            width: 100%;
            background-color: #000;
            display: flex;
            align-items: center;
            position: relative;
            justify-content: center;
        }
        #page3 > p {
            font-size: 35px;
            font-weight: 700;
            width: 60%;
            line-height: 45px;
            text-align: center;
        }
        #page3 img {
            position: absolute;
            height: 60px;
        }
        #page3 #colon1 {
            left: 15%;
            top: 25%;
        }
        #page3 #colon2 {
            bottom: 30%;
            right: 15%;
        }
        #page4 {
            height: 30vh;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 70px;
            position: relative;
        }
        .elem {
            height: 70%;
            width: 26%;
            overflow: hidden;
            border-radius: 20px;
            position: relative;
        }
        .elem h2 {
            height: 100%;
            width: 100%;
            background-color: #95c11e;
            display: flex;
            color: #000;
            font-weight: 800;
            align-items: center;
            justify-content: center;
            transition: all ease 0.5s;
            font-size: 2vw;
            position: absolute;
            z-index: 10;
        }
        .elem img {
            height: 100%;
            width: 100%;
            object-fit: cover;
            transition: all ease 0.5s;
            scale: 1.1;
        }
        .elem:hover h2 {
            color: #fff;
            background-color: transparent;
        }
        .elem:hover img {
            scale: 1;
        }
        #page4 h1 {
            font-size: 108px !important;
            position: absolute;
            top: -15%;
            font-weight: 900;
            font-family: "Gilroy", sans-serif;
            color: #000;
            -webkit-text-stroke: 2px #fff;
            white-space: nowrap;
            width: auto;
            left: 50%;
            transform: translateX(-50%);
        }
        #page4 h1 {
            font-size: 6.4vw;
            position: absolute;
            top: -15%;
            font-weight: 900;
            font-family: "Gilroy", sans-serif;
            color: #000;
            -webkit-text-stroke: 2px #fff;
        }
        #footer {
            height: 40vh;
            width: 100%;
            background: linear-gradient(to left bottom, #119f3a 0%, #a3d421 80%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            gap: 6.5vw;
            padding: 0 100px;
        }
        #footer > img {
            position: absolute;
            left: 0;
            height: 100%;
            z-index: 0;
        }
        #f1 img {
            height: 100px;
        }
        #f1,
        #f2,
        #f3,
        #f4 {
            width: fit-content;
            position: relative;
            z-index: 99;
        }
        #f2 h3 {
            font-size: 1.6vw;
            white-space: nowrap;
            text-transform: uppercase;
            color: #000;
            font-weight: 900;
            margin-bottom: 8px;
        }
        #f3 h3 {
            font-size: 1.6vw;
            white-space: nowrap;
            text-transform: uppercase;
            color: #000;
            font-weight: 800;
            margin-bottom: 8px;
        }
        #f4 h4 {
            font-size: 1vw;
            white-space: nowrap;
            text-transform: uppercase;
            color: #000;
            font-weight: 600;
            line-height: 20px;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
<div id="nav">
    <img src="${pageContext.request.contextPath}/logo1.png" alt="">
    <h4><a href="/set-goal">Set Goal</a></h4>
    <h4><a href="/user-track-nutrition">Track Nutrition</a></h4>
    <h4><a href="/analytics">Analysis</a></h4>
    <h4 id="logout-btn" onclick="window.location.href='/logout'">Logout</h4>
</div>
<video autoplay loop muted src="${pageContext.request.contextPath}/bg1.mp4"></video>
<div id="cursor"></div>
<div id="cursor-blur"></div>
<div id="main">
    <div id="page1">
        <h1>EAT. TRAIN. REPEAT.</h1>
        <h2>WELCOME TO FITFUEL</h2>
        <p>
            Welcome to FitFuel. FitFuel is a smart nutrition and fitness tracking platform designed to help you set personalized goals, monitor your daily nutrition, and analyze your progress. Passionate about health, technology, and making fitness simple and accessible for everyone.
        </p>
    </div>
    <div id="page2">
        <div id="scroller">
            <div id="scroller-in">
                <h4>EAT SMART</h4>
                <h4>TRAIN HARD</h4>
                <h4>STAY CONSISTENT</h4>
                <h4>CELEBRATE PROGRESS</h4>
                <h4>REPEAT</h4>
            </div>
            <div id="scroller-in">
                <h4>EAT SMART</h4>
                <h4>TRAIN HARD</h4>
                <h4>STAY CONSISTENT</h4>
                <h4>CELEBRATE PROGRESS</h4>
                <h4>REPEAT</h4>
            </div>
        </div>
        <div id="about-us">
            <img src="${pageContext.request.contextPath}/add2.jpg" alt="" />
            <div id="about-us-in">
                <h3>ABOUT US</h3>
                <p>
                    FitFuel is a smart fitness companion that helps you set personalized goals, track your daily nutrition, and analyze your progress. We make healthy living simple, effective, and accessible for everyone.
                </p>
            </div>
            <img src="${pageContext.request.contextPath}/add1.jpg" alt="" />
        </div>
        <div id="cards-container">
            <div class="card" id="card1" onclick="window.location.href='/set-goal'">
                <div class="overlay">
                    <h4>SET GOAL</h4>
                    <p>
                        Your journey starts here! Enter your height, weight, age, and activity level to create a personalized fitness plan tailored just for you.
                    </p>
                </div>
            </div>
            <div class="card" id="card2" onclick="window.location.href='/user-track-nutrition'">
                <div class="overlay">
                    <h4>TRACK NUTRITION</h4>
                    <p>
                        Stay on top of your meals! Log your daily food intake and monitor calories, proteins, carbs, and fats with ease to stay aligned with your goals.
                    </p>
                </div>
            </div>
            <div class="card" id="card3" onclick="window.location.href='/analytics'">
                <div class="overlay">
                    <h4>ANALYSIS</h4>
                    <p>
                        See your progress clearly! Get smart insights and detailed reports that highlight your improvements, habits, and milestones along the way.
                    </p>
                </div>
            </div>
        </div>
        <div id="green-div">
            <img src="https://eiwgew27fhz.exactdn.com/wp-content/themes/puttosaurus/img/dots-side.svg" alt="" />
            <h4>
                Get FitFuel Nutrition Hacks and Progress Boosters Right in Your Inbox
            </h4>
            <img src="https://eiwgew27fhz.exactdn.com/wp-content/themes/puttosaurus/img/dots-side.svg" alt="" />
        </div>
    </div>
    <div id="page3">
        <p>
            Great experience using FitFuel, it makes healthy living so much easier. The app is simple, supportive, and very motivating. Nutrition tracking is clear, and setting personal goals keeps you focused. Perfect for staying consistent and building better habits. Definitely worth trying if you want to take control of your fitness.
        </p>
        <img id="colon1" src="https://eiwgew27fhz.exactdn.com/wp-content/themes/puttosaurus/img/quote-left.svg" alt="" />
        <img id="colon2" src="https://eiwgew27fhz.exactdn.com/wp-content/themes/puttosaurus/img/quote-right.svg" alt="" />
    </div>
    <div id="page4">
        <h1>WHAT ARE YOU WAITING FOR?</h1>
        <div class="elem">
            <h2>MOVE</h2>
            <img src="${pageContext.request.contextPath}/c1.jpg" alt="" />
        </div>
        <div class="elem">
            <h2>FUEL</h2>
            <img src="${pageContext.request.contextPath}/c2.jpg" alt="" />
        </div>
        <div class="elem">
            <h2>GROW</h2>
            <img src="${pageContext.request.contextPath}/c3.jpg" alt="" />
        </div>
    </div>
    <div id="footer">
        <img src="https://eiwgew27fhz.exactdn.com/wp-content/themes/puttosaurus/img/dots-footer.svg" alt="" />
        <div id="f1"></div>
        <div id="f2">
            <h3>WORKOUT PLANS</h3>
            <h3>NUTRITION TRACKER</h3>
            <h3>PROGRESS ANALYSIS</h3>
        </div>
        <div id="f3">
            <h3>BLOG & TIPS</h3>
            <h3>SUPPORT</h3>
            <h3>CONTACT US</h3>
        </div>
        <div id="f4">
            <h4>
                Start your FitFuel Journey Today! <br />
                Your Fitness. Your Fuel.
            </h4>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.1/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.1/ScrollTrigger.min.js"></script>
<script>
    var crsr = document.querySelector("#cursor");
    var blur = document.querySelector("#cursor-blur");
    document.addEventListener("mousemove", function (dets) {
        crsr.style.left = dets.x + "px";
        crsr.style.top = dets.y + "px";
        blur.style.left = dets.x - 250 + "px";
        blur.style.top = dets.y - 250 + "px";
    });

    var h4all = document.querySelectorAll("#nav h4");
    h4all.forEach(function (elem) {
        elem.addEventListener("mouseenter", function () {
            crsr.style.scale = 3;
            crsr.style.border = "1px solid #fff";
            crsr.style.backgroundColor = "transparent";
        });
        elem.addEventListener("mouseleave", function () {
            crsr.style.scale = 1;
            crsr.style.border = "0px solid #95C11E";
            crsr.style.backgroundColor = "#95C11E";
        });
    });

    gsap.to("#nav", {
        backgroundColor: "#000",
        duration: 0.5,
        height: "110px",
        scrollTrigger: {
            trigger: "#nav",
            scroller: "body",
            start: "top -10%",
            end: "top -11%",
            scrub: 1,
        },
    });

    gsap.to("#main", {
        backgroundColor: "#000",
        scrollTrigger: {
            trigger: "#main",
            scroller: "body",
            start: "top -25%",
            end: "top -70%",
            scrub: 2,
        },
    });

    gsap.from("#about-us img, #about-us-in", {
        y: 90,
        opacity: 0,
        duration: 1,
        scrollTrigger: {
            trigger: "#about-us",
            scroller: "body",
            start: "top 70%",
            end: "top 65%",
            scrub: 1,
        },
    });

    gsap.from("#colon1", {
        y: -70,
        x: -70,
        scrollTrigger: {
            trigger: "#colon1",
            scroller: "body",
            start: "top 55%",
            end: "top 45%",
            scrub: 4,
        },
    });

    gsap.from("#colon2", {
        y: 70,
        x: 70,
        scrollTrigger: {
            trigger: "#colon1",
            scroller: "body",
            start: "top 55%",
            end: "top 45%",
            scrub: 4,
        },
    });

    gsap.from("#page4 h1", {
        y: 50,
        scrollTrigger: {
            trigger: "#page4 h1",
            scroller: "body",
            start: "top 75%",
            end: "top 70%",
            scrub: 3,
        },
    });
</script>
</body>
</html>
