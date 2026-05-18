<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt – Event Ticket Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #0f172a;
            color: #e2e8f0;
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }
        .receipt-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 20px;
            max-width: 480px;
            width: 100%;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5);
            overflow: hidden;
        }
        .receipt-header-success {
            background: linear-gradient(135deg, #10b981, #059669);
            padding: 30px;
            text-align: center;
        }
        .receipt-header-failed {
            background: linear-gradient(135deg, #ef4444, #b91c1c);
            padding: 30px;
            text-align: center;
        }
        .receipt-icon   { font-size: 3rem; display: block; margin-bottom: 10px; }
        .receipt-title  { font-size: 1.4rem; font-weight: 700; color: #fff; margin: 0; }
        .receipt-msg    { color: rgba(255,255,255,0.8); font-size: 0.9rem; margin-top: 8px; }

        .receipt-body   { padding: 28px; }
        .receipt-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #334155;
        }
        .receipt-row:last-child { border-bottom: none; }
        .receipt-label { color: #94a3b8; font-size: 0.85rem; }
        .receipt-value { font-weight: 600; font-size: 0.95rem; }
        .receipt-amount { color: #10b981; font-size: 1.3rem; font-weight: 700; }

        .divider-dashed { border-top: 1px dashed #475569; margin: 16px 0; }

        .btn-primary-custom {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border: none;
            border-radius: 10px;
            color: #fff;
            padding: 12px;
            width: 100%;
            font-weight: 600;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-bottom: 10px;
            transition: opacity 0.2s;
        }
        .btn-primary-custom:hover { opacity: 0.85; color: #fff; }

        .btn-secondary-custom {
            background: #334155;
            border: none;
            border-radius: 10px;
            color: #94a3b8;
            padding: 12px;
            width: 100%;
            font-weight: 600;
            text-decoration: none;
            display: block;
            text-align: center;
            transition: background 0.2s;
        }
        .btn-secondary-custom:hover { background: #475569; color: #e2e8f0; }

        @media print {
            .no-print { display: none; }
            body { background: #fff; color: #000; }
            .receipt-card { box-shadow: none; border: 1px solid #ccc; }
        }
    </style>
</head>
<body>

<%
    // Read attributes set by PaymentServlet
    String resultMessage = (String) request.getAttribute("resultMessage");
    String customerName  = (String) request.getAttribute("customerName");
    Object amountObj     = request.getAttribute("amount");
    String method        = (String) request.getAttribute("paymentMethod");
    Object bookingIdObj  = request.getAttribute("bookingId");

    // Determine if payment was successful
    boolean isSuccess = (resultMessage != null && resultMessage.contains("successfully"));

    String displayAmount   = amountObj   != null ? String.format("%.2f", (Double) amountObj) : "0.00";
    String displayBooking  = bookingIdObj != null ? bookingIdObj.toString() : "N/A";
    String displayMethod   = "CARD".equalsIgnoreCase(method) ? "💳 Card" : "💵 Cash";
%>

<div class="receipt-card">

    <!-- Header: green for success, red for failure -->
    <div class="<%= isSuccess ? "receipt-header-success" : "receipt-header-failed" %>">
        <span class="receipt-icon"><%= isSuccess ? "✅" : "❌" %></span>
        <h4 class="receipt-title"><%= isSuccess ? "Payment Successful" : "Payment Failed" %></h4>
        <p class="receipt-msg"><%= resultMessage %></p>
    </div>

    <!-- Receipt Details -->
    <div class="receipt-body">
        <div class="receipt-row">
            <span class="receipt-label">Customer</span>
            <span class="receipt-value"><%= customerName != null ? customerName : "N/A" %></span>
        </div>
        <div class="receipt-row">
            <span class="receipt-label">Booking ID</span>
            <span class="receipt-value">#<%= displayBooking %></span>
        </div>
        <div class="receipt-row">
            <span class="receipt-label">Payment Method</span>
            <span class="receipt-value"><%= displayMethod %></span>
        </div>
        <div class="receipt-row">
            <span class="receipt-label">Status</span>
            <span class="receipt-value" style="color: <%= isSuccess ? "#10b981" : "#ef4444" %>">
                <%= isSuccess ? "COMPLETED" : "FAILED" %>
            </span>
        </div>

        <div class="divider-dashed"></div>

        <div class="receipt-row">
            <span class="receipt-label">Total Amount</span>
            <span class="receipt-amount">Rs. <%= displayAmount %></span>
        </div>

        <div class="divider-dashed"></div>

        <!-- Action Buttons -->
        <div class="no-print">
            <a href="transactions" class="btn-primary-custom">📋 View All Transactions</a>
            <a href="payment" class="btn-secondary-custom">+ New Payment</a>
            <div class="text-center mt-3">
                <a href="javascript:window.print()" style="color:#6366f1; font-size:0.85rem; text-decoration:none;">
                    🖨️ Print Receipt
                </a>
            </div>
        </div>

    </div><!-- end body -->
</div><!-- end card -->

</body>
</html>
