<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Registration</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0a0e27;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 0;
            overflow: hidden;
            position: relative;
        }

        .bg-blob {
            position: fixed;
            width: 500px;
            height: 500px;
            border-radius: 50%;
            filter: blur(130px);
            opacity: 0.4;
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

        .register-container {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 46px 42px;
            border-radius: 22px;
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.5);
            width: 90%;
            max-width: 420px;
            animation: fadeUp 0.7s ease;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .badge {
            display: block;
            width: fit-content;
            margin: 0 auto 20px;
            padding: 6px 16px;
            background: rgba(99, 102, 241, 0.15);
            border: 1px solid rgba(99, 102, 241, 0.4);
            color: #a5b4fc;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            border-radius: 50px;
        }

        h1 {
            text-align: center;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #94a3b8;
            font-size: 13.5px;
            margin-bottom: 26px;
        }

        .success-msg {
            background: rgba(16, 185, 129, 0.12);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #6ee7b7;
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 13.5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            color: #cbd5e1;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 7px;
            letter-spacing: 0.3px;
        }

        input {
            width: 100%;
            padding: 12px 16px;
            background: rgba(255, 255, 255, 0.05);
            border: 1.5px solid rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            color: #fff;
            font-size: 14.5px;
            outline: none;
            transition: all 0.3s ease;
        }

        input::placeholder { color: #64748b; }

        input:focus {
            border-color: #6366f1;
            background: rgba(99, 102, 241, 0.08);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 8px;
            background: linear-gradient(135deg, #6366f1, #ec4899);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
            transition: all 0.3s ease;
        }

        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(99, 102, 241, 0.6);
        }

        .login-link {
            text-align: center;
            margin-top: 24px;
            color: #94a3b8;
            font-size: 13.5px;
        }

        .login-link a {
            color: #a5b4fc;
            font-weight: 600;
            text-decoration: none;
        }

        .login-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <div class="bg-blob blob1"></div>
    <div class="bg-blob blob2"></div>
    <div class="grid-overlay"></div>

    <div class="register-container">
        <span class="badge">⚡ Join the Portal</span>
        <h1>Create Account</h1>
        <p class="subtitle">Register to raise and track your complaints</p>

        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div class="success-msg"><%= message %></div>
        <%
            }
        %>

        <form action="register" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="John Doe" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="9876543210" required>
            </div>

            <button type="submit">Create Account</button>
        </form>

        <p class="login-link">Already have an account? <a href="login">Login</a></p>
    </div>

</body>
</html>