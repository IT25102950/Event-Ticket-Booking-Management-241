<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.eventbookingsystem.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #ffffff;
            color: #1f2937;
            min-height: 100vh;
        }
        .navbar { background-color: #0a0e1a; }
        .navbar-brand, .nav-link, .btn-logout { color: #ffffff !important; }
        .btn-logout { background-color: #e63946; border-color: #e63946; }
        .btn-logout:hover { background-color: #d62839; border-color: #d62839; }
        .page-title { font-weight: 700; color: #0a0e1a; }
        .title-row { align-items: center; justify-content: space-between; }
        .title-row .badge {
            background-color: #0a0e1a;
            color: #ffffff;
            font-weight: 600;
            padding: 0.75rem 1rem;
        }
        .card {
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.08);
        }
        .table thead { background-color: #f8fafc; }
        .table th {
            border-bottom: 1px solid #e5e7eb;
            color: #0a0e1a;
            font-weight: 600;
        }
        .table td { color: #374151; }
        .table tbody tr { background-color: #ffffff; }
        .table tbody tr:hover { background-color: #f8fafc; }
        .badge-role-admin { background-color: #e63946; color: #ffffff; font-weight: 600; }
        .badge-role-user { background-color: #1d4ed8; color: #ffffff; font-weight: 600; }
        .badge-protected {
            background-color: #6b7280;
            color: #ffffff;
            font-weight: 600;
            padding: 0.45rem 0.65rem;
        }
        .btn-delete {
            background-color: #e63946;
            border-color: #e63946;
            color: #ffffff;
            padding: 0.35rem 0.8rem;
            font-size: 0.85rem;
        }
        .btn-delete:hover { background-color: #d62839; border-color: #d62839; }
        .empty-state { padding: 30px; text-align: center; color: #6b7280; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="/users">User Management</a>
        <div>
            <a class="btn btn-logout btn-sm" href="/logout">Logout</a>
        </div>
    </div>
</nav>
<div class="container py-5">
    <div class="d-flex flex-column flex-md-row mb-4 title-row">
        <div>
            <h1 class="page-title mb-2">All Registered Users</h1>
            <p class="text-muted mb-0">Manage user access and view account details.</p>
        </div>
        <% List<User> users = (List<User>) request.getAttribute("users");
           int totalUsers = users != null ? users.size() : 0; %>
        <span class="badge">Total Users: <%= totalUsers %></span>
    </div>
    <div class="card">
        <div class="card-body p-0">

            <!-- Search bar -->
            <div class="px-4 pt-4">
                <div class="row g-2 align-items-center mb-3">
                    <div class="col-md-8">
                        <div class="input-group">
                            <input id="userSearch" type="search"
                                   class="form-control"
                                   placeholder="Search by name or email">
                            <button id="userSearchButton" type="button"
                                    class="btn btn-outline-primary">Search</button>
                        </div>
                    </div>
                </div>
                <div id="noUsersFound"
                     class="alert alert-warning py-2 px-3 mb-3 d-none">
                    No users found.
                </div>
            </div>

            <!-- Users table -->
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th scope="col">User ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Role</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (users != null && !users.isEmpty()) {
                             for (User u : users) { %>
                        <tr>
                            <td><%= String.format("USR%03d", u.getId()) %></td>
                            <td><%= u.getName() %></td>
                            <td><%= u.getEmail() %></td>
                            <td>
                                <% if ("admin".equals(u.getRole())) { %>
                                    <span class="badge badge-role-admin">Admin</span>
                                <% } else { %>
                                    <span class="badge badge-role-user">User</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="/editUser?id=<%= u.getId() %>"
                                   class="btn btn-warning btn-sm me-1">Edit</a>
                                <% if (!"admin".equals(u.getRole())) { %>
                                    <form action="/deleteUser" method="post"
                                          class="d-inline">
                                        <input type="hidden" name="userId"
                                               value="<%= u.getId() %>">
                                        <button type="submit"
                                                class="btn btn-delete btn-sm"
                                                onclick="return confirm('Are you sure?')">
                                            Delete
                                        </button>
                                    </form>
                                <% } else { %>
                                    <span class="badge badge-protected">Protected</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="5" class="empty-state">
                                No registered users were found.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Search JavaScript -->
<script>
    (function() {
        var searchInput = document.getElementById('userSearch');
        var searchButton = document.getElementById('userSearchButton');
        var tableBody = document.querySelector('.table tbody');
        var noResults = document.getElementById('noUsersFound');

        function filterUsers() {
            var query = searchInput.value.trim().toLowerCase();
            var rows = tableBody.querySelectorAll('tr');
            var visibleCount = 0;
            rows.forEach(function(row) {
                var nameCell = row.querySelector('td:nth-child(2)');
                var emailCell = row.querySelector('td:nth-child(3)');
                if (!nameCell || !emailCell) return;
                var nameText = nameCell.textContent.trim().toLowerCase();
                var emailText = emailCell.textContent.trim().toLowerCase();
                var matches = !query ||
                    nameText.indexOf(query) !== -1 ||
                    emailText.indexOf(query) !== -1;
                row.style.display = matches ? '' : 'none';
                if (matches) visibleCount++;
            });
            noResults.classList.toggle('d-none', visibleCount > 0);
        }

        searchInput.addEventListener('input', filterUsers);
        searchButton.addEventListener('click', filterUsers);
    })();
</script>

</body>
</html>