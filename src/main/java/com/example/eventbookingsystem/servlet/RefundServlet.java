package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.model.Payment;
import com.example.eventbookingsystem.Service.PaymentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/refund")
public class RefundServlet extends HttpServlet {

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
        req.getRequestDispatcher("/WEB-INF/views/refund.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int paymentId = Integer.parseInt(req.getParameter("paymentId"));

        boolean success = paymentService.refundAndDelete(paymentId);

        if (success) {
            req.getSession().setAttribute("flashMsg",
                    "Payment #" + paymentId + " refunded and removed successfully.");
        } else {
            req.getSession().setAttribute("flashMsg",
                    "Refund failed. Payment may not exist.");
        }

        resp.sendRedirect(req.getContextPath() + "/transactions");
    }
}