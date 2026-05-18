<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Venue" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Venue List – Venue & Seat Management</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --bg: #0d0f14;
      --surface: #161a22;
      --border: #252b36;
      --accent: #e8ff47;
      --accent2: #47c4ff;
      --text: #eef0f4;
      --muted: #6b7280;
      --danger: #ff4f4f;
      --radius: 10px;
    }
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'DM Sans', sans-serif;
      min-height: 100vh;
    }
    /* ── Nav ── */
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 18px 40px;
      border-bottom: 1px solid var(--border);
      background: var(--surface);
    }
    .nav-brand { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.2rem; letter-spacing: -0.02em; }
    .nav-brand span { color: var(--accent); }
    .nav-links a {
      color: var(--muted); text-decoration: none; font-size: 0.9rem;
      margin-left: 28px; transition: color .2s;
    }
    .nav-links a:hover, .nav-links a.active { color: var(--text); }
    /* ── Page ── */
    .page { max-width: 1100px; margin: 0 auto; padding: 48px 24px; }
    .page-header {
      display: flex; align-items: flex-end; justify-content: space-between;
      margin-bottom: 36px;
    }
    h1 { font-family: 'Syne', sans-serif; font-size: 2.4rem; font-weight: 800; line-height: 1; }
    h1 span { color: var(--accent); }
    .subtitle { color: var(--muted); font-size: 0.9rem; margin-top: 6px; }
    /* ── Button ── */
    .btn {
      display: inline-flex; align-items: center; gap: 7px;
      padding: 10px 22px; border-radius: var(--radius);
      font-family: 'Syne', sans-serif; font-weight: 600; font-size: 0.88rem;
      cursor: pointer; text-decoration: none; border: none; transition: all .2s;
    }
    .btn-primary { background: var(--accent); color: #0d0f14; }
    .btn-primary:hover { background: #d4eb30; transform: translateY(-1px); }
    .btn-danger { background: transparent; color: var(--danger); border: 1px solid var(--danger); padding: 7px 16px; font-size: 0.82rem; }
    .btn-danger:hover { background: var(--danger); color: #fff; }
    .btn-secondary { background: transparent; color: var(--accent2); border: 1px solid var(--accent2); padding: 7px 16px; font-size: 0.82rem; }
    .btn-secondary:hover { background: var(--accent2); color: #0d0f14; }
    /* ── Alert ── */
    .alert {
      padding: 13px 18px; border-radius: var(--radius);
      background: rgba(232,255,71,.08); border: 1px solid rgba(232,255,71,.3);
      color: var(--accent); font-size: 0.9rem; margin-bottom: 28px;
    }
    /* ── Table ── */
    .table-wrap { overflow-x: auto; border-radius: var(--radius); border: 1px solid var(--border); }
    table { width: 100%; border-collapse: collapse; }
    thead tr { background: var(--surface); border-bottom: 1px solid var(--border); }
    th {
      padding: 14px 20px; text-align: left;
      font-family: 'Syne', sans-serif; font-size: 0.78rem;
      letter-spacing: .08em; text-transform: uppercase; color: var(--muted);
    }
    tbody tr { border-bottom: 1px solid var(--border); transition: background .15s; }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: rgba(255,255,255,.03); }
    td { padding: 16px 20px; font-size: 0.92rem; }
    .venue-name { font-weight: 500; color: var(--text); }
    .venue-id { font-size: 0.78rem; color: var(--muted); margin-top: 2px; }
    .badge {
      display: inline-block; padding: 3px 10px; border-radius: 99px;
      font-size: 0.75rem; font-weight: 600; background: rgba(71,196,255,.12); color: var(--accent2);
    }
    .actions { display: flex; gap: 8px; align-items: center; }
    /* ── Empty ── */
    .empty {
      text-align: center; padding: 72px 24px; color: var(--muted);
    }
    .empty-icon { font-size: 3rem; margin-bottom: 16px; }
    .empty p { font-size: 1rem; }
  </style>
</head>
<body>

<nav>
  <div class="nav-brand">Venue<span>&</span>Seat</div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/venue?action=list" class="active">Venues</a>
    <a href="${pageContext.request.contextPath}/venue?action=add">Add Venue</a>
  </div>
</nav>

<div class="page">
  <div class="page-header">
    <div>
      <h1>All <span>Venues</span></h1>
      <p class="subtitle">Manage hall layouts and seat configurations</p>
    </div>
    <a href="${pageContext.request.contextPath}/venue?action=add" class="btn btn-primary">＋ Add Venue</a>
  </div>

  <%
    String msg = request.getParameter("message");
    if (msg != null && !msg.isEmpty()) {
  %>
  <div class="alert">✓ <%= msg %></div>
  <% } %>

  <%
    List<Venue> venues = (List<Venue>) request.getAttribute("venues");
    if (venues == null || venues.isEmpty()) {
  %>
  <div class="empty">
    <div class="empty-icon">🏛️</div>
    <p>No venues found. Add your first venue to get started.</p>
  </div>
  <%
  } else {
  %>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Venue</th>
          <th>Location</th>
          <th>Total Seats</th>
          <th>Description</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% for (Venue v : venues) { %>
        <tr>
          <td>
            <div class="venue-name"><%= v.getName() %></div>
            <div class="venue-id">#<%= v.getVenueId() %></div>
          </td>
          <td><%= v.getLocation() %></td>
          <td><span class="badge"><%= v.getTotalSeats() %> seats</span></td>
          <td style="color:var(--muted);font-size:0.88rem;"><%= v.getDescription() %></td>
          <td>
            <div class="actions">
              <a href="${pageContext.request.contextPath}/seat?action=view&venueId=<%= v.getVenueId() %>" class="btn btn-secondary">Seat Map</a>
              <a href="${pageContext.request.contextPath}/venue?action=delete&venueId=<%= v.getVenueId() %>"
                 class="btn btn-danger"
                 onclick="return confirm('Delete venue <%= v.getName() %>?')">Delete</a>
            </div>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
  <% } %>
</div>

</body>
</html>