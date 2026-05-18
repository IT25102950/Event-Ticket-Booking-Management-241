<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Booking System</title>
</head>
<body>
    <h1>Event Booking System</h1>
    <ul>
        <li><a href="<%= request.getContextPath() %>/venue?action=list">Manage Venues</a></li>
        <li><a href="<%= request.getContextPath() %>/seat?action=view">Manage Seats</a></li>
    </ul>
</body>
</html>
