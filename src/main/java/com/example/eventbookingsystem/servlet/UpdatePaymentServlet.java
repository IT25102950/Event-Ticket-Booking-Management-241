package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.model.Payment;
import com.example.eventbookingsystem.Service.PaymentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/update-payment")
public class UpdatePaymentServlet extends HttpServlet {

    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int paymentId = Integer.parseInt(req.getParameter("id"));

        Payment payment = paymentService.getPaymentById(paymentId);

        if (payment == null) {
            resp.sendRedirect(req.getContextPath() + "/transactions");
            return;
        }

        req.setAttribute("payment", payment);

        // ✅ FIXED PATH
        req.getRequestDispatcher("/WEB-INF/views/update-payment.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int    paymentId = Integer.parseInt(req.getParameter("paymentId"));
        String newStatus = req.getParameter("status");
        String notes     = req.getParameter("notes");

        boolean updated = paymentService.updateStatus(paymentId, newStatus, notes);

        if (updated) {
            req.getSession().setAttribute("flashMsg",
                    "✅ Payment #" + paymentId + " updated to " + newStatus);
        } else {
            req.getSession().setAttribute("flashMsg",
                    "❌ Failed to update payment. Try again.");
        }

        resp.sendRedirect(req.getContextPath() + "/transactions");
    }
}