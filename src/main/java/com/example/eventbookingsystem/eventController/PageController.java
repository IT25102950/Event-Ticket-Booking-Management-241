package com.example.eventbookingsystem.eventController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/event-page")
    public String showEventPage() {
        return "event";
    }
}