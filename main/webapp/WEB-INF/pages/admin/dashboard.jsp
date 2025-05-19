
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,com.Rydon.service.DashboardService,com.Rydon.Model.BicycleModel,com.Rydon.Model.ModelModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Rydon</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/dashboard.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .modal {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: rgba(0,0,0,0.6);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
        }
        .modal-content {
            background-color: white;
            padding: 2em;
            width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            border-radius: 10px;
            position: relative;
        }
        .modal .close {
            position: absolute;
            top: 10px; right: 15px;
            font-size: 24px;
            cursor: pointer;
        }
        .crud-action.delete {
            background-color: #ff3333;
            color: white;
            margin-left: 5px;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }
        .crud-action.edit, .crud-action.view {
            background-color: #007bff;
            color: white;
            margin-left: 5px;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            position: relative;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        .alert-dismissible .btn-close {
            position: absolute;
            top: 10px;
            right: 10px;
            background: transparent;
            border: 0;
            font-size: 1.2rem;
            cursor: pointer;
        }
        .form-group {
            margin-bottom: 1em;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5em;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 0.5em;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group button {
            padding: 0.5em 1em;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%
DashboardService dashboardService = null;
List<BicycleModel> bicycles = null;
List<ModelModel> models = null;
Map<Integer, String> modelIdNameMap = new HashMap<>();
Map<Integer, Double> modelIdRateMap = new HashMap<>();
Map<String, Integer> userRegistrations = null;
int totalUsers = 0;
int totalRentals = 0;
int activeRentals = 0;
double totalRevenue = 0;

try {
    dashboardService = new DashboardService();
    bicycles = dashboardService.getAllBicycles();
    models = dashboardService.getAllModels();
    
    if (models != null) {
        for (ModelModel m : models) {
            modelIdNameMap.put(m.getModelId(), m.getModelName());
            modelIdRateMap.put(m.getModelId(), m.getHourlyRate());
        }
    }
    
    userRegistrations = dashboardService.getMonthlyUserRegistrations();
    totalUsers = dashboardService.getTotalUsers();
    totalRentals = dashboardService.getTotalBicycles();
    activeRentals = dashboardService.getActiveRentals();
    totalRevenue = dashboardService.getTotalRevenue();
} catch (Exception e) {
    request.setAttribute("errorMessage", "Error loading dashboard data: " + e.getMessage());
}
%>

<jsp:include page="adminHeader.jsp" />

<section class="rent-banner">
    <h1>Welcome, Admin</h1>
    <p>Manage users, rentals, and view system statistics here.</p>
</section>

<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger alert-dismissible" role="alert">
        ${errorMessage}
        <button type="button" class="btn-close" aria-label="Close">×</button>
    </div>
</c:if>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success alert-dismissible" role="alert">
        ${successMessage}
        <button type="button" class="btn-close" aria-label="Close">×</button>
    </div>
</c:if>

<section class="bike-list">
    <div class="bike-card">
        <h2>Total Users</h2>
        <p><%= totalUsers %></p>
        <a href="${pageContext.request.contextPath}/admin/users" class="rent-now">Manage Users</a>
    </div>
    <div class="bike-card">
        <h2>Total Rentals</h2>
        <p><%= totalRentals %></p>
        <a href="${pageContext.request.contextPath}/admin/rentals" class="rent-now">View Rentals</a>
    </div>
    <div class="bike-card">
        <h2>Active Rentals</h2>
        <p><%= activeRentals %></p>
        <a href="${pageContext.request.contextPath}/admin/rentals?filter=active" class="rent-now">Active Rentals</a>
    </div>
    <div class="bike-card">
        <h2>Revenue</h2>
        <p>$<%= String.format("%.2f", totalRevenue) %></p>
        <a href="#" class="rent-now">View Reports</a>
    </div>
</section>

<section class="chart-section">
    <div class="chart-container"><h3>Monthly Revenue</h3><canvas id="revenueChart"></canvas></div>
    <div class="chart-container"><h3>User Registrations</h3><canvas id="userChart"></canvas></div>
</section>

<section class="crud-section">
    <div class="crud-header">
        <h2>Rental Inventory</h2>
        <button class="crud-button" onclick="openAddModal()">+ Add Rental</button>
    </div>
    <table class="crud-table">
        <thead>
        <tr>
            <th>ID</th><th>Bike Model</th><th>Status</th><th>Price ($/hr)</th><th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (bicycles != null && !bicycles.isEmpty()) {
            for (BicycleModel bike : bicycles) {
                String modelName = modelIdNameMap.getOrDefault(bike.getModelId(), "Unknown Model");
                String status = bike.getConditionRating() >= 5 ? "Available" : "Needs Repair";
                Double hourlyRate = modelIdRateMap.get(bike.getModelId());
                String rateDisplay = hourlyRate != null ? String.format("%.2f", hourlyRate) : "N/A";
        %>
        <tr data-id="<%= bike.getBicycleId() %>">
            <td><%= bike.getBicycleId() %></td>
            <td><%= modelName %></td>
            <td><%= status %></td>
            <td><%= rateDisplay %></td>
            <td>
                <button class="crud-action view" onclick="openViewModal(<%= bike.getBicycleId() %>)">View</button>
                <button class="crud-action edit" onclick="openEditModal(<%= bike.getBicycleId() %>)">Edit</button>
                <form method="post" action="${pageContext.request.contextPath}/dashboard" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= bike.getBicycleId() %>">
                    <button type="submit" class="crud-action delete" onclick="return confirm('Are you sure you want to delete this bicycle?')">Delete</button>
                </form>
            </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="5" style="text-align:center;">No rentals found.</td></tr>
        <% } %>
        </tbody>
    </table>
</section>

<div id="viewModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('viewModal')">×</span>
        <div id="viewContent">Loading...</div>
    </div>
</div>
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('addModal')">×</span>
        <div id="addContent">
            <h2>Add New Bicycle</h2>
            <form id="addBicycleForm" action="${pageContext.request.contextPath}/dashboard" method="post">
                <div class="form-group">
                    <label for="addLocation">Location</label>
                    <input type="text" id="addLocation" name="location" required>
                </div>
                <div class="form-group">
                    <label for="addConditionRating">Condition Rating (1-10)</label>
                    <input type="number" id="addConditionRating" name="conditionRating" min="1" max="10" required>
                </div>
                <div class="form-group">
                    <label for="addModelId">Model</label>
                    <select id="addModelId" name="modelId" required>
                        <% if (models != null && !models.isEmpty()) {
                            for (ModelModel model : models) {
                                String rateDisplay = model.getHourlyRate() != null ? "$" + String.format("%.2f", model.getHourlyRate()) : "N/A";
                        %>
                                <option value="<%= model.getModelId() %>"><%= model.getModelName() %> (<%= rateDisplay %>/hr)</option>
                        <% }} else { %>
                                <option value="">No models available</option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="addImagePath">Image Path</label>
                    <input type="text" id="addImagePath" name="imagePath">
                </div>
                <div class="form-group">
                    <button type="submit">Add Bicycle</button>
                </div>
                <input type="hidden" name="action" value="add">
            </form>
        </div>
    </div>
</div>
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('editModal')">×</span>
        <div id="editContent">
            <h2>Edit Bicycle</h2>
            <form id="editBicycleForm" action="${pageContext.request.contextPath}/dashboard" method="post">
                <input type="hidden" name="bicycleId" id="bicycleId">
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" name="location" required>
                </div>
                <div class="form-group">
                    <label for="conditionRating">Condition Rating (1-10)</label>
                    <input type="number" id="conditionRating" name="conditionRating" min="1" max="10" required>
                </div>
                <div class="form-group">
                    <label for="modelId">Model</label>
                    <select id="modelId" name="modelId" required>
                        <!-- Populated dynamically -->
                    </select>
                </div>
                <div class="form-group">
                    <label for="imagePath">Image Path</label>
                    <input type="text" id="imagePath" name="imagePath">
                </div>
                <div class="form-group">
                    <button type="submit">Update Bicycle</button>
                </div>
                <input type="hidden" name="action" value="update">
            </form>
        </div>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    function openModal(id) {
        document.getElementById(id).style.display = 'flex';
    }

    function closeModal(id) {
        document.getElementById(id).style.display = 'none';
    }

    function openViewModal(id) {
        openModal('viewModal');
        fetch(contextPath + '/view?id=' + id, { method: 'GET' })
            .then(res => {
                if (!res.ok) throw new Error('Failed to fetch view data');
                return res.text();
            })
            .then(html => {
                document.getElementById('viewContent').innerHTML = html;
            })
            .catch(err => {
                console.error('Error fetching view data:', err);
                document.getElementById('viewContent').innerHTML = 'Error loading bicycle details.';
                showAlert('danger', 'Failed to load bicycle details.');
            });
    }

    function openAddModal() {
        openModal('addModal');
        const form = document.getElementById('addBicycleForm');
        form.reset();
    }

    function openEditModal(id) {
        openModal('editModal');
        fetch(contextPath + '/edit?id=' + id, { method: 'GET' })
            .then(res => {
                if (!res.ok) throw new Error('Failed to fetch edit data');
                return res.json();
            })
            .then(data => {
                if (data.success) {
                    const { bicycle, models } = data;
                    document.getElementById('bicycleId').value = bicycle.bicycleId;
                    document.getElementById('location').value = bicycle.location || '';
                    document.getElementById('conditionRating').value = bicycle.conditionRating;
                    document.getElementById('imagePath').value = bicycle.imagePath || '';

                    const modelSelect = document.getElementById('modelId');
                    modelSelect.innerHTML = models.map(model => 
                        `<option value="${model.modelId}" ${model.modelId == bicycle.modelId ? 'selected' : ''}>${model.modelName} (${model.hourlyRate != null ? '$' + model.hourlyRate.toFixed(2) : 'N/A'}/hr)</option>`
                    ).join('');
                } else {
                    document.getElementById('editContent').innerHTML = 'Error loading bicycle data.';
                    showAlert('danger', data.message);
                }
            })
            .catch(err => {
                console.error('Error fetching edit data:', err);
                document.getElementById('editContent').innerHTML = 'Error loading edit form.';
                showAlert('danger', 'Failed to load edit form: ' + err.message);
            });

        const form = document.getElementById('editBicycleForm');
        form.removeEventListener('submit', handleEditSubmit);
        form.addEventListener('submit', handleEditSubmit);
    }

    function handleEditSubmit(event) {
        event.preventDefault();
        const form = event.target;
        const formData = new FormData(form);

        fetch(contextPath + '/dashboard', {
            method: 'POST',
            body: formData
        })
        .then(res => {
            if (!res.ok) throw new Error('Failed to update bicycle');
            return res.json();
        })
        .then(data => {
            if (data.success) {
                const row = document.querySelector(`tr[data-id="${data.bicycle.id}"]`);
                if (row) {
                    row.children[1].textContent = data.bicycle.modelName;
                    row.children[2].textContent = data.bicycle.status;
                    row.children[3].textContent = data.bicycle.hourlyRate != null ? data.bicycle.hourlyRate.toFixed(2) : 'N/A';
                }
                closeModal('editModal');
                showAlert('success', data.message);
            } else {
                showAlert('danger', data.message || 'Failed to update bicycle');
            }
        })
        .catch(err => {
            console.error('Error updating bicycle:', err);
            showAlert('danger', 'Error updating bicycle: ' + err.message);
        });
    }

    function showAlert(type, message) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} alert-dismissible`;
        alertDiv.role = 'alert';
        alertDiv.innerHTML = `
            ${message}
            <button type="button" class="btn-close" aria-label="Close">×</button>
        `;
        document.body.prepend(alertDiv);

        alertDiv.querySelector('.btn-close').addEventListener('click', () => {
            alertDiv.remove();
        });

        setTimeout(() => alertDiv.remove(), 5000);
    }

    document.addEventListener('DOMContentLoaded', function() {
        const closeButtons = document.querySelectorAll('.btn-close');
        closeButtons.forEach(button => {
            button.addEventListener('click', function() {
                const alert = this.closest('.alert');
                if (alert) alert.remove();
            });
        });
    });

    // Revenue chart (placeholder data)
    new Chart(document.getElementById('revenueChart').getContext('2d'), {
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
            scales: { y: { beginAtZero: true } }
        }
    });

    // User registrations chart
    <% if (userRegistrations != null && !userRegistrations.isEmpty()) { %>
    new Chart(document.getElementById('userChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: [<%= String.join(", ", userRegistrations.keySet().stream().map(m -> "'" + m + "'").toArray(String[]::new)) %>],
            datasets: [{
                label: 'New Users',
                data: [<%= userRegistrations.values().stream().map(String::valueOf).collect(java.util.stream.Collectors.joining(", ")) %>],
                backgroundColor: '#ff8533',
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            scales: { y: { beginAtZero: true } }
        }
    });
    <% } else { %>
    new Chart(document.getElementById('userChart').getContext('2d'), {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'New Users',
                data: [0, 0, 0, 0, 0, 0],
                backgroundColor: '#ff8533',
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            scales: { y: { beginAtZero: true } }
        }
    });
    <% } %>
</script>

</body>
</html>
