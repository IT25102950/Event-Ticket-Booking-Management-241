<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Payment – Event Ticket Booking</title>
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
        .update-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 20px;
            max-width: 560px;
            width: 100%;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5);
            overflow: hidden;
        }
        .update-header {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            padding: 24px 28px;
        }
        .update-header h5 { margin: 0; font-size: 1.2rem; font-weight: 700; color: #fff; }
        .update-header p  { margin: 4px 0 0; color: rgba(255,255,255,0.7); font-size: 0.85rem; }

        .card-body-custom { padding: 28px; }

        /* Current Info Box */
        .info-box {
            background: #0f172a;
            border: 1px solid #334155;
            border-radius: 12px;
            padding: 18px;
            margin-bottom: 24px;
        }
        .info-box .info-title {
            color: #64748b;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 12px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            font-size: 0.9rem;
        }
        .info-row .lbl { color: #64748b; }
        .info-row .val { font-weight: 600; }

        /* Form Elements */
        .form-label  { color: #94a3b8; font-size: 0.85rem; margin-bottom: 6px; }
        .form-control, .form-select {
            background: #0f172a;
            border: 1px solid #475569;
            color: #e2e8f0;
            border-radius: 10px;
            padding: 10px 14px;
        }
        .form-control:focus, .form-select:focus {
            background: #0f172a;
            color: #e2e8f0;
            border-color: #f59e0b;
            box-shadow: 0 0 0 3px rgba(245,158,11,0.2);
            outline: none;
        }
        .form-control::placeholder { color: #475569; }

        /* Status Option Colors */
        option[value="COMPLETED"] { color: #10b981; }
        option[value="PENDING"]   { color: #f59e0b; }
        option[value="REFUNDED"]  { color: #ef4444; }
        option[value="FAILED"]    { color: #94a3b8; }

        /* Buttons */
        .btn-save {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            border: none;
            border-radius: 10px;
            color: #fff;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            font-size: 1rem;
            transition: opacity 0.2s;
        }
        .btn-save:hover { opacity: 0.85; }

        .btn-cancel {
            background: #334155;
            border: none;
            border-radius: 10px;
            color: #94a3b8;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            font-size: 1rem;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 10px;
            transition: background 0.2s;
        }
        .btn-cancel:hover { background: #475569; color: #e2e8f0; }

        .divider { border-top: 1px solid #334155; margin: 20px 0; }

        /* Status badge inline */
        .badge-COMPLETED { color: #10b981; }
        .badge-PENDING   { color: #f59e0b; }
        .badge-REFUNDED  { color: #ef4444; }
        .badge-FAILED    { color: #94a3b8; }
    </style>
</head>
<body>

<div class="update-card">

    <!-- Header -->
    <div class="update-header">
        <h5>✏️ Update Payment Status</h5>
        <p>Payment #${payment.paymentId} &nbsp;·&nbsp; ${payment.customerName}</p>
    </div>

    <div class="card-body-custom">

        <!-- Current Payment Information (read-only display) -->
        <div class="info-box">
            <p class="info-title">Current Payment Details</p>
            <div class="info-row">
                <span class="lbl">Booking ID</span>
                <span class="val">#${payment.bookingId}</span>
            </div>
            <div class="info-row">
                <span class="lbl">Customer</span>
                <span class="val">${payment.customerName}</span>
            </div>
            <div class="info-row">
                <span class="lbl">Amount</span>
                <span class="val">Rs. ${payment.amount}</span>
            </div>
            <div class="info-row">
                <span class="lbl">Method</span>
                <span class="val">
                    <c:choose>
                        <c:when test="${payment.paymentMethod == 'CARD'}">💳 Card</c:when>
                        <c:otherwise>💵 Cash</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="info-row">
                <span class="lbl">Current Status</span>
                <span class="val badge-${payment.status}">${payment.status}</span>
            </div>
            <div class="info-row">
                <span class="lbl">Date</span>
                <span class="val" style="font-size:0.85rem; color:#64748b">${payment.transactionDate}</span>
            </div>
        </div>

        <!-- Update Form: POST to /update-payment -->
        <form action="update-payment" method="post">

            <!-- Hidden: payment ID so servlet knows which record to update -->
            <input type="hidden" name="paymentId" value="${payment.paymentId}">

            <!-- New Status Dropdown -->
            <div class="mb-3">
                <label class="form-label">New Status <span class="text-danger">*</span></label>
                <select class="form-select" name="status" required>
                    <!-- Pre-select current status using JSTL -->
                    <option value="PENDING"
                        <c:if test="${payment.status == 'PENDING'}">selected</c:if>>
                        ⏳ PENDING
                    </option>
                    <option value="COMPLETED"
                        <c:if test="${payment.status == 'COMPLETED'}">selected</c:if>>
                        ✅ COMPLETED
                    </option>
                    <option value="REFUNDED"
                        <c:if test="${payment.status == 'REFUNDED'}">selected</c:if>>
                        🔄 REFUNDED
                    </option>
                    <option value="FAILED"
                        <c:if test="${payment.status == 'FAILED'}">selected</c:if>>
                        ❌ FAILED
                    </option>
                </select>
            </div>

            <!-- Notes -->
            <div class="mb-4">
                <label class="form-label">Notes / Reason for Change</label>
                <textarea class="form-control"
                          name="notes"
                          rows="3"
                          placeholder="e.g. Manual verification completed, customer confirmed payment..."
                >${not empty payment.notes ? payment.notes : ''}</textarea>
            </div>

            <div class="divider"></div>

            <!-- Buttons -->
            <button type="submit" class="btn-save">💾 Save Changes</button>
            <a href="transactions" class="btn-cancel">Cancel – Back to Transactions</a>

        </form>

    </div>
</div>

</body>
</html>