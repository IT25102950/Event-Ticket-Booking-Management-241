<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Portal – Event Ticket Booking</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* ── Page Background ────────────────────────────────── */
        body {
            background: #0f172a;
            color: #e2e8f0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }

        /* ── Card Container ─────────────────────────────────── */
        .payment-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 20px;
            width: 100%;
            max-width: 580px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.5);
        }

        /* ── Card Header ────────────────────────────────────── */
        .payment-header {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            border-radius: 20px 20px 0 0;
            padding: 28px;
            text-align: center;
        }
        .payment-header h3 { margin: 0; font-size: 1.5rem; font-weight: 700; }
        .payment-header p  { margin: 6px 0 0; color: rgba(255,255,255,0.7); font-size: 0.9rem; }

        /* ── Form Fields ────────────────────────────────────── */
        .form-label { color: #94a3b8; font-size: 0.85rem; margin-bottom: 5px; }

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
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.25);
            outline: none;
        }
        .form-control::placeholder { color: #475569; }

        /* ── Payment Method Toggle Buttons ─────────────────── */
        .method-selector { display: flex; gap: 12px; margin-bottom: 24px; }
        .method-btn {
            flex: 1;
            padding: 16px 10px;
            text-align: center;
            border: 2px solid #334155;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            background: #0f172a;
        }
        .method-btn:hover { border-color: #6366f1; background: rgba(99,102,241,0.08); }
        .method-btn.active {
            border-color: #6366f1;
            background: rgba(99,102,241,0.15);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.2);
        }
        .method-btn .icon  { font-size: 1.8rem; display: block; margin-bottom: 6px; }
        .method-btn .label { font-weight: 600; font-size: 0.95rem; }

        /* ── Submit Button ──────────────────────────────────── */
        .btn-submit {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border: none;
            border-radius: 12px;
            padding: 14px;
            font-size: 1.05rem;
            font-weight: 600;
            color: #fff;
            width: 100%;
            transition: all 0.2s;
            margin-top: 8px;
        }
        .btn-submit:hover { opacity: 0.88; transform: translateY(-1px); }

        /* ── Section Dividers ───────────────────────────────── */
        .section-divider {
            border-top: 1px solid #334155;
            margin: 20px 0;
        }

        /* ── Error message ──────────────────────────────────── */
        .alert-custom {
            background: rgba(239,68,68,0.1);
            border: 1px solid rgba(239,68,68,0.3);
            color: #fca5a5;
            border-radius: 10px;
            padding: 12px 16px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="payment-card">

    <!-- Header -->
    <div class="payment-header">
        <h3 class="text-white">💳 Payment Portal</h3>
        <p>Event Ticket Booking System</p>
    </div>

    <!-- Form Body -->
    <div class="p-4">

        <!-- Error Message (shown if servlet puts errorMsg in request) -->
        <%
            String errorMsg = (String) request.getAttribute("errorMsg");
            if (errorMsg != null) {
        %>
            <div class="alert-custom">⚠️ <%= errorMsg %></div>
        <% } %>

        <!-- POST to /payment servlet -->
        <form action="payment" method="post" id="paymentForm" onsubmit="return validateForm()">

            <!-- Row 1: Booking ID -->
            <div class="mb-3">
                <label class="form-label">Booking ID <span class="text-danger">*</span></label>
                <input type="number"
                       class="form-control"
                       name="bookingId"
                       placeholder="e.g. 101"
                       value="${bookingId != null ? bookingId : ''}"
                       required
                       min="1">
            </div>

            <!-- Row 2: Customer Name -->
            <div class="mb-3">
                <label class="form-label">Customer Name <span class="text-danger">*</span></label>
                <input type="text"
                       class="form-control"
                       name="customerName"
                       placeholder="Full name"
                       required>
            </div>

            <!-- Row 3: Amount -->
            <div class="mb-4">
                <label class="form-label">Amount (Rs.) <span class="text-danger">*</span></label>
                <input type="number"
                       class="form-control"
                       name="amount"
                       id="amountField"
                       placeholder="0.00"
                       step="0.01"
                       min="1"
                       required>
            </div>

            <div class="section-divider"></div>

            <!-- Payment Method Selection -->
            <label class="form-label d-block mb-3">Payment Method <span class="text-danger">*</span></label>
            <div class="method-selector">
                <div class="method-btn" id="cardBtn" onclick="selectMethod('CARD')">
                    <span class="icon">💳</span>
                    <span class="label text-white">Card</span>
                </div>
                <div class="method-btn" id="cashBtn" onclick="selectMethod('CASH')">
                    <span class="icon">💵</span>
                    <span class="label text-white">Cash</span>
                </div>
            </div>

            <!-- Hidden input stores selected method -->
            <input type="hidden" name="paymentMethod" id="paymentMethod">

            <!-- ── CARD FIELDS (shown only when CARD is selected) ──────── -->
            <div id="cardFields" style="display:none;">
                <div class="mb-3">
                    <label class="form-label">Card Number <span class="text-danger">*</span></label>
                    <input type="text"
                           class="form-control"
                           name="cardNumber"
                           id="cardNumber"
                           placeholder="1234 5678 9012 3456"
                           maxlength="19"
                           oninput="formatCardNumber(this)">
                </div>
                <div class="row">
                    <div class="col-8 mb-3">
                        <label class="form-label">Card Holder Name <span class="text-danger">*</span></label>
                        <input type="text"
                               class="form-control"
                               name="cardHolder"
                               id="cardHolder"
                               placeholder="Name on card">
                    </div>
                    <div class="col-4 mb-3">
                        <label class="form-label">Expiry <span class="text-danger">*</span></label>
                        <input type="text"
                               class="form-control"
                               name="expiryDate"
                               id="expiryDate"
                               placeholder="MM/YY"
                               maxlength="5"
                               oninput="formatExpiry(this)">
                    </div>
                </div>
            </div>

            <!-- ── CASH FIELDS (shown only when CASH is selected) ─────── -->
            <div id="cashFields" style="display:none;">
                <div class="mb-3">
                    <label class="form-label">Amount Received from Customer (Rs.) <span class="text-danger">*</span></label>
                    <input type="number"
                           class="form-control"
                           name="amountReceived"
                           id="amountReceived"
                           placeholder="Cash handed by customer"
                           step="0.01"
                           min="0">
                    <!-- Live change calculator -->
                    <div id="changeDisplay" class="mt-2" style="color:#10b981; font-size:0.9rem;"></div>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-submit">
                Process Payment →
            </button>

        </form>

        <!-- Navigation Links -->
        <div class="text-center mt-3">
            <a href="transactions" style="color:#6366f1; font-size:0.85rem; text-decoration:none;">
                📋 View All Transactions
            </a>
        </div>

    </div><!-- end card body -->
</div><!-- end card -->


<script>
    // ── Select payment method ─────────────────────────────────────────────
    function selectMethod(method) {
        // Set the hidden input
        document.getElementById('paymentMethod').value = method;

        // Show/hide relevant fields
        document.getElementById('cardFields').style.display = (method === 'CARD') ? 'block' : 'none';
        document.getElementById('cashFields').style.display = (method === 'CASH') ? 'block' : 'none';

        // Toggle active state on buttons
        document.getElementById('cardBtn').classList.toggle('active', method === 'CARD');
        document.getElementById('cashBtn').classList.toggle('active', method === 'CASH');
    }

    // ── Format card number with spaces (1234 5678 9012 3456) ─────────────
    function formatCardNumber(input) {
        let value = input.value.replace(/\s/g, '').replace(/[^0-9]/gi, '');
        let matches = value.match(/\d{4,16}/g);
        let match = (matches && matches[0]) || '';
        let parts = [];
        for (let i = 0; i < match.length; i += 4) {
            parts.push(match.substring(i, i + 4));
        }
        input.value = parts.length ? parts.join(' ') : value;
    }

    // ── Format expiry as MM/YY ────────────────────────────────────────────
    function formatExpiry(input) {
        let value = input.value.replace(/\D/g, '');
        if (value.length >= 2) {
            value = value.substring(0, 2) + '/' + value.substring(2, 4);
        }
        input.value = value;
    }

    // ── Live change calculation for cash payments ─────────────────────────
    document.addEventListener('input', function (e) {
        if (e.target.id === 'amountReceived' || e.target.id === 'amountField') {
            let amount   = parseFloat(document.getElementById('amountField').value) || 0;
            let received = parseFloat(document.getElementById('amountReceived').value) || 0;
            let display  = document.getElementById('changeDisplay');
            if (display && received > 0) {
                let change = received - amount;
                if (change >= 0) {
                    display.innerHTML = '✅ Change to return: Rs. ' + change.toFixed(2);
                    display.style.color = '#10b981';
                } else {
                    display.innerHTML = '❌ Insufficient! Short by: Rs. ' + Math.abs(change).toFixed(2);
                    display.style.color = '#ef4444';
                }
            }
        }
    });

    // ── Form validation before submit ─────────────────────────────────────
    function validateForm() {
        let method = document.getElementById('paymentMethod').value;

        if (!method) {
            alert('Please select a payment method (Card or Cash).');
            return false;
        }

        if (method === 'CARD') {
            let card   = document.getElementById('cardNumber').value.replace(/\s/g, '');
            let holder = document.getElementById('cardHolder').value;
            let expiry = document.getElementById('expiryDate').value;

            if (card.length < 16) { alert('Please enter a valid 16-digit card number.'); return false; }
            if (!holder.trim())   { alert('Please enter the card holder name.'); return false; }
            if (!expiry.trim())   { alert('Please enter the expiry date.'); return false; }
        }

        if (method === 'CASH') {
            let amount   = parseFloat(document.getElementById('amountField').value) || 0;
            let received = parseFloat(document.getElementById('amountReceived').value) || 0;
            if (received <= 0) { alert('Please enter the cash amount received.'); return false; }
            if (received < amount) {
                return confirm('Cash received is less than amount due. Record as FAILED payment?');
            }
        }

        return true;
    }
</script>

</body>
</html>