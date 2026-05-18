<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Event Details</title>
    <style>
        body{
            font-family: Arial;
            margin:0;
            background:#f3f4f6;
        }

        .banner img {
            width: 100%;
            height: 350px;
            object-fit: contain;
            border-radius: 12px;
            background: #f3f4f6;
        }

        .container{
            width:80%;
            margin:30px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0 4px 10px rgba(0,0,0,0.1);
        }

        h1{
            color:#1e3a8a;
        }

        p{
            font-size:18px;
            margin:12px 0;
        }

        .book-btn{
            display:inline-block;
            margin-top:20px;
            background:#16a34a;
            color:white;
            padding:14px 25px;
            text-decoration:none;
            border-radius:8px;
            font-size:18px;
        }
    </style>
</head>
<body>

<div class="banner">
    <img src="${imagePath}" alt="Event Banner">
</div>

<div class="container">
    <h1>${event.name}</h1>

    <p><strong>Type:</strong> ${event.type}</p>
    <p><strong>Date:</strong> ${event.date}</p>
    <p><strong>Venue:</strong> ${event.venue}</p>
    <p><strong>Available Seats:</strong> ${event.seats}</p>
    <p><strong>Ticket Price:</strong> Rs. ${event.price}</p>

    <p style="margin-top:20px; line-height:1.8; color:#374151; font-size:17px;">
        Experience an unforgettable event with exciting performances, premium seating,
        and a vibrant atmosphere. Browse all event information including date, venue,
        ticket availability, and pricing. Secure your seat early and enjoy a seamless
        booking experience through our event ticket management platform.
    </p>

    <a href="#" class="book-btn">Book Now</a>
</div>

</body>
</html>