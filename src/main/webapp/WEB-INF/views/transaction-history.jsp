<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History – Event Ticket Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* ── Base ─────────────────────────────────────────── */
        body {
            background: #0f172a;
            color: #e2e8f0;
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            padding: 30px 20px;
        }

        /* ── Top Navigation Bar ──────────────────────────── */
        .top-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }
        .page-title {
            font-size: 1.7rem;
            font-weight: 700;
            color: #f1f5f9;
        }
        .page-subtitle { color: #64748b; font-size: 0.9rem; margin: 2px 0 0; }

        .btn-new-payment {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border: none;
            border-radius: 10px;
            color: #fff;
            padding: 10px 20px;
            font-weight: 600;
            text-decoration: none;
            transition: opacity 0.2s;
        }
        .btn-new-payment:hover { opacity: 0.85; color: #fff; }

        /* ── Summary Cards ───────────────────────────────── */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 16px;
            margin-bottom: 28px;
        }
        .summary-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 14px;
            padding: 18px;
            text-align: center;
        }
        .summary-card .s-value { font-size: 1.6rem; font-weight: 700; }
        .summary-card .s-label { color: #64748b; font-size: 0.8rem; margin-top: 4px; }

        /* ── Table Card ──────────────────────────────────── */
        .table-card {
            background: #1e293b;
            border: 1px solid #334155;
            border-radius: 16px;
            overflow: hidden;
        }

        .table { color: #e2e8f0; margin-bottom: 0; }
        .table thead th {
            background: #0f172a;
            border-bottom: 1px solid #334155;
            color: #64748b;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            padding: 14px 16px;
            font-weight: 600;
        }
        .table tbody td {
            padding: 14px 16px;
            border-bottom: 1px solid #1e293b;
            vertical-align: middle;
            font-size: 0.9rem;
        }
        .table tbody tr { border-bottom: 1px solid #334155; }
        .table tbody tr:last-child td { border-bottom: none; }
        .table tbody tr:hover { background: rgba(99,102,241,0.05); }

        /* ── Status Badges ───────────────────────────────── */
        .badge-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .badge-COMPLETED { background: rgba(16,185,129,0.15); color: #10b981; }
        .badge-PENDING   { background: rgba(234,179,8,0.15);  color: #f59e0b; }
        .badge-REFUNDED  { background: rgba(239,68,68,0.15);  color: #ef4444; }
        .badge-FAILED    { background: rgba(100,116,139,0.15);color: #94a3b8; }

        /* ── Action Buttons ──────────────────────────────── */
        .btn-edit {
            background: rgba(99,102,241,0.15);
            color: #818cf8;
            border: 1px solid rgba(99,102,241,0.3);
            border-radius: 7px;
            padding: 5px 12px;
            font-size: 0.8rem;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-edit:hover { background: #6366f1; color: #fff; }

        .btn-refund {
            background: rgba(239,68,68,0.15);
            color: #f87171;
            border: 1px solid rgba(239,68,68,0.3);
            border-radius: 7px;
            padding: 5px 12px;
            font-size: 0.8rem;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-refund:hover { background: #ef4444; color: #fff; }

        /* ── Flash Message ───────────────────────────────── */
        .flash-msg {
            background: rgba(99,102,241,0.1);
            border: 1px solid rgba(99,102,241,0.3);
            color: #a5b4fc;
            border-radius: 12px;
            padding: 14px 20px;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* ── Empty state ─────────────────────────────────── */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #475569;
        }
        .empty-state .empty-icon { font-size: 3rem; margin-bottom: 12px; }
    </style>
</head>
<body>

<!-- Top Navigation -->
<div class="top-nav">
    <div>
        <h2 class="page-title">📋 Transaction History</h2>
        <p class="page-subtitle">All payment records – Event Ticket Booking System</p>
    </div>
    <a href="payment" class="btn-new-payment">+ New Payment</a>
</div>

<!-- Flash Message (set by UpdatePaymentServlet or RefundServlet) -->
<c:if test="${not empty sessionScope.flashMsg}">
    <div class="flash-msg">
        <span>${sessionScope.flashMsg}</span>
    </div>
    <%-- Remove flash message from session after displaying --%>
    <c:remove var="flashMsg" scope="session"/>
</c:if>

<!-- Summary Cards -->
<div class="summary-grid">
    <div class="summary-card">
        <div class="s-value text-white">${payments.size()}</div>
        <div class="s-label">Total Records</div>
    </div>
    <div class="summary-card">
        <div class="s-value" style="color:#10b981">
            <c:set var="cCount" value="0"/>
            <c:forEach var="p" items="${payments}">
                <c:if test="${p.status == 'COMPLETED'}">
                    <c:set var="cCount" value="${cCount + 1}"/>
                </c:if>
            </c:forEach>
            ${cCount}
        </div>
        <div class="s-label">Completed</div>
    </div>
    <div class="summary-card">
        <div class="s-value" style="color:#f59e0b">
            <c:set var="pCount" value="0"/>
            <c:forEach var="p" items="${payments}">
                <c:if test="${p.status == 'PENDING'}">
                    <c:set var="pCount" value="${pCount + 1}"/>
                </c:if>
            </c:forEach>
            ${pCount}
        </div>
        <div class="s-label">Pending</div>
    </div>
    <div class="summary-card">
        <div class="s-value" style="color:#ef4444">
            <c:set var="rCount" value="0"/>
            <c:forEach var="p" items="${payments}">
                <c:if test="${p.status == 'REFUNDED'}">
                    <c:set var="rCount" value="${rCount + 1}"/>
                </c:if>
            </c:forEach>
            ${rCount}
        </div>
        <div class="s-label">Refunded</div>
    </div>
</div>

<!-- Transactions Table -->
<div class="table-card">
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Booking</th>
                    <th>Customer</th>
                    <th>Amount (Rs.)</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Date & Time</th>
                    <th>Notes</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>

                <!-- JSTL: loop through payments list set by TransactionServlet -->
                <c:choose>
                    <c:when test="${not empty payments}">
                        <c:forEach var="p" items="${payments}">
                            <tr>
                                <td style="color:#64748b">#${p.paymentId}</td>
                                <td>${p.bookingId}</td>
                                <td><strong>${p.customerName}</strong></td>
                                <td><strong>Rs. ${p.amount}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.paymentMethod == 'CARD'}">💳 Card</c:when>
                                        <c:otherwise>💵 Cash</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="badge-status badge-${p.status}">${p.status}</span>
                                </td>
                                <td style="color:#64748b; font-size:0.82rem;">
                                    ${p.transactionDate}
                                </td>
                                <td style="color:#64748b; font-size:0.82rem; max-width:140px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                                    <c:choose>
                                        <c:when test="${not empty p.notes}">${p.notes}</c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div style="display:flex; gap:6px;">
                                        <!-- Edit: goes to UpdatePaymentServlet GET -->
                                        <a href="update-payment?id=${p.paymentId}" class="btn-edit">Edit</a>
                                        <!-- Refund: goes to RefundServlet GET -->
                                        <a href="refund?id=${p.paymentId}" class="btn-refund">Refund</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- No records found -->
                        <tr>
                            <td colspan="9">
                                <div class="empty-state">
                                    <div class="empty-icon">📭</div>
                                    <p>No transactions found.</p>
                                    <a href="payment" style="color:#6366f1">Record the first payment →</a>
                                </div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>

            </tbody>
        </table>
    </div>
</div>

</body>
</html>