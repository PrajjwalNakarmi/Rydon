<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Rydon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/dashboard.css" />
    
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        .chart-section {
            width: 95%;
            margin: 40px auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }
        .chart-container {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">Rydon Admin</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/manageuser">Manage Users</a>
        <a href="${pageContext.request.contextPath}/manageproduct">Manage Rentals</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<!-- Banner -->
<section class="rent-banner">
    <h1>Welcome, Admin</h1>
    <p>Manage users, rentals, and view system statistics here.</p>
</section>

<!-- Dashboard Cards -->
<section class="bike-list">
    <!-- Card 1 -->
    <div class="bike-card">
        <h2>Total Users</h2>
        <p>150</p>
        <a href="${pageContext.request.contextPath}/admin/users" class="rent-now">Manage Users</a>
    </div>

    <!-- Card 2 -->
    <div class="bike-card">
        <h2>Total Rentals</h2>
        <p>320</p>
        <a href="${pageContext.request.contextPath}/admin/rentals" class="rent-now">View Rentals</a>
    </div>

    <!-- Card 3 -->
    <div class="bike-card">
        <h2>Active Rentals</h2>
        <p>45</p>
        <a href="${pageContext.request.contextPath}/admin/rentals?filter=active" class="rent-now">Active Rentals</a>
    </div>

    <!-- Card 4 -->
    <div class="bike-card">
        <h2>Revenue</h2>
        <p>$7,850</p>
        <a href="#" class="rent-now">View Reports</a>
    </div>
</section>

<!-- Charts Section -->
<section class="chart-section">

    <div class="chart-container">
        <h3 style="text-align:center;">Monthly Revenue</h3>
        <canvas id="revenueChart"></canvas>
    </div>

    <div class="chart-container">
        <h3 style="text-align:center;">User Registrations</h3>
        <canvas id="userChart"></canvas>
    </div>

</section>

<script>
    // Revenue Chart
    const revenueCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revenueCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Revenue ($)',
                data: [1200, 1900, 3000, 2500, 3200, 4000],
                backgroundColor: 'rgba(255, 102, 0, 0.2)',
                borderColor: '#ff6600',
                borderWidth: 2,
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // User Registrations Chart
    const userCtx = document.getElementById('userChart').getContext('2d');
    new Chart(userCtx, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'New Users',
                data: [50, 70, 90, 60, 80, 120],
                backgroundColor: '#ff8533',
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

</body>
</html>
