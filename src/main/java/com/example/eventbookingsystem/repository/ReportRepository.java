package com.example.eventbookingsystem.repository;

import com.example.eventbookingsystem.model.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReportRepository extends JpaRepository<Report, Integer> {
    List<Report> findByGeneratedBy(int adminId);
    List<Report> findByReportType(String reportType);
}