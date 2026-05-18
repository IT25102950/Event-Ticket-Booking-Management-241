package com.example.eventbookingsystem.repository;

import com.example.eventbookingsystem.eventModel.Event;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository extends JpaRepository<Event, Integer> {
}