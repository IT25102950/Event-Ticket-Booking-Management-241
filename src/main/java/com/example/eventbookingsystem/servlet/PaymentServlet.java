package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.Service.PaymentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String bookingId = req.getParameter("bookingId");
        if (bookingId != null) {
            req.setAttribute("bookingId", bookingId);
        }
        // ✅ FIXED PATH
        req.getRequestDispatcher("/WEB-INF/views/payment-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int    bookingId = Integer.parseInt(req.getParameter("bookingId"));
        String custName  = req.getParameter("customerName");
        double amount    = Double.parseDouble(req.getParameter("amount"));
        String method    = req.getParameter("paymentMethod");

        String resultMessage;

        if ("CARD".equals(method)) {
            String cardNumber = req.getParameter("cardNumber");
            String cardHolder = req.getParameter("cardHolder");
            String expiry     = req.getParameter("expiryDate");

            resultMessage = paymentService.processCardPayment(
                    bookingId, custName, amount, cardNumber, cardHolder, expiry
            );
        } else {
            double received = Double.parseDouble(req.getParameter("amountReceived"));
            resultMessage = paymentService.processCashPayment(
                    bookingId, custName, amount, received
            );
        }

        req.setAttribute("resultMessage", resultMessage);
        req.setAttribute("customerName",  custName);
        req.setAttribute("amount",        String.format("%.2f", amount));
        req.setAttribute("paymentMethod", method);
        req.setAttribute("bookingId",     bookingId);

        // ✅ FIXED PATH
        req.getRequestDispatcher("/WEB-INF/views/payment-receipt.jsp").forward(req, resp);
    }
}