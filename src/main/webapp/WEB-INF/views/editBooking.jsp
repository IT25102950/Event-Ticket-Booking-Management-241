<%--
  Created by IntelliJ IDEA.
  User: acer
  Date: 5/14/2026
  Time: 9:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #0a1628; font-family: 'Segoe UI', sans-serif; min-height: 100vh; }
        .navbar { background: #0d1f38 !important; border-bottom: 1px solid rgba(255,255,255,0.08); }
        .navbar-brand { color: #c9d8f0 !important; font-size: 18px; font-weight: 600; }
        .btn-back { border: 1px solid rgba(255,255,255,0.2); color: #c9d8f0; font-size: 13px; background: transparent; text-decoration: none; padding: 8px 18px; border-radius: 8px; transition: all 0.2s; }
        .btn-back:hover { background: rgba(255,255,255,0.08); color: white; }
        .edit-card { background: #0d1f38; border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; padding: 36px; }
        .card-title { color: #ffffff; font-size: 22px; font-weight: 600; margin-bottom: 4px; }
        .card-subtitle { color: #6b82a0; font-size: 13px; margin-bottom: 28px; }
        .form-label { color: #8fa3bf; font-size: 12px; text-transform: uppercase; letter-spacing: 0.8px; font-weight: 500; }
        .form-control, .form-select { background: rgba(255,255,255,0.04) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: #e8edf5 !important; border-radius: 8px; padding: 10px 14px; }
        .form-control:focus, .form-select:focus { border-color: #4a7fc1 !important; box-shadow: 0 0 0 3px rgba(74,127,193,0.15) !important; }
        .form-select option { background: #0d1f38; }
        .event-info-box { background: rgba(74,127,193,0.08); border: 1px solid rgba(74,127,193,0.2); border-radius: 10px; padding: 16px; margin-bottom: 24px; }
        .event-info-label { color: #6b82a0; font-size: 11px; text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px; }
        .event-info-value { color: #c9d8f0; font-size: 14px; }
        .badge-vip { background: rgba(234,179,8,0.15); color: #eab308; font-size: 11px; padding: 3px 10px; border-radius: 10px; }
        .badge-std { background: rgba(74,127,193,0.15); color: #7eb3f5; font-size: 11px; padding: 3px 10px; border-radius: 10px; }
        .btn-save { background: linear-gradient(135deg, #1e4d8c, #2a6bc7); color: white; border: none; padding: 12px 28px; border-radius: 10px; font-size: 14px; font-weight: 500; transition: all 0.3s; }
        .btn-save:hover { background: linear-gradient(135deg, #2a6bc7, #3a85e8); transform: translateY(-2px); box-shadow: 0 8px 25px rgba(42,107,199,0.4); color: white; }
        .btn-discard { background: transparent; border: 1px solid rgba(255,255,255,0.15); color: #8fa3bf; padding: 12px 28px; border-radius: 10px; font-size: 14px; text-decoration: none; transition: all 0.2s; }
        .btn-discard:hover { border-color: rgba(255,255,255,0.3); color: #c9d8f0; }
        .error-msg { background: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.3); color: #fca5a5; padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 13px; }
    </style>
</head>
<body>

<nav class="navbar px-4">
    <span class="navbar-brand">🎟️ EventTicket</span>
    <a href="${pageContext.request.contextPath}/viewBookings" class="btn-back">← Back to My Bookings</a>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="edit-card">

                <div class="card-title">✏️ Edit Booking #${booking.bookingId}</div>
                <div class="card-subtitle">Update your booking details below</div>

                <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg"><%= request.getAttribute("error") %></div>
                <% } %>

                <!-- Event Info (read only) -->
                <div class="event-info-box">
                    <div class="event-info-label">Event Details</div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div style="color:#6b82a0;font-size:11px;margin-bottom:3px;">Event Name</div>
                            <div class="event-info-value">${booking.eventName}</div>
                        </div>
                        <div class="col-md-3">
                            <div style="color:#6b82a0;font-size:11px;margin-bottom:3px;">Type</div>
                            <div class="event-info-value">${booking.eventType}</div>
                        </div>
                        <div class="col-md-3">
                            <div style="color:#6b82a0;font-size:11px;margin-bottom:3px;">Ticket</div>
                            <span class="${booking.bookingType == 'VIP' ? 'badge-vip' : 'badge-std'}">
                                ${booking.bookingType == 'VIP' ? '⭐ VIP' : '🎫 STANDARD'}
                            </span>
                        </div>
                        <div class="col-md-6">
                            <div style="color:#6b82a0;font-size:11px;margin-bottom:3px;">User ID</div>
                            <div class="event-info-value">${booking.userId}</div>
                        </div>
                        <div class="col-md-6">
                            <div style="color:#6b82a0;font-size:11px;margin-bottom:3px;">Total Price</div>
                            <div style="color:#4ade80;font-size:14px;font-weight:500;">$${booking.totalPrice}</div>
                        </div>
                    </div>
                </div>

                <!-- Edit Form -->
                <form action="${pageContext.request.contextPath}/updateBooking" method="post">
                    <input type="hidden" name="bookingId" value="${booking.bookingId}">

                    <div class="mb-3">
                        <label class="form-label">Seat Number</label>
                        <input type="text" name="seatNumber" class="form-control"
                               value="${booking.seatNumber}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Number of Seats</label>
                        <input type="number" name="numSeats" class="form-control"
                               value="${booking.numSeats}" min="1" max="10" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Booking Date</label>
                        <input type="date" name="bookingDate" class="form-control"
                               value="${booking.bookingDate}" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-select">
                            <option value="CONFIRMED" ${booking.status == 'CONFIRMED' ? 'selected' : ''}>
                                ✅ Confirmed
                            </option>
                            <option value="CANCELLED" ${booking.status == 'CANCELLED' ? 'selected' : ''}>
                                ❌ Cancelled
                            </option>
                        </select>
                    </div>

                    <div class="d-flex gap-3">
                        <button type="submit" class="btn btn-save">Save Changes</button>
                        <a href="${pageContext.request.contextPath}/viewBookings" class="btn-discard">Discard</a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>