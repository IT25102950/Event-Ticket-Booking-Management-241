<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Event Ticket Management</title>
    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, sans-serif;
        }

        body{
            background:#f5f5f5;
        }

        /* Navbar */
        .navbar{
            background:white;
            padding:15px 40px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            box-shadow:0 2px 8px rgba(0,0,0,0.08);
        }

        .logo{
            font-size:28px;
            font-weight:bold;
            color:#2563eb;
        }

        .nav-links{
            display:flex;
            gap:30px;
            font-size:16px;
        }

        .nav-links a{
            text-decoration:none;
            color:black;
            font-weight:500;
        }

        /* Categories */
        .categories{
            background:#ffffff;
            padding:15px 30px;
            display:flex;
            gap:20px;
            border-top:1px solid #ddd;
            border-bottom:1px solid #ddd;
            overflow-x:auto;
        }

        .category{
            background:#eef2ff;
            padding:10px 20px;
            border-radius:20px;
            color:#1d4ed8;
            font-weight:bold;
            text-decoration:none;
        }

        /* Main */
        .container{
            width:90%;
            margin:30px auto;
        }

        h2{
            margin-bottom:20px;
            color:#111827;
        }

        /* Horizontal cards */
        .event-card{
            display:flex;
            background:white;
            margin-bottom:20px;
            border-radius:12px;
            overflow:hidden;
            box-shadow:0 4px 10px rgba(0,0,0,0.08);
        }

        .event-card img{
            width:280px;
            height:180px;
            object-fit:cover;
        }

        .event-content{
            padding:20px;
            flex:1;
        }

        .event-content h3{
            margin-bottom:10px;
            color:#111827;
        }

        .event-content p{
            margin:8px 0;
            color:#4b5563;
        }

        .btn{
            display:inline-block;
            margin-top:15px;
            background:#2563eb;
            color:white;
            padding:10px 18px;
            text-decoration:none;
            border-radius:6px;
        }

        /* Add event form */
        .admin-box{
            background:white;
            padding:25px;
            margin-top:40px;
            border-radius:12px;
            box-shadow:0 4px 10px rgba(0,0,0,0.08);
        }

        .admin-box h2{
            margin-bottom:15px;
        }

        input{
            width:100%;
            padding:12px;
            margin:8px 0;
            border:1px solid #ccc;
            border-radius:6px;
        }

        button{
            background:#16a34a;
            color:white;
            border:none;
            padding:12px 20px;
            border-radius:6px;
            cursor:pointer;
            margin-top:10px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">EventHub</div>

    <div class="nav-links">
        <a href="#">Events</a>
        <a href="#">Movies</a>
        <a href="#">Sports</a>
        <a href="#">Concerts</a>
        <a href="#">Theatre</a>
    </div>
</div>

<!-- Categories -->
<div class="categories">
    <a href="/event-page/concert" class="category">Concert</a>
    <a href="/event-page/festival" class="category">Festival</a>
    <a href="/event-page/conference" class="category">Conference</a>
    <a href="/event-page/seminar" class="category">Seminar</a>
    <a href="/event-page/sports" class="category">Sports</a>
    <a href="/event-page/workshop" class="category">Workshop</a>
    <a href="/event-page" class="category">All Events</a>
</div>

<div class="container">

    <h2>Most Recent Events</h2>

    <c:forEach var="event" items="${events}">
        <div class="event-card">
            <c:choose>
                <c:when test="${event.type.toLowerCase() == 'concert'}">
                    <img src="/images/concert.jpg" alt="Concert">
                </c:when>

                <c:when test="${event.type.toLowerCase() == 'sports'}">
                    <img src="/images/sports.jpg" alt="Sports">
                </c:when>

                <c:when test="${event.type.toLowerCase() == 'seminar'}">
                    <img src="/images/seminar.jpg" alt="Seminar">
                </c:when>

                <c:when test="${event.type.toLowerCase() == 'conference'}">
                    <img src="/images/conference.jpg" alt="Conference">
                </c:when>

                <c:otherwise>
                    <img src="/images/default.jpg" alt="Event">
                </c:otherwise>
            </c:choose>

            <div class="event-content">
                <h3>${event.name}</h3>
                <p><strong>Type:</strong> ${event.type}</p>
                <p><strong>Date:</strong> ${event.date}</p>
                <p><strong>Venue:</strong> ${event.venue}</p>
                <p><strong>Price:</strong> Rs. ${event.price}</p>

                <a href="/event-details/${event.id}" class="btn">View Details</a>

            </div>
        </div>
    </c:forEach>

    <!-- Admin Section -->
    <div class="admin-box">
        <h2>Add New Event</h2>

        <form action="/add-event-form" method="post">
            <input type="text" name="id" placeholder="Event ID" required>
            <input type="text" name="name" placeholder="Event Name" required>
            <input type="text" name="type" placeholder="Event Type" required>
            <input type="text" name="date" placeholder="Date" required>
            <input type="text" name="venue" placeholder="Venue" required>
            <input type="text" name="seats" placeholder="Seats" required>
            <input type="text" name="price" placeholder="Price" required>

            <button type="submit">Add Event</button>
        </form>

        <hr style="margin:20px 0;">

        <h2>Delete Event</h2>

        <form action="/delete-event-form" method="post">
            <input type="text" name="id" placeholder="Enter Event ID to Delete" required>
            <button type="submit" style="background:red;">Delete Event</button>
        </form>

        <hr style="margin:20px 0;">

        <h2>Update Event</h2>

        <form action="/update-event-form" method="post">
            <input type="text" name="id" placeholder="Event ID" required>
            <input type="text" name="name" placeholder="New Event Name" required>
            <input type="text" name="type" placeholder="New Event Type" required>
            <input type="text" name="date" placeholder="New Date" required>
            <input type="text" name="venue" placeholder="New Venue" required>
            <input type="text" name="seats" placeholder="New Seats" required>
            <input type="text" name="price" placeholder="New Price" required>

            <button type="submit" style="background:orange;">Update Event</button>
        </form>

    </div>

</div>

</body>
</html>