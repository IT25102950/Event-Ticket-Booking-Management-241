<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Seat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Edit Seat Status – Venue & Seat Management</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --bg: #0d0f14; --surface: #161a22; --surface2: #1d2230;
      --border: #252b36; --accent: #e8ff47; --accent2: #47c4ff;
      --text: #eef0f4; --muted: #6b7280;
      --available: #22c55e; --booked: #ef4444; --maintenance: #f59e0b;
      --radius: 10px;
    }
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; }
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 18px 40px; border-bottom: 1px solid var(--border); background: var(--surface);
    }
    .nav-brand { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.2rem; }
    .nav-brand span { color: var(--accent); }
    .nav-links a { color: var(--muted); text-decoration: none; font-size: 0.9rem; margin-left: 28px; }
    .nav-links a:hover { color: var(--text); }
    .page { max-width: 540px; margin: 0 auto; padding: 48px 24px; }
    .breadcrumb { font-size: 0.82rem; color: var(--muted); margin-bottom: 28px; }
    .breadcrumb a { color: var(--accent2); text-decoration: none; }
    /* Seat info card */
    .info-card {
      background: var(--surface); border: 1px solid var(--border); border-radius: 14px;
      padding: 28px; margin-bottom: 28px; display: flex; gap: 22px; align-items: center;
    }
    .seat-icon {
      width: 68px; height: 68px; border-radius: 14px; display: flex; align-items: center;
      justify-content: center; font-size: 1.8rem; flex-shrink: 0;
    }
    .seat-icon-regular { background: rgba(34,197,94,.15); border: 1px solid rgba(34,197,94,.3); }
    .seat-icon-vip     { background: rgba(139,92,246,.15); border: 1px solid rgba(139,92,246,.4); }
    .seat-icon-wheelchair { background: rgba(71,196,255,.15); border: 1px solid rgba(71,196,255,.4); }
    .info-title { font-family: 'Syne', sans-serif; font-size: 1.2rem; font-weight: 700; }
    .info-meta { color: var(--muted); font-size: 0.85rem; margin-top: 5px; line-height: 1.6; }
    .badge {
      display: inline-block; padding: 3px 12px; border-radius: 99px;
      font-size: 0.75rem; font-weight: 600; margin-top: 6px;
    }
    .badge-available { background: rgba(34,197,94,.15); color: var(--available); border: 1px solid rgba(34,197,94,.3); }
    .badge-booked    { background: rgba(239,68,68,.15); color: var(--booked); border: 1px solid rgba(239,68,68,.3); }
    .badge-maintenance { background: rgba(245,158,11,.15); color: var(--maintenance); border: 1px solid rgba(245,158,11,.3); }
    /* Form card */
    .form-card {
      background: var(--surface); border: 1px solid var(--border); border-radius: 14px; padding: 32px;
    }
    .card-title {
      font-family: 'Syne', sans-serif; font-size: 0.78rem; letter-spacing: .1em;
      text-transform: uppercase; color: var(--accent); margin-bottom: 22px;
      padding-bottom: 12px; border-bottom: 1px solid var(--border);
    }
    h1 { font-family: 'Syne', sans-serif; font-size: 1.8rem; font-weight: 800; margin-bottom: 6px; }
    h1 span { color: var(--accent); }
    .subtitle { color: var(--muted); font-size: 0.9rem; margin-bottom: 36px; }
    /* Status options */
    .status-options { display: flex; flex-direction: column; gap: 12px; }
    .status-option {
      display: flex; align-items: center; gap: 14px;
      padding: 14px 18px; border-radius: var(--radius);
      border: 1px solid var(--border); cursor: pointer;
      transition: all .2s; background: var(--surface2);
    }
    .status-option:hover { border-color: var(--muted); }
    .status-option input[type=radio] { display: none; }
    .status-option.selected-available { border-color: var(--available); background: rgba(34,197,94,.07); }
    .status-option.selected-booked    { border-color: var(--booked); background: rgba(239,68,68,.07); }
    .status-option.selected-maintenance { border-color: var(--maintenance); background: rgba(245,158,11,.07); }
    .status-dot { width: 14px; height: 14px; border-radius: 50%; flex-shrink: 0; }
    .dot-available { background: var(--available); }
    .dot-booked    { background: var(--booked); }
    .dot-maintenance { background: var(--maintenance); }
    .status-label { font-weight: 500; font-size: 0.95rem; }
    .status-desc  { font-size: 0.8rem; color: var(--muted); margin-top: 2px; }
    /* Actions */
    .form-actions { display: flex; gap: 12px; justify-content: flex-end; margin-top: 28px; }
    .btn { display: inline-flex; align-items: center; gap: 7px; padding: 11px 26px; border-radius: var(--radius); font-family: 'Syne', sans-serif; font-weight: 600; font-size: 0.88rem; cursor: pointer; text-decoration: none; border: none; transition: all .2s; }
    .btn-primary { background: var(--accent); color: #0d0f14; }
    .btn-primary:hover { background: #d4eb30; }
    .btn-ghost { background: transparent; color: var(--muted); border: 1px solid var(--border); }
    .btn-ghost:hover { color: var(--text); border-color: var(--text); }
    .btn-danger { background: transparent; color: var(--booked); border: 1px solid var(--booked); }
    .btn-danger:hover { background: var(--booked); color: #fff; }
  </style>
</head>
<body>

<%
  Seat seat = (Seat) request.getAttribute("seat");
  if (seat == null) {
    response.sendRedirect(request.getContextPath() + "/venue?action=list");
    return;
  }
  String currentStatus = seat.getStatus().toUpperCase();
  String iconClass = "seat-icon-" + seat.getSeatType().toLowerCase();
  String icon = seat.getSeatType().equals("VIP") ? "★"
              : seat.getSeatType().equals("WHEELCHAIR") ? "♿" : "💺";
%>

<nav>
  <div class="nav-brand">Venue<span>&</span>Seat</div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/venue?action=list">Venues</a>
  </div>
</nav>

<div class="page">
  <div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/venue?action=list">Venues</a>
    › <a href="${pageContext.request.contextPath}/seat?action=view&venueId=<%= seat.getVenueId() %>">Seat Map</a>
    › Edit Status
  </div>

  <h1>Edit <span>Seat Status</span></h1>
  <p class="subtitle">Update the current availability of this seat.</p>

  <!-- Seat Info Card -->
  <div class="info-card">
    <div class="seat-icon <%= iconClass %>"><%= icon %></div>
    <div>
      <div class="info-title">Seat <%= seat.getRowNumber() %><%= seat.getSeatNumber() %></div>
      <div class="info-meta">
        ID: <%= seat.getSeatId() %> &nbsp;·&nbsp;
        Type: <%= seat.getSeatType() %> &nbsp;·&nbsp;
        Price: $<%= seat.getPrice() %>
      </div>
      <span class="badge badge-<%= currentStatus.toLowerCase() %>"><%= currentStatus %></span>
    </div>
  </div>

  <!-- Status Edit Form -->
  <div class="form-card">
    <div class="card-title">Change Status</div>
    <form action="${pageContext.request.contextPath}/seat" method="post" id="statusForm">
      <input type="hidden" name="action" value="updateStatus"/>
      <input type="hidden" name="seatId" value="<%= seat.getSeatId() %>"/>
      <input type="hidden" name="venueId" value="<%= seat.getVenueId() %>"/>
      <input type="hidden" name="status" id="statusInput" value="<%= currentStatus %>"/>

      <div class="status-options">
        <label class="status-option <%= "AVAILABLE".equals(currentStatus) ? "selected-available" : "" %>"
               onclick="selectStatus('AVAILABLE', this)">
          <input type="radio" name="statusRadio" value="AVAILABLE" <%= "AVAILABLE".equals(currentStatus) ? "checked" : "" %>/>
          <div class="status-dot dot-available"></div>
          <div>
            <div class="status-label">Available</div>
            <div class="status-desc">Seat is open and can be booked</div>
          </div>
        </label>

        <label class="status-option <%= "BOOKED".equals(currentStatus) ? "selected-booked" : "" %>"
               onclick="selectStatus('BOOKED', this)">
          <input type="radio" name="statusRadio" value="BOOKED" <%= "BOOKED".equals(currentStatus) ? "checked" : "" %>/>
          <div class="status-dot dot-booked"></div>
          <div>
            <div class="status-label">Booked</div>
            <div class="status-desc">Seat is currently reserved</div>
          </div>
        </label>

        <label class="status-option <%= "MAINTENANCE".equals(currentStatus) ? "selected-maintenance" : "" %>"
               onclick="selectStatus('MAINTENANCE', this)">
          <input type="radio" name="statusRadio" value="MAINTENANCE" <%= "MAINTENANCE".equals(currentStatus) ? "checked" : "" %>/>
          <div class="status-dot dot-maintenance"></div>
          <div>
            <div class="status-label">Maintenance</div>
            <div class="status-desc">Seat is temporarily unavailable</div>
          </div>
        </label>
      </div>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/seat?action=view&venueId=<%= seat.getVenueId() %>" class="btn btn-ghost">Cancel</a>
        <a href="${pageContext.request.contextPath}/seat?action=delete&seatId=<%= seat.getSeatId() %>&venueId=<%= seat.getVenueId() %>"
           class="btn btn-danger"
           onclick="return confirm('Delete this seat permanently?')">Delete Seat</a>
        <button type="submit" class="btn btn-primary">Save Changes →</button>
      </div>
    </form>
  </div>
</div>

<script>
  function selectStatus(value, el) {
    document.getElementById('statusInput').value = value;
    document.querySelectorAll('.status-option').forEach(o => {
      o.classList.remove('selected-available', 'selected-booked', 'selected-maintenance');
    });
    const cls = value === 'AVAILABLE' ? 'selected-available'
              : value === 'BOOKED' ? 'selected-booked' : 'selected-maintenance';
    el.classList.add(cls);
  }
</script>

</body>
</html>