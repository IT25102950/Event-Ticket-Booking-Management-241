package com.example.eventbookingsystem.servlet;

import com.example.eventbookingsystem.model.Payment;
import com.example.eventbookingsystem.Service.PaymentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/transactions")
public class TransactionServlet extends HttpServlet {

    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Payment> payments = paymentService.getAllTransactions();

        req.setAttribute("payments", payments);

        // ✅ FIXED PATH
        req.getRequestDispatcher("/WEB-INF/views/transaction-history.jsp").forward(req, resp);
    }
}