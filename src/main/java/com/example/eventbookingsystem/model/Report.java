package com.example.eventbookingsystem.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "reports")
public class Report {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "report_title")
    private String reportTitle;

    @Column(name = "report_type")
    private String reportType;   // daily, weekly, monthy

    @Column(name = "generated_by")
    private int generatedBy;     // admin id who made this report

    @Column(name = "total_bookings")
    private int totalBookings;

    @Column(name = "total_revenue")
    private double totalRevenue;

    @Column(name = "report_date")
    private LocalDate reportDate;

    // Empty constructor (required by Spring)
    public Report() {}

    // Constructor (creating a new report)
    public Report(String reportTitle, String reportType, int generatedBy, int totalBookings, double totalRevenue, LocalDate reportDate) {
        this.reportTitle   = reportTitle;
        this.reportType    = reportType;
        this.generatedBy   = generatedBy;
        this.totalBookings = totalBookings;
        this.totalRevenue  = totalRevenue;
        this.reportDate    = reportDate;
    }

    // Getters and Setters
    public int getId()                      {
        return id;
    }
    public void setId(int id)               {
        this.id = id;
    }

    public String getReportTitle()          {
        return reportTitle;
    }
    public void setReportTitle(String t)    {
        this.reportTitle = t;
    }

    public String getReportType()           {
        return reportType;
    }
    public void setReportType(String t)     {
        this.reportType = t;
    }

    public int getGeneratedBy()             {
        return generatedBy;
    }
    public void setGeneratedBy(int g)       {
        this.generatedBy = g;
    }

    public int getTotalBookings()           {
        return totalBookings;
    }
    public void setTotalBookings(int b)     {
        this.totalBookings = b;
    }

    public double getTotalRevenue()         {
        return totalRevenue;
    }
    public void setTotalRevenue(double r)   {
        this.totalRevenue = r;
    }

    public LocalDate getReportDate()        {
        return reportDate;
    }
    public void setReportDate(LocalDate d)  {
        this.reportDate = d;
    }
}
