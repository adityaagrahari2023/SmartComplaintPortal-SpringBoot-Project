<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0a0e27;
            color: #e2e8f0;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        .bg-blob {
            position: fixed;
            width: 500px;
            height: 500px;
            border-radius: 50%;
            filter: blur(130px);
            opacity: 0.35;
            z-index: 0;
        }
        .blob1 { background: #6366f1; top: -150px; left: -100px; animation: float1 8s ease-in-out infinite; }
        .blob2 { background: #ec4899; bottom: -150px; right: -100px; animation: float2 10s ease-in-out infinite; }

        @keyframes float1 { 0%,100%{transform:translate(0,0);} 50%{transform:translate(80px,60px);} }
        @keyframes float2 { 0%,100%{transform:translate(0,0);} 50%{transform:translate(-80px,-60px);} }

        .grid-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-image:
                linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
            background-size: 40px 40px;
            z-index: 0;
        }

        /* Navbar */
        nav {
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 22px 60px;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }

        .logo {
            font-size: 19px;
            font-weight: 800;
            color: #fff;
        }
        .logo span { color: #a5b4fc; }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .user-chip {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.12);
            padding: 7px 16px 7px 7px;
            border-radius: 50px;
        }

        .avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #ec4899);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
            color: #fff;
        }

        .user-chip span {
            font-size: 13.5px;
            color: #e2e8f0;
            font-weight: 600;
        }

        .logout-btn {
            color: #fca5a5;
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 600;
            border: 1px solid rgba(239,68,68,0.35);
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.25s;
        }
        .logout-btn:hover { background: rgba(239,68,68,0.12); }

        /* Hero */
        .welcome {
            position: relative;
            z-index: 1;
            padding: 55px 60px 10px;
        }

        .badge {
            display: inline-block;
            padding: 6px 16px;
            background: rgba(99, 102, 241, 0.15);
            border: 1px solid rgba(99, 102, 241, 0.4);
            color: #a5b4fc;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            border-radius: 50px;
            margin-bottom: 18px;
        }

        .welcome h1 {
            font-size: 32px;
            font-weight: 800;
            color: #fff;
            margin-bottom: 8px;
        }
        .welcome h1 span {
            background: linear-gradient(90deg, #a5b4fc, #f9a8d4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .welcome p {
            color: #94a3b8;
            font-size: 14.5px;
        }

        /* Cards grid */
        .actions {
            position: relative;
            z-index: 1;
            padding: 40px 60px 80px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 22px;
            max-width: 1100px;
        }

        .action-card {
            display: block;
            text-decoration: none;
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 18px;
            padding: 30px 26px;
            transition: all 0.3s ease;
        }
        .action-card:hover {
            border-color: rgba(99,102,241,0.5);
            transform: translateY(-6px);
            box-shadow: 0 18px 40px rgba(99,102,241,0.25);
        }

        .action-icon {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 18px;
        }

        .icon1 { background: linear-gradient(135deg, #6366f1, #818cf8); }
        .icon2 { background: linear-gradient(135deg, #ec4899, #f472b6); }
        .icon3 { background: linear-gradient(135deg, #10b981, #34d399); }
        .icon4 { background: linear-gradient(135deg, #f59e0b, #fbbf24); }

        .action-card h3 {
            color: #fff;
            font-size: 17px;
            margin-bottom: 8px;
        }

        .action-card p {
            color: #94a3b8;
            font-size: 13px;
            line-height: 1.6;
        }

        .action-card .arrow {
            margin-top: 16px;
            color: #a5b4fc;
            font-size: 13px;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="bg-blob blob1"></div>
    <div class="bg-blob blob2"></div>
    <div class="grid-overlay"></div>

    <nav>
        <div class="logo">Complaint<span>Portal</span></div>
        <div class="nav-right">
            <div class="user-chip">
                <div class="avatar">${fn:toUpperCase(fn:substring(user.name, 0, 1))}</div>
                <span>${fn:toUpperCase(fn:substring(user.name, 0, 1))}${fn:substring(user.name, 1, fn:length(user.name))}</span>
            </div>
            <a href="/logout" class="logout-btn">Logout</a>
        </div>
    </nav>

    <section class="welcome">
        <span class="badge">🙋 Customer Panel</span>
        <h1>Hello, <span>${fn:toUpperCase(fn:substring(user.name, 0, 1))}${fn:substring(user.name, 1, fn:length(user.name))}</span> 👋</h1>
        <p>Manage your complaints and track their status in real time.</p>
    </section>

    <section class="actions">
        <div class="grid">

            <a href="/customer/raise-complaint" class="action-card">
                <div class="action-icon icon1">📝</div>
                <h3>Raise Complaint</h3>
                <p>Submit a new complaint or service request quickly.</p>
                <div class="arrow">Get Started →</div>
            </a>

            <a href="/customer/my-complaints" class="action-card">
                <div class="action-icon icon2">📂</div>
                <h3>My Complaints</h3>
                <p>View all complaints you've raised so far.</p>
                <div class="arrow">View All →</div>
            </a>

            <a href="/customer/track-complaint" class="action-card">
                <div class="action-icon icon3">🔍</div>
                <h3>Track Complaint</h3>
                <p>Check real-time status of your ongoing complaints.</p>
                <div class="arrow">Track Now →</div>
            </a>

            <a href="/customer/profile" class="action-card">
                <div class="action-icon icon4">👤</div>
                <h3>Profile</h3>
                <p>View and update your personal account details.</p>
                <div class="arrow">Manage →</div>
            </a>

        </div>
    </section>

</body>
</html>