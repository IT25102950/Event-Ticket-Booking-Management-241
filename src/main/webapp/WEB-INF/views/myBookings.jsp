<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #0a1628; font-family: 'Segoe UI', sans-serif; min-height: 100vh; }
        .navbar { background: #0d1f38 !important; border-bottom: 1px solid rgba(255,255,255,0.08); }
        .navbar-brand { color: #c9d8f0 !important; font-size: 18px; font-weight: 600; }
        .btn-new { background: linear-gradient(135deg, #1e4d8c, #2a6bc7); color: white; border: none; font-size: 13px; padding: 8px 18px; border-radius: 8px; transition: all 0.3s; }
        .btn-new:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(42,107,199,0.4); color: white; }
        .page-title { color: #ffffff; font-size: 26px; font-weight: 600; margin-bottom: 4px; }
        .page-subtitle { color: #6b82a0; font-size: 13px; margin-bottom: 28px; }
        .search-box { background: rgba(255,255,255,0.04); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; padding: 6px 6px 6px 16px; display: flex; align-items: center; gap: 8px; margin-bottom: 24px; }
        .search-box input { background: transparent; border: none; outline: none; color: #e8edf5; font-size: 14px; flex: 1; }
        .search-box input::placeholder { color: #3d5470; }
        .search-box button { background: linear-gradient(135deg, #1e4d8c, #2a6bc7); color: white; border: none; padding: 8px 18px; border-radius: 7px; font-size: 13px; cursor: pointer; transition: all 0.2s; }
        .search-box button:hover { background: linear-gradient(135deg, #2a6bc7, #3a85e8); }
        .btn-clear { background: transparent; border: 1px solid rgba(255,255,255,0.15); color: #8fa3bf; padding: 8px 14px; border-radius: 7px; font-size: 13px; cursor: pointer; transition: all 0.2s; text-decoration: none; }
        .btn-clear:hover { border-color: rgba(255,255,255,0.3); color: #c9d8f0; }
        .table-card { background: #0d1f38; border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; overflow: hidden; }
        .table { margin: 0; color: #e8edf5; background: transparent; }
        .table thead th { background: rgba(255,255,255,0.05); color: #8fa3bf; font-size: 11px; text-transform: uppercase; letter-spacing: 0.8px; font-weight: 500; border-bottom: 1px solid rgba(255,255,255,0.08); padding: 14px 16px; border-color: rgba(255,255,255,0.08); }
        .table tbody td { border-bottom: 1px solid rgba(255,255,255,0.04); padding: 14px 16px; vertical-align: middle; font-size: 14px; color: #c9d8f0; background: transparent; border-color: rgba(255,255,255,0.04); }
        .table tbody tr:last-child td { border-bottom: none; }
        .table tbody tr:hover td { background: rgba(255,255,255,0.03); }
        .event-name { color: #ffffff; font-weight: 500; }
        .event-type { color: #6b82a0; font-size: 12px; }
        .badge-vip { background: rgba(234,179,8,0.15); color: #eab308; font-size: 11px; padding: 3px 10px; border-radius: 10px; font-weight: 500; }
        .badge-std { background: rgba(74,127,193,0.15); color: #7eb3f5; font-size: 11px; padding: 3px 10px; border-radius: 10px; font-weight: 500; }
        .badge-confirmed { background: rgba(34,197,94,0.15); color: #4ade80; font-size: 11px; padding: 3px 10px; border-radius: 10px; font-weight: 500; }
        .badge-cancelled { background: rgba(239,68,68,0.15); color: #f87171; font-size: 11px; padding: 3px 10px; border-radius: 10px; font-weight: 500; }
        .btn-edit { background: rgba(74,127,193,0.15); color: #7eb3f5; border: 1px solid rgba(74,127,193,0.3); padding: 6px 14px; border-radius: 7px; font-size: 12px; text-decoration: none; transition: all 0.2s; }
        .btn-edit:hover { background: rgba(74,127,193,0.3); color: #c9d8f0; }
        .btn-cancel { background: rgba(239,68,68,0.1); color: #f87171; border: 1px solid rgba(239,68,68,0.2); padding: 6px 14px; border-radius: 7px; font-size: 12px; text-decoration: none; transition: all 0.2s; }
        .btn-cancel:hover { background: rgba(239,68,68,0.25); color: #fca5a5; }
        .empty-state { text-align: center; padding: 60px 20px; color: #6b82a0; }
        .empty-state .icon { font-size: 48px; margin-bottom: 16px; }
        .alert-success-custom { background: rgba(34,197,94,0.1); border: 1px solid rgba(34,197,94,0.2); color: #4ade80; padding: 12px 16px; border-radius: 10px; margin-bottom: 20px; font-size: 13px; }
        .alert-error-custom { background: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.2); color: #f87171; padding: 12px 16px; border-radius: 10px; margin-bottom: 20px; font-size: 13px; }
        .price-text { color: #4ade80; font-weight: 500; }
    </style>
</head>
<body>

<nav class="navbar px-4">
    <span class="navbar-brand">🎟️ EventTicket</span>
    <a href="${pageContext.request.contextPath}/booking" class="btn btn-new">+ New Booking</a>
</nav>

<div class="container py-5">

    <div class="page-title">📋 My Bookings</div>
    <div class="page-subtitle">View and manage all your ticket bookings</div>

    <% if (request.getParameter("deleted") != null) { %>
    <div class="alert-success-custom">✅ Booking cancelled successfully!</div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert-error-custom">❌ Something went wrong. Please try again.</div>
    <% } %>

    <!-- Search Bar -->
    <form action="${pageContext.request.contextPath}/viewBookings" method="get">
        <div class="search-box">
            <span style="color:#6b82a0;">🔍</span>
            <input type="text" name="userId"
                   placeholder="Search by User ID..."
                   value="${searchedUserId}">
            <button type="submit">Search</button>
            <a href="${pageContext.request.contextPath}/viewBookings" class="btn-clear">Clear</a>
        </div>
    </form>

    <!-- Bookings Table -->
    <div class="table-card">
        <table class="table">
            <thead>
            <tr>
                <th>#</th>
                <th>User ID</th>
                <th>Event</th>
                <th>Type</th>
                <th>Seat</th>
                <th>Seats</th>
                <th>Date</th>
                <th>Price</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="booking" items="${bookings}">
                <tr>
                    <td>${booking.bookingId}</td>
                    <td>${booking.userId}</td>
                    <td>
                        <div class="event-name">${booking.eventName}</div>
                        <div class="event-type">${booking.eventType}</div>
                    </td>
                    <td>
                            <span class="${booking.bookingType == 'VIP' ? 'badge-vip' : 'badge-std'}">
                                    ${booking.bookingType == 'VIP' ? '⭐ VIP' : '🎫 STANDARD'}
                            </span>
                    </td>
                    <td>${booking.seatNumber}</td>
                    <td>${booking.numSeats}</td>
                    <td>${booking.bookingDate}</td>
                    <td class="price-text">$${booking.totalPrice}</td>
                    <td>
                            <span class="${booking.status == 'CONFIRMED' ? 'badge-confirmed' : 'badge-cancelled'}">
                                    ${booking.status == 'CONFIRMED' ? '✅ Confirmed' : '❌ Cancelled'}
                            </span>
                    </td>
                    <td>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/updateBooking?bookingId=${booking.bookingId}"
                               class="btn-edit">Edit</a>
                            <a href="${pageContext.request.contextPath}/cancelBooking?bookingId=${booking.bookingId}"
                               class="btn-cancel"
                               onclick="return confirm('Are you sure you want to cancel this booking?')">Cancel</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty bookings}">
                <tr>
                    <td colspan="10">
                        <div class="empty-state">
                            <div class="icon">🎟️</div>
                            <div style="font-size:16px; color:#8fa3bf; margin-bottom:8px;">No bookings found</div>
                            <div style="font-size:13px;">Book your first ticket to get started!</div>
                        </div>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
