<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Smart Complaint & Service Management Portal</title>
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
            overflow-x: hidden;
        }

        /* ===== Background blobs ===== */
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

        /* ===== Navbar ===== */
        nav {
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 22px 60px;
        }

        .logo {
            font-size: 20px;
            font-weight: 800;
            color: #ffffff;
            letter-spacing: 0.5px;
        }
        .logo span { color: #a5b4fc; }

        .nav-links a {
            color: #cbd5e1;
            text-decoration: none;
            margin-left: 28px;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.25s;
        }
        .nav-links a:hover { color: #ffffff; }

        .nav-btn {
            background: linear-gradient(135deg, #6366f1, #ec4899);
            padding: 9px 22px !important;
            border-radius: 8px;
            color: #fff !important;
        }

        /* ===== Hero ===== */
        .hero {
            position: relative;
            z-index: 1;
            text-align: center;
            padding: 60px 20px 30px;
        }

        .badge {
            display: inline-block;
            padding: 6px 16px;
            background: rgba(99, 102, 241, 0.15);
            border: 1px solid rgba(99, 102, 241, 0.4);
            color: #a5b4fc;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            border-radius: 50px;
            margin-bottom: 24px;
        }

        h1 {
            font-size: 40px;
            font-weight: 800;
            line-height: 1.3;
            max-width: 780px;
            margin: 0 auto 18px;
            background: linear-gradient(90deg, #ffffff, #a5b4fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            color: #94a3b8;
            font-size: 16px;
            max-width: 560px;
            margin: 0 auto 10px;
            line-height: 1.7;
        }

        /* ===== Role Login Section ===== */
        .role-section {
            position: relative;
            z-index: 1;
            padding: 40px 60px 30px;
        }

        .role-section h2 {
            text-align: center;
            color: #fff;
            font-size: 22px;
            margin-bottom: 8px;
        }
        .role-section > p {
            text-align: center;
            color: #94a3b8;
            font-size: 14px;
            margin-bottom: 40px;
        }

        .role-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 26px;
            max-width: 980px;
            margin: 0 auto;
        }

        .role-card {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 18px;
            padding: 36px 28px;
            text-align: center;
            transition: all 0.35s ease;
        }
        .role-card:hover {
            border-color: rgba(99,102,241,0.55);
            transform: translateY(-8px);
            box-shadow: 0 18px 40px rgba(99,102,241,0.28);
        }

        .role-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 18px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }
        .icon-customer { background: linear-gradient(135deg, #6366f1, #818cf8); }
        .icon-admin { background: linear-gradient(135deg, #ec4899, #f472b6); }
        .icon-agent { background: linear-gradient(135deg, #10b981, #34d399); }

        .role-card h3 {
            color: #fff;
            font-size: 19px;
            margin-bottom: 10px;
        }

        .role-card p.desc {
            color: #94a3b8;
            font-size: 13.5px;
            line-height: 1.6;
            margin-bottom: 24px;
            min-height: 42px;
        }

        a.role-btn {
            display: inline-block;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            color: #fff;
            width: 100%;
            transition: all 0.3s ease;
        }

        .btn-customer { background: linear-gradient(135deg, #6366f1, #818cf8); box-shadow: 0 8px 20px rgba(99,102,241,0.35); }
        .btn-admin { background: linear-gradient(135deg, #ec4899, #f472b6); box-shadow: 0 8px 20px rgba(236,72,153,0.35); }
        .btn-agent { background: linear-gradient(135deg, #10b981, #34d399); box-shadow: 0 8px 20px rgba(16,185,129,0.35); }

        a.role-btn:hover { transform: translateY(-3px); filter: brightness(1.1); }

        .register-note {
            text-align: center;
            margin-top: 40px;
            color: #94a3b8;
            font-size: 14px;
        }
        .register-note a {
            color: #a5b4fc;
            font-weight: 600;
            text-decoration: none;
        }
        .register-note a:hover { text-decoration: underline; }

        /* ===== Features ===== */
        .features {
            position: relative;
            z-index: 1;
            padding: 20px 60px 90px;
        }

        .features h2 {
            text-align: center;
            color: #fff;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .features > p {
            text-align: center;
            color: #94a3b8;
            font-size: 14px;
            margin-bottom: 45px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            max-width: 1100px;
            margin: 0 auto;
        }

        .card {
            background: rgba(255,255,255,0.04);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 16px;
            padding: 26px 22px;
            transition: all 0.3s ease;
        }
        .card:hover {
            border-color: rgba(99,102,241,0.4);
            transform: translateY(-5px);
        }

        .card .icon { font-size: 24px; margin-bottom: 12px; }
        .card h3 { color: #fff; font-size: 16px; margin-bottom: 8px; }
        .card ul { list-style: none; padding: 0; }
        .card ul li {
            color: #94a3b8;
            font-size: 13px;
            margin-bottom: 5px;
            padding-left: 14px;
            position: relative;
        }
        .card ul li::before {
            content: "›";
            position: absolute;
            left: 0;
            color: #a5b4fc;
        }

        footer {
            position: relative;
            z-index: 1;
            text-align: center;
            padding: 26px;
            color: #475569;
            font-size: 12px;
            letter-spacing: 0.5px;
            border-top: 1px solid rgba(255,255,255,0.06);
        }
    </style>
</head>
<body>

    <div class="bg-blob blob1"></div>
    <div class="bg-blob blob2"></div>
    <div class="grid-overlay"></div>

    <nav>
        <div class="logo">Complaint<span>Portal</span></div>
        <div class="nav-links">
            <a href="#roles">Login</a>
            <a href="#features">Features</a>
            <a href="registration" class="nav-btn">Register</a>
        </div>
    </nav>

    <section class="hero">
        <span class="badge">⚡ Next-Gen Support System</span>
        <h1>Smart Complaint &amp; Service Management Portal</h1>
        <p>Fast. Transparent. Reliable. Automate complaint registration, tracking, and resolution — all in one intelligent platform.</p>
    </section>

    <section class="role-section" id="roles">
        <h2>Login to Your Portal</h2>
        <p>Choose your role to continue</p>

        <div class="role-grid">
            <div class="role-card">
                <div class="role-icon icon-customer">🙋</div>
                <h3>Customer</h3>
                <p class="desc">Raise complaints, track status, and view your complaint history.</p>
                <a href="login?role=customer" class="role-btn btn-customer">Customer Login</a>
            </div>

            <div class="role-card">
                <div class="role-icon icon-admin">🛡️</div>
                <h3>Admin</h3>
                <p class="desc">Manage users, assign complaints, and monitor system analytics.</p>
                <a href="login?role=admin" class="role-btn btn-admin">Admin Login</a>
            </div>

            <div class="role-card">
                <div class="role-icon icon-agent">🎧</div>
                <h3>Support Agent</h3>
                <p class="desc">View assigned complaints, update status, and close resolved cases.</p>
                <a href="login?role=agent" class="role-btn btn-agent">Agent Login</a>
            </div>
        </div>

        <p class="register-note">New customer? <a href="registration">Create an account</a></p>
    </section>

    <section class="features" id="features">
        <h2>What This Portal Offers</h2>
        <p>SECURE • AI-POWERED • REAL-TIME TRACKING</p>

        <div class="grid">
            <div class="card">
                <div class="icon">📋</div>
                <h3>Complaint Registration</h3>
                <ul>
                    <li>Raise complaint online</li>
                    <li>Upload complaint details</li>
                    <li>View complaint history</li>
                </ul>
            </div>

            <div class="card">
                <div class="icon">📊</div>
                <h3>Admin Analytics</h3>
                <ul>
                    <li>Manage users & services</li>
                    <li>Assign complaints to agents</li>
                    <li>View reports & analytics</li>
                </ul>
            </div>

            <div class="card">
                <div class="icon">🔄</div>
                <h3>Real-Time Tracking</h3>
                <ul>
                    <li>Live complaint status</li>
                    <li>Resolution remarks</li>
                    <li>Instant notifications</li>
                </ul>
            </div>
        </div>
    </section>

    <footer>
        © 2026 Smart Complaint & Service Management Portal — Wipro TalentNext Project
    </footer>

</body>
</html>