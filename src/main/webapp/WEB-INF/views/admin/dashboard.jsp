<!-- Stats Cards -->
<div class="row mt-4">
    <div class="col-md-4">
        <div class="card-stat">
            <h2>${totalAdmins}</h2>
            <p>Total Admins</p>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card-stat">
            <h2>🎫</h2>
            <p>Event Bookings</p>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card-stat">
            <h2>📈</h2>
            <p>Reports Generated</p>
        </div>
    </div>
</div>

<!-- ALL MODULES Navigation -->
<div class="mt-5">
    <h5>🔗 All Modules</h5>
    <div class="row mt-3">

        <!-- Admin Module -->
        <div class="col-md-4 mb-3">
            <div style="background:white; border-radius:12px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.07);">
                <h6>👑 Admin & Reports</h6>
                <a href="/admin/manage" class="btn btn-sm btn-primary me-1 mb-1">Manage Admins</a>
                <a href="/reports" class="btn btn-sm btn-success me-1 mb-1">Reports</a>
            </div>
        </div>

        <!-- User Module -->
        <div class="col-md-4 mb-3">
            <div style="background:white; border-radius:12px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.07);">
                <h6>👤 User Management</h6>
                <a href="/userManagement" class="btn btn-sm btn-primary me-1 mb-1">All Users</a>
                <a href="/register" class="btn btn-sm btn-success me-1 mb-1">Register User</a>
            </div>
        </div>

        <!-- Booking Module -->
        <div class="col-md-4 mb-3">
            <div style="background:white; border-radius:12px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.07);">
                <h6>🎟️ Booking Management</h6>
                <a href="/bookingForm" class="btn btn-sm btn-primary me-1 mb-1">New Booking</a>
                <a href="/myBookings" class="btn btn-sm btn-success me-1 mb-1">View Bookings</a>
            </div>
        </div>

        <!-- Payment Module -->
        <div class="col-md-4 mb-3">
            <div style="background:white; border-radius:12px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.07);">
                <h6>💳 Payment Management</h6>
                <a href="/payment-form" class="btn btn-sm btn-primary me-1 mb-1">Make Payment</a>
                <a href="/payment-receipt" class="btn btn-sm btn-success me-1 mb-1">View Receipt</a>
            </div>
        </div>

        <!-- Event/Venue Module -->
        <div class="col-md-4 mb-3">
            <div style="background:white; border-radius:12px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.07);">
                <h6>🎪 Event & Venue</h6>
                <a href="/venueList" class="btn btn-sm btn-primary me-1 mb-1">Venues</a>
                <a href="/addVenue" class="btn btn-sm btn-success me-1 mb-1">Add Venue</a>
            </div>
        </div>

        <!-- Seat Module -->
        <div class="col-md-4 mb-3">
            <div style="background:white; border-radius:12px; padding:20px; box-shadow:0 2px 10px rgba(0,0,0,0.07);">
                <h6>💺 Seat Management</h6>
                <a href="/seatMapView" class="btn btn-sm btn-primary me-1 mb-1">Seat Map</a>
                <a href="/seatStatusEdit" class="btn btn-sm btn-success me-1 mb-1">Edit Seats</a>
            </div>
        </div>

    </div>
</div>
<div class="sidebar">
    <h4>🎟️ Event Admin</h4>
    <a href="/admin/dashboard">🏠 Dashboard</a>
    <c:if test="${isSuperAdmin}">
        <a href="/admin/manage">👥 Manage Admins</a>
    </c:if>
    <a href="/reports">📊 Reports</a>
    <a href="/userManagement">👤 Users</a>
    <a href="/venueList">🎪 Venues</a>
    <a href="/bookingForm">🎟️ Bookings</a>
    <a href="/payment-form">💳 Payments</a>
    <a href="/seatMapView">💺 Seats</a>
    <a href="/admin/logout">🚪 Logout</a>
</div>