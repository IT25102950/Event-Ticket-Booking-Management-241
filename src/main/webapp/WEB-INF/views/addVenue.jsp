<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Add Venue – Venue & Seat Management</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --bg: #0d0f14; --surface: #161a22; --surface2: #1d2230;
      --border: #252b36; --accent: #e8ff47; --accent2: #47c4ff;
      --text: #eef0f4; --muted: #6b7280; --radius: 10px;
    }
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body { background: var(--bg); color: var(--text); font-family: 'DM Sans', sans-serif; min-height: 100vh; }
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 18px 40px; border-bottom: 1px solid var(--border); background: var(--surface);
    }
    .nav-brand { font-family: 'Syne', sans-serif; font-weight: 800; font-size: 1.2rem; }
    .nav-brand span { color: var(--accent); }
    .nav-links a { color: var(--muted); text-decoration: none; font-size: 0.9rem; margin-left: 28px; transition: color .2s; }
    .nav-links a:hover { color: var(--text); }
    .page { max-width: 680px; margin: 0 auto; padding: 48px 24px; }
    .breadcrumb { font-size: 0.82rem; color: var(--muted); margin-bottom: 28px; }
    .breadcrumb a { color: var(--accent2); text-decoration: none; }
    .breadcrumb a:hover { text-decoration: underline; }
    h1 { font-family: 'Syne', sans-serif; font-size: 2rem; font-weight: 800; margin-bottom: 8px; }
    h1 span { color: var(--accent); }
    .subtitle { color: var(--muted); font-size: 0.9rem; margin-bottom: 40px; }
    /* ── Form Card ── */
    .card {
      background: var(--surface); border: 1px solid var(--border);
      border-radius: 14px; padding: 36px; margin-bottom: 28px;
    }
    .card-title {
      font-family: 'Syne', sans-serif; font-size: 0.78rem;
      letter-spacing: .1em; text-transform: uppercase;
      color: var(--accent); margin-bottom: 24px; padding-bottom: 12px;
      border-bottom: 1px solid var(--border);
    }
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }
    .form-group { display: flex; flex-direction: column; gap: 7px; margin-bottom: 18px; }
    .form-group:last-child { margin-bottom: 0; }
    label { font-size: 0.83rem; color: var(--muted); font-weight: 500; letter-spacing: .02em; }
    input, textarea, select {
      background: var(--surface2); border: 1px solid var(--border);
      border-radius: var(--radius); padding: 11px 14px;
      color: var(--text); font-family: 'DM Sans', sans-serif; font-size: 0.93rem;
      transition: border-color .2s, box-shadow .2s; outline: none;
      width: 100%;
    }
    input:focus, textarea:focus, select:focus {
      border-color: var(--accent); box-shadow: 0 0 0 3px rgba(232,255,71,.1);
    }
    textarea { resize: vertical; min-height: 80px; }
    select option { background: var(--surface2); }
    /* Checkbox row */
    .check-row { display: flex; align-items: center; gap: 10px; }
    .check-row input[type=checkbox] { width: 17px; height: 17px; accent-color: var(--accent); cursor: pointer; }
    .check-row label { font-size: 0.88rem; color: var(--text); cursor: pointer; margin: 0; }
    /* ── Seat type extra fields ── */
    .extra-fields { display: none; margin-top: 14px; padding-top: 14px; border-top: 1px solid var(--border); }
    .extra-fields.visible { display: block; }
    /* ── Actions ── */
    .form-actions { display: flex; gap: 12px; justify-content: flex-end; margin-top: 32px; }
    .btn {
      display: inline-flex; align-items: center; gap: 7px;
      padding: 11px 26px; border-radius: var(--radius);
      font-family: 'Syne', sans-serif; font-weight: 600; font-size: 0.88rem;
      cursor: pointer; text-decoration: none; border: none; transition: all .2s;
    }
    .btn-primary { background: var(--accent); color: #0d0f14; }
    .btn-primary:hover { background: #d4eb30; transform: translateY(-1px); }
    .btn-ghost { background: transparent; color: var(--muted); border: 1px solid var(--border); }
    .btn-ghost:hover { color: var(--text); border-color: var(--text); }
    /* Tabs for venue / seat */
    .tabs { display: flex; gap: 0; border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; margin-bottom: 32px; }
    .tab-btn {
      flex: 1; padding: 12px; background: transparent; color: var(--muted);
      border: none; cursor: pointer; font-family: 'Syne', sans-serif; font-size: 0.88rem; font-weight: 600;
      transition: all .2s; border-right: 1px solid var(--border);
    }
    .tab-btn:last-child { border-right: none; }
    .tab-btn.active { background: var(--accent); color: #0d0f14; }
    .tab-content { display: none; }
    .tab-content.active { display: block; }
  </style>
</head>
<body>

<nav>
  <div class="nav-brand">Venue<span>&</span>Seat</div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/venue?action=list">Venues</a>
    <a href="${pageContext.request.contextPath}/venue?action=add">Add Venue</a>
  </div>
</nav>

<div class="page">
  <div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/venue?action=list">Venues</a> › Add New
  </div>

  <h1>Add <span>Venue</span></h1>
  <p class="subtitle">Register a new venue and configure its seats.</p>

  <div class="tabs">
    <button class="tab-btn active" onclick="switchTab('venue', this)">🏛️ Venue Details</button>
    <button class="tab-btn" onclick="switchTab('seat', this)">💺 Add a Seat</button>
  </div>

  <!-- ── TAB 1: Add Venue ── -->
  <div id="tab-venue" class="tab-content active">
    <form action="${pageContext.request.contextPath}/venue" method="post">
      <input type="hidden" name="action" value="add"/>
      <div class="card">
        <div class="card-title">Venue Information</div>
        <div class="form-row">
          <div class="form-group">
            <label for="venueId">Venue ID</label>
            <input type="text" id="venueId" name="venueId" placeholder="e.g. V001" required/>
          </div>
          <div class="form-group">
            <label for="name">Venue Name</label>
            <input type="text" id="name" name="name" placeholder="e.g. Main Hall" required/>
          </div>
        </div>
        <div class="form-group">
          <label for="location">Location</label>
          <input type="text" id="location" name="location" placeholder="e.g. Block A, 2nd Floor" required/>
        </div>
        <div class="form-group">
          <label for="totalSeats">Total Seat Capacity</label>
          <input type="number" id="totalSeats" name="totalSeats" min="1" placeholder="e.g. 200" required/>
        </div>
        <div class="form-group">
          <label for="description">Description</label>
          <textarea id="description" name="description" placeholder="Brief description of the venue..."></textarea>
        </div>
      </div>
      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/venue?action=list" class="btn btn-ghost">Cancel</a>
        <button type="submit" class="btn btn-primary">Save Venue →</button>
      </div>
    </form>
  </div>

  <!-- ── TAB 2: Add Seat ── -->
  <div id="tab-seat" class="tab-content">
    <form action="${pageContext.request.contextPath}/seat" method="post">
      <input type="hidden" name="action" value="add"/>
      <div class="card">
        <div class="card-title">Seat Information</div>
        <div class="form-row">
          <div class="form-group">
            <label for="seatId">Seat ID</label>
            <input type="text" id="seatId" name="seatId" placeholder="e.g. S001" required/>
          </div>
          <div class="form-group">
            <label for="venueId2">Venue ID</label>
            <input type="text" id="venueId2" name="venueId" placeholder="e.g. V001" required/>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label for="rowNumber">Row</label>
            <input type="text" id="rowNumber" name="rowNumber" placeholder="e.g. A" required/>
          </div>
          <div class="form-group">
            <label for="seatNumber">Seat Number</label>
            <input type="number" id="seatNumber" name="seatNumber" min="1" placeholder="e.g. 12" required/>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label for="price">Price ($)</label>
            <input type="number" step="0.01" id="price" name="price" placeholder="e.g. 15.00" required/>
          </div>
          <div class="form-group">
            <label for="seatType">Seat Type</label>
            <select id="seatType" name="seatType" onchange="toggleSeatExtras(this.value)">
              <option value="REGULAR">Regular</option>
              <option value="VIP">VIP</option>
              <option value="WHEELCHAIR">Wheelchair</option>
            </select>
          </div>
        </div>
        <!-- VIP extra -->
        <div id="vip-extra" class="extra-fields">
          <div class="check-row">
            <input type="checkbox" id="includesLounge" name="includesLounge"/>
            <label for="includesLounge">Includes Lounge Access</label>
          </div>
        </div>
        <!-- Wheelchair extra -->
        <div id="wheelchair-extra" class="extra-fields">
          <div class="check-row">
            <input type="checkbox" id="hasCompanionSeat" name="hasCompanionSeat"/>
            <label for="hasCompanionSeat">Has Companion Seat</label>
          </div>
        </div>
      </div>
      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/venue?action=list" class="btn btn-ghost">Cancel</a>
        <button type="submit" class="btn btn-primary">Add Seat →</button>
      </div>
    </form>
  </div>
</div>

<script>
  function switchTab(name, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById('tab-' + name).classList.add('active');
  }
  function toggleSeatExtras(type) {
    document.getElementById('vip-extra').classList.toggle('visible', type === 'VIP');
    document.getElementById('wheelchair-extra').classList.toggle('visible', type === 'WHEELCHAIR');
  }
</script>

</body>
</html>