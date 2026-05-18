<%--
  Created by IntelliJ IDEA.
  User: acer
  Date: 5/13/2026
  Time: 3:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book a Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #0a1628; font-family: 'Segoe UI', sans-serif; min-height: 100vh; }
        .navbar { background: #0d1f38 !important; border-bottom: 1px solid rgba(255,255,255,0.08); }
        .navbar-brand { color: #c9d8f0 !important; font-size: 18px; font-weight: 600; }
        .btn-back { border: 1px solid rgba(255,255,255,0.2); color: #c9d8f0; font-size: 13px; background: transparent; }
        .btn-back:hover { background: rgba(255,255,255,0.08); color: white; }
        .form-card { background: #0d1f38; border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; padding: 36px; height: 100%; }
        .form-card-title { color: #ffffff; font-size: 24px; font-weight: 600; margin-bottom: 4px; }
        .form-card-subtitle { color: #6b82a0; font-size: 13px; margin-bottom: 28px; }
        .form-label { color: #8fa3bf; font-size: 12px; text-transform: uppercase; letter-spacing: 0.8px; font-weight: 500; }
        .form-control, .form-select { background: rgba(255,255,255,0.04) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: #e8edf5 !important; border-radius: 8px; padding: 10px 14px; }
        .form-control::placeholder { color: #3d5470; }
        .form-control:focus, .form-select:focus { border-color: #4a7fc1 !important; box-shadow: 0 0 0 3px rgba(74,127,193,0.15) !important; background: rgba(74,127,193,0.08) !important; }
        .form-select option { background: #0d1f38; }
        .ticket-option { border: 1.5px solid rgba(255,255,255,0.1); border-radius: 10px; padding: 14px; cursor: pointer; transition: all 0.2s; text-align: center; }
        .ticket-option:hover { border-color: #4a7fc1; background: rgba(74,127,193,0.06); }
        .ticket-option.active { border-color: #4a7fc1; background: rgba(74,127,193,0.12); }
        .ticket-name { font-size: 14px; font-weight: 500; color: #c9d8f0; }
        .ticket-price-sm { font-size: 12px; color: #6b82a0; }
        .btn-confirm { background: linear-gradient(135deg, #1e4d8c, #2a6bc7); color: white; border: none; padding: 13px; font-size: 15px; font-weight: 500; border-radius: 10px; transition: all 0.3s; width: 100%; }
        .btn-confirm:hover { background: linear-gradient(135deg, #2a6bc7, #3a85e8); transform: translateY(-2px); box-shadow: 0 8px 25px rgba(42,107,199,0.4); color: white; }
        .info-card { background: #0d1f38; border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; padding: 36px; height: 100%; }
        .event-img-box { background: linear-gradient(135deg, #1a3a6e, #0d2144); border-radius: 14px; height: 180px; display: flex; align-items: center; justify-content: center; position: relative; margin-bottom: 20px; }
        .event-type-badge { position: absolute; top: 12px; left: 12px; background: rgba(42,107,199,0.9); color: white; font-size: 11px; padding: 3px 12px; border-radius: 20px; text-transform: uppercase; }
        .event-title { color: #ffffff; font-size: 20px; font-weight: 600; margin-bottom: 4px; }
        .event-meta { color: #6b82a0; font-size: 13px; margin-bottom: 20px; }
        .pricing-box { background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08); border-radius: 12px; padding: 18px; margin-bottom: 16px; }
        .pricing-box-title { color: #6b82a0; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px; }
        .price-row { display: flex; justify-content: space-between; align-items: center; padding: 7px 0; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .price-row:last-child { border-bottom: none; }
        .price-label { color: #c9d8f0; font-size: 13px; display: flex; align-items: center; gap: 8px; }
        .price-value { color: #fff; font-size: 14px; font-weight: 500; }
        .badge-std { background: rgba(74,127,193,0.15); color: #7eb3f5; font-size: 10px; padding: 2px 8px; border-radius: 10px; }
        .badge-vip { background: rgba(234,179,8,0.15); color: #eab308; font-size: 10px; padding: 2px 8px; border-radius: 10px; }
        .total-box { background: linear-gradient(135deg, rgba(30,77,140,0.4), rgba(42,107,199,0.2)); border: 1px solid rgba(74,127,193,0.3); border-radius: 12px; padding: 18px; }
        .total-lbl { color: #6b82a0; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px; }
        .total-val { color: #fff; font-size: 32px; font-weight: 700; }
        .total-sub { color: #6b82a0; font-size: 12px; margin-top: 3px; }
        .error-msg { background: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.3); color: #fca5a5; padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 13px; }
        .divider { width: 1px; background: rgba(255,255,255,0.06); }
    </style>
</head>
<body>

<nav class="navbar px-4">
    <span class="navbar-brand">🎟️ EventTicket</span>
    <a href="${pageContext.request.contextPath}/viewEvents" class="btn btn-back btn-sm">← Back to Events</a>
</nav>

<div class="container-fluid py-5 px-5">
    <div class="row g-4">

        <!-- LEFT SIDE: Booking Form -->
        <div class="col-md-6">
            <div class="form-card">
                <div class="form-card-title">Complete Your Booking</div>
                <div class="form-card-subtitle">Fill in your details to secure your seats</div>

                <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg"><%= request.getAttribute("error") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/booking" method="post">

                    <!-- Hidden fields passed from event page -->
                    <input type="hidden" name="eventId" value="<%= request.getParameter("eventId") != null ? request.getParameter("eventId") : "" %>">
                    <input type="hidden" name="eventName" value="<%= request.getParameter("eventName") != null ? request.getParameter("eventName") : "" %>">
                    <input type="hidden" name="eventType" value="<%= request.getParameter("eventType") != null ? request.getParameter("eventType") : "" %>">
                    <input type="hidden" name="seatNumber" value="<%= request.getParameter("seatNumber") != null ? request.getParameter("seatNumber") : "TBD" %>">
                    <input type="hidden" name="bookingType" id="bookingTypeField" value="STANDARD">
                    <input type="hidden" name="totalPrice" id="totalPriceField" value="0">
                    <input type="hidden" name="bookingDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">

                    <div class="row g-3 mb-3">
                        <div class="col-6">
                            <label class="form-label">First Name</label>
                            <input type="text" name="firstName" class="form-control" placeholder="John" required>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" name="lastName" class="form-control" placeholder="Doe" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                    </div>

                    <!-- User ID hidden - auto filled from session -->
                    <input type="hidden" name="userId" value="${userId}">
                    <div class="mb-3">
                        <label class="form-label">Booking For</label>
                        <input type="text" class="form-control" value="${userName}" disabled>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Number of Seats</label>
                        <input type="number" name="numSeats" id="numSeats"
                               class="form-control" placeholder="1" min="1" max="10"
                               oninput="calculateTotal()" required>
                    </div>

                    <label class="form-label mb-2 d-block">Ticket Type</label>
                    <div class="row g-2 mb-4">
                        <div class="col-6">
                            <div class="ticket-option active" id="opt-standard"
                                 onclick="selectTicket('STANDARD', 50)">
                                <div class="ticket-name">🎫 Standard</div>
                                <div class="ticket-price-sm">$50 per seat</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="ticket-option" id="opt-vip"
                                 onclick="selectTicket('VIP', 100)">
                                <div class="ticket-name">⭐ VIP</div>
                                <div class="ticket-price-sm">$100 per seat</div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-confirm">Confirm Booking →</button>

                </form>
            </div>
        </div>



        <!-- Event Info -->
        <div class="col-md-6">
            <div class="info-card">

                <%
                    String eventType = request.getParameter("eventType");
                    String eventName = request.getParameter("eventName");
                    String icon = "🎬";
                    if ("CONCERT".equals(eventType)) icon = "🎵";
                    else if ("DRAMA".equals(eventType)) icon = "🎭";
                %>

                <div class="event-img-box">
                    <div style="text-align:center; color:rgba(255,255,255,0.3);">
                        <div style="font-size:64px;"><%= icon %></div>
                    </div>
                    <div class="event-type-badge"><%= eventType != null ? eventType : "EVENT" %></div>
                </div>

                <div class="event-title"><%= eventName != null ? eventName : "Event Name" %></div>
                <div class="event-meta">
                    📅 <%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date()) %>
                </div>

                <div class="pricing-box">
                    <div class="pricing-box-title">Ticket Pricing</div>
                    <div class="price-row">
                        <div class="price-label">
                            <span class="badge-std">STANDARD</span> Standard Seat
                        </div>
                        <div class="price-value">$50</div>
                    </div>
                    <div class="price-row">
                        <div class="price-label">
                            <span class="badge-vip">VIP</span> VIP Seat
                        </div>
                        <div class="price-value">$100</div>
                    </div>
                </div>

                <div class="total-box">
                    <div class="total-lbl">Total Amount</div>
                    <div class="total-val" id="totalAmount">$0.00</div>
                    <div class="total-sub" id="totalBreakdown">Select seats and ticket type</div>
                </div>

            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let selectedPrice = 50;
    let selectedType = 'STANDARD';

    function selectTicket(type, price) {
        selectedType = type;
        selectedPrice = price;
        document.getElementById('opt-standard').classList.remove('active');
        document.getElementById('opt-vip').classList.remove('active');
        document.getElementById('opt-' + type.toLowerCase()).classList.add('active');
        document.getElementById('bookingTypeField').value = type;
        calculateTotal();
    }

    function calculateTotal() {
        const seats = parseInt(document.getElementById('numSeats').value) || 0;
        const total = seats * selectedPrice;
        document.getElementById('totalAmount').textContent = '$' + total.toFixed(2);
        document.getElementById('totalPriceField').value = total.toFixed(2);
        if (seats > 0) {
            document.getElementById('totalBreakdown').textContent =
                seats + ' × $' + selectedPrice + ' (' + selectedType + ')';
        } else {
            document.getElementById('totalBreakdown').textContent = 'Select seats and ticket type';
        }
    }
</script>

</body>
</html>
