<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0a0e27;
            color: #e2e8f0;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        .bg-blob {
            position: fixed;
            width: 500px; height: 500px;
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
            position: fixed; top:0; left:0; right:0; bottom:0;
            background-image:
                linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
            background-size: 40px 40px;
            z-index: 0;
        }

        nav {
            position: relative; z-index: 2;
            display: flex; align-items: center; justify-content: space-between;
            padding: 22px 60px;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        .logo { font-size: 19px; font-weight: 800; color: #fff; }
        .logo span { color: #a5b4fc; }
        .back-link {
            color: #a5b4fc;
            text-decoration: none;
            font-size: 13.5px;
            font-weight: 600;
        }
        .back-link:hover { text-decoration: underline; }

        .container {
            position: relative;
            z-index: 1;
            max-width: 600px;
            margin: 50px auto;
            padding: 0 20px;
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

        h1 {
            color: #fff;
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 30px;
        }

        .profile-card {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 22px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.5);
        }

        .photo-wrapper {
            position: relative;
            width: 130px;
            height: 130px;
            margin: 0 auto 20px;
        }

        .profile-photo {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid rgba(99, 102, 241, 0.5);
        }

        .avatar-fallback {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #ec4899);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: 700;
            color: #fff;
        }

        .upload-btn {
            position: absolute;
            bottom: 4px;
            right: 4px;
            width: 36px;
            height: 36px;
            background: #6366f1;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 3px solid #0a0e27;
            font-size: 15px;
        }

        #photoInput { display: none; }

        .profile-name {
            color: #fff;
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .profile-role {
            color: #a5b4fc;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 30px;
        }

        .info-list {
            text-align: left;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 16px 0;
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }
        .info-item:last-child { border-bottom: none; }

        .info-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: rgba(99, 102, 241, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
            flex-shrink: 0;
        }

        .info-text label {
            display: block;
            color: #64748b;
            font-size: 11.5px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 3px;
        }

        .info-text span {
            color: #e2e8f0;
            font-size: 15px;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <div class="bg-blob blob1"></div>
    <div class="bg-blob blob2"></div>
    <div class="grid-overlay"></div>

    <nav>
        <div class="logo">Complaint<span>Portal</span></div>
        <a href="/customer/dashboard" class="back-link">← Back to Dashboard</a>
    </nav>

    <div class="container">
        <span class="badge">👤 My Account</span>
        <h1>Profile</h1>

        <div class="profile-card">

            <form action="/customer/profile/upload-photo" method="post" enctype="multipart/form-data" id="photoForm">
                <div class="photo-wrapper">
                    <c:choose>
                        <c:when test="${not empty user.photoUrl}">
                            <img src="${user.photoUrl}" class="profile-photo" alt="Profile Photo">
                        </c:when>
                        <c:otherwise>
                            <div class="avatar-fallback">${fn:toUpperCase(fn:substring(user.name, 0, 1))}</div>
                        </c:otherwise>
                    </c:choose>

                    <label for="photoInput" class="upload-btn">📷</label>
                    <input type="file" name="photo" id="photoInput" accept="image/*" onchange="document.getElementById('photoForm').submit();">
                </div>
            </form>

            <div class="profile-name">${fn:toUpperCase(fn:substring(user.name, 0, 1))}${fn:substring(user.name, 1, fn:length(user.name))}</div>
            <div class="profile-role">${user.role}</div>

            <div class="info-list">
                <div class="info-item">
                    <div class="info-icon">👤</div>
                    <div class="info-text">
                        <label>Full Name</label>
                        <span>${user.name}</span>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">✉️</div>
                    <div class="info-text">
                        <label>Email Address</label>
                        <span>${user.email}</span>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">📱</div>
                    <div class="info-text">
                        <label>Phone Number</label>
                        <span>${user.phone}</span>
                    </div>
                </div>
            </div>

        </div>
    </div>

</body>
</html>