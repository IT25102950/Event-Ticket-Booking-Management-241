<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Refund Payment – Event Ticket Booking</title>
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
        .refund-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 20px;
            max-width: 480px;
            width: 100%;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5);
            overflow: hidden;
        }
        .refund-header {
            background: linear-gradient(135deg, #ef4444, #b91c1c);
            padding: 28px;
            text-align: center;
        }
        .refund-header .warning-icon { font-size: 2.5rem; display: block; margin-bottom: 10px; }
        .refund-header h5 { margin: 0; font-size: 1.3rem; font-weight: 700; color: #fff; }
        .refund-header p  { margin: 8px 0 0; color: rgba(255,255,255,0.75); font-size: 0.9rem; }

        .refund-body { padding: 28px; }

        /* Warning Banner */
        .warning-banner {
            background: rgba(239,68,68,0.1);
            border: 1px solid rgba(239,68,68,0.3);
            border-radius: 12px;
            padding: 14px 18px;
            margin-bottom: 24px;
            color: #fca5a5;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        /* Payment Detail Rows */
        .detail-list { margin-bottom: 24px; }
        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #334155;
        }
        .detail-row:last-child { border-bottom: none; }
        .detail-label { color: #64748b; font-size: 0.85rem; }
        .detail-value { font-weight: 600; font-size: 0.95rem; }
        .detail-amount { color: #ef4444; font-size: 1.3rem; font-weight: 700; }

        /* Buttons */
        .btn-confirm-refund {
            background: linear-gradient(135deg, #ef4444, #b91c1c);
            border: none;
            border-radius: 10px;
            color: #fff;
            padding: 14px;
            font-size: 1rem;
            font-weight: 600;
            width: 100%;
            transition: opacity 0.2s;
            cursor: pointer;
        }
        .btn-confirm-refund:hover { opacity: 0.85; }

        .btn-cancel-refund {
            background: #334155;
            border: none;
            border-radius: 10px;
            color: #94a3b8;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 10px;
            transition: background 0.2s;
        }
        .btn-cancel-refund:hover { background: #475569; color: #e2e8f0; }

        /* Status badge colors */
        .status-COMPLETED { color: #10b981; }
        .status-PENDING   { color: #f59e0b; }
        .status-REFUNDED  { color: #ef4444; }
        .status-FAILED    { color: #94a3b8; }
    </style>
</head>
<body>

<div class="refund-card">

    <!-- Header -->
    <div class="refund-header">
        <span class="warning-icon">⚠️</span>
        <h5>Confirm Refund</h5>
        <p>This action cannot be undone. The payment record will be permanently deleted.</p>
    </div>

    <div class="refund-body">

        <!-- Warning Message -->
        <div class="warning-banner">
            <strong>⚠️ Warning:</strong> Processing this refund will:
            <ul style="margin: 8px 0 0; padding-left: 20px;">
                <li>Mark the payment as <strong>REFUNDED</strong></li>
                <li>Permanently <strong>delete</strong> this record from the system</li>
            </ul>
        </div>

        <!-- Payment Details Summary -->
        <div class="detail-list">
            <div class="detail-row">
                <span class="detail-label">Payment ID</span>
                <span class="detail-value">#${payment.paymentId}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Customer Name</span>
                <span class="detail-value">${payment.customerName}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Booking ID</span>
                <span class="detail-value">#${payment.bookingId}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Payment Method</span>
                <span class="detail-value">
                    <c:choose>
                        <c:when test="${payment.paymentMethod == 'CARD'}">💳 Card</c:when>
                        <c:otherwise>💵 Cash</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Current Status</span>
                <span class="detail-value status-${payment.status}">${payment.status}</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Transaction Date</span>
                <span class="detail-value" style="color:#64748b; font-size:0.85rem">
                    ${payment.transactionDate}
                </span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Refund Amount</span>
                <span class="detail-amount">Rs. ${payment.amount}</span>
            </div>
        </div>

        <!-- Confirm Form: POST to /refund -->
        <form action="refund" method="post"
              onsubmit="return confirm('Are you absolutely sure? This will permanently delete Payment #${payment.paymentId}.')">

            <!-- Hidden: pass payment ID to servlet -->
            <input type="hidden" name="paymentId" value="${payment.paymentId}">

            <!-- Confirm Refund Button -->
            <button type="submit" class="btn-confirm-refund">
                🔄 Yes, Process Refund & Delete Record
            </button>

        </form>

        <!-- Cancel Button -->
        <a href="transactions" class="btn-cancel-refund">
            ← Cancel – Back to Transactions
        </a>

    </div>
</div>

</body>
</html>