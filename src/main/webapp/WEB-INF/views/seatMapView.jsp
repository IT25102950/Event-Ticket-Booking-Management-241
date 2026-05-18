<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, java.util.LinkedHashMap" %>
<%@ page import="model.Seat, model.Venue" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Seat Map – Venue & Seat Management</title>
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
    .page { max-width: 1200px; margin: 0 auto; padding: 48px 24px; }
    .breadcrumb { font-size: 0.82rem; color: var(--muted); margin-bottom: 28px; }
    .breadcrumb a { color: var(--accent2); text-decoration: none; }
    /* ── Header ── */
    .page-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 36px; }
    h1 { font-family: 'Syne', sans-serif; font-size: 2rem; font-weight: 800; }
    h1 span { color: var(--accent); }
    .subtitle { color: var(--muted); font-size: 0.9rem; margin-top: 6px; }
    /* ── Stats row ── */
    .stats { display: flex; gap: 16px; margin-bottom: 36px; }
    .stat {
      background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius);
      padding: 16px 22px; min-width: 130px;
    }
    .stat-val { font-family: 'Syne', sans-serif; font-size: 1.8rem; font-weight: 800; }
    .stat-val.green { color: var(--available); }
    .stat-val.red { color: var(--booked); }
    .stat-val.yellow { color: var(--maintenance); }
    .stat-label { font-size: 0.78rem; color: var(--muted); margin-top: 2px; text-transform: uppercase; letter-spacing: .06em; }
    /* ── Legend ── */
    .legend { display: flex; gap: 20px; margin-bottom: 28px; align-items: center; }
    .legend-item { display: flex; align-items: center; gap: 8px; font-size: 0.82rem; color: var(--muted); }
    .dot { width: 13px; height: 13px; border-radius: 4px; }
    .dot-available { background: var(--available); }
    .dot-booked { background: var(--booked); }
    .dot-maintenance { background: var(--maintenance); }
    .dot-vip { background: #8b5cf6; }
    .dot-wheelchair { background: var(--accent2); }
    /* ── Stage ── */
    .stage {
      background: linear-gradient(135deg, #1d2230, #252b36);
      border: 1px solid var(--border); border-radius: 8px;
      text-align: center; padding: 14px; margin-bottom: 32px;
      font-family: 'Syne', sans-serif; font-size: 0.78rem;
      letter-spacing: .14em; text-transform: uppercase; color: var(--muted);
    }
    /* ── Seat Grid ── */
    .rows { display: flex; flex-direction: column; gap: 10px; }
    .row { display: flex; align-items: center; gap: 10px; }
    .row-label {
      font-family: 'Syne', sans-serif; font-size: 0.78rem; font-weight: 700;
      color: var(--muted); width: 24px; text-align: center;
    }
    .seat-btn {
      width: 44px; height: 44px; border-radius: 8px; border: none;
      cursor: pointer; font-family: 'Syne', sans-serif; font-size: 0.7rem; font-weight: 700;
      display: flex; align-items: center; justify-content: center;
      transition: transform .15s, box-shadow .15s; position: relative;
    }
    .seat-btn:hover { transform: scale(1.12); box-shadow: 0 4px 14px rgba(0,0,0,.4); z-index: 2; }
    .seat-available { background: rgba(34,197,94,.18); color: var(--available); border: 1px solid rgba(34,197,94,.4); }
    .seat-booked   { background: rgba(239,68,68,.18); color: var(--booked); border: 1px solid rgba(239,68,68,.4); cursor: default; }
    .seat-maintenance { background: rgba(245,158,11,.18); color: var(--maintenance); border: 1px solid rgba(245,158,11,.4); cursor: default; }
    .seat-vip { border-color: rgba(139,92,246,.6); box-shadow: 0 0 8px rgba(139,92,246,.2); }
    .seat-wheelchair { border-color: rgba(71,196,255,.6); }
    /* tooltip */
    .seat-btn::after {
      content: attr(data-tip); position: absolute; bottom: calc(100% + 8px); left: 50%;
      transform: translateX(-50%); background: #0d0f14; border: 1px solid var(--border);
      color: var(--text); font-size: 0.72rem; padding: 5px 10px; border-radius: 6px;
      white-space: nowrap; pointer-events: none; opacity: 0; transition: opacity .15s;
    }
    .seat-btn:hover::after { opacity: 1; }
    /* ── Table fallback ── */
    .alert { padding: 13px 18px; border-radius: var(--radius); background: rgba(232,255,71,.08); border: 1px solid rgba(232,255,71,.3); color: var(--accent); font-size: 0.9rem; margin-bottom: 28px; }
    /* ── Buttons ── */
    .btn { display: inline-flex; align-items: center; gap: 7px; padding: 10px 22px; border-radius: var(--radius); font-family: 'Syne', sans-serif; font-weight: 600; font-size: 0.88rem; cursor: pointer; text-decoration: none; border: none; transition: all .2s; }
    .btn-primary { background: var(--accent); color: #0d0f14; }
    .btn-primary:hover { background: #d4eb30; }
    .btn-ghost { background: transparent; color: var(--muted); border: 1px solid var(--border); }
    .btn-ghost:hover { color: var(--text); border-color: var(--text); }
  </style>
</head>
<body>

<%
  List<Seat> seats = (List<Seat>) request.getAttribute("seats");
  Venue venue = (Venue) request.getAttribute("venue");
  String venueId = (String) request.getAttribute("venueId");

  int totalSeats = seats != null ? seats.size() : 0;
  int availCount = 0, bookedCount = 0, maintCount = 0;
  if (seats != null) {
    for (Seat s : seats) {
      if ("AVAILABLE".equalsIgnoreCase(s.getStatus())) availCount++;
      else if ("BOOKED".equalsIgnoreCase(s.getStatus())) bookedCount++;
      else maintCount++;
    }
  }

  // Group seats by row
  Map<String, List<Seat>> rowMap = new LinkedHashMap<>();
  if (seats != null) {
    for (Seat s : seats) {
      rowMap.computeIfAbsent(s.getRowNumber(), k -> new java.util.ArrayList<>()).add(s);
    }
  }
%>

<nav>
  <div class="nav-brand">Venue<span>&</span>Seat</div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/venue?action=list">Venues</a>
    <a href="${pageContext.request.contextPath}/venue?action=add">Add Venue</a>
  </div>
</nav>

<div class="page">
  <div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/venue?action=list">Venues</a>
    › <%= venue != null ? venue.getName() : venueId %> › Seat Map
  </div>

  <div class="page-header">
    <div>
      <h1><span><%= venue != null ? venue.getName() : venueId %></span> — Seat Map</h1>
      <p class="subtitle"><%= venue != null ? venue.getLocation() : "" %></p>
    </div>
    <a href="${pageContext.request.contextPath}/venue?action=add" class="btn btn-primary">＋ Add Seat</a>
  </div>

  <%
    String msg = request.getParameter("message");
    if (msg != null && !msg.isEmpty()) {
  %>
  <div class="alert">✓ <%= msg %></div>
  <% } %>

  <!-- Stats -->
  <div class="stats">
    <div class="stat"><div class="stat-val"><%= totalSeats %></div><div class="stat-label">Total Seats</div></div>
    <div class="stat"><div class="stat-val green"><%= availCount %></div><div class="stat-label">Available</div></div>
    <div class="stat"><div class="stat-val red"><%= bookedCount %></div><div class="stat-label">Booked</div></div>
    <div class="stat"><div class="stat-val yellow"><%= maintCount %></div><div class="stat-label">Maintenance</div></div>
  </div>

  <!-- Legend -->
  <div class="legend">
    <div class="legend-item"><div class="dot dot-available"></div> Available</div>
    <div class="legend-item"><div class="dot dot-booked"></div> Booked</div>
    <div class="legend-item"><div class="dot dot-maintenance"></div> Maintenance</div>
    <div class="legend-item"><div class="dot dot-vip"></div> VIP</div>
    <div class="legend-item"><div class="dot dot-wheelchair"></div> Wheelchair</div>
  </div>

  <!-- Stage -->
  <div class="stage">🎭 Stage / Screen</div>

  <!-- Seat Grid -->
  <% if (rowMap.isEmpty()) { %>
  <p style="color:var(--muted); text-align:center; padding: 48px;">No seats found for this venue.</p>
  <% } else { %>
  <div class="rows">
    <%
      for (Map.Entry<String, List<Seat>> entry : rowMap.entrySet()) {
        String row = entry.getKey();
        List<Seat> rowSeats = entry.getValue();
    %>
    <div class="row">
      <div class="row-label"><%= row %></div>
      <%
        for (Seat s : rowSeats) {
          String statusClass = "seat-" + s.getStatus().toLowerCase();
          String typeClass = s.getSeatType().equals("VIP") ? " seat-vip"
                           : s.getSeatType().equals("WHEELCHAIR") ? " seat-wheelchair" : "";
          String icon = s.getSeatType().equals("VIP") ? "★"
                      : s.getSeatType().equals("WHEELCHAIR") ? "♿" : String.valueOf(s.getSeatNumber());
          String tip = s.getSeatId() + " | " + s.getSeatType() + " | $" + s.getPrice() + " | " + s.getStatus();
          String editUrl = request.getContextPath() + "/seat?action=editStatus&seatId=" + s.getSeatId();
          boolean clickable = "AVAILABLE".equalsIgnoreCase(s.getStatus()) || true; // always allow edit
      %>
      <button class="seat-btn <%= statusClass %><%= typeClass %>"
              data-tip="<%= tip %>"
              onclick="window.location='<%= editUrl %>'"
              title="<%= tip %>">
        <%= icon %>
      </button>
      <% } %>
    </div>
    <% } %>
  </div>
  <% } %>
</div>

</body>
</html>