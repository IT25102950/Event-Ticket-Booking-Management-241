package com.example.eventbookingsystem.eventController;

import com.example.eventbookingsystem.eventModel.Event;
import com.example.eventbookingsystem.eventService.EventService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class PageController {

    private final EventService eventService;

    public PageController(EventService eventService) {
        this.eventService = eventService;
    }

    @GetMapping("/event-page")
    public String showEventPage(Model model) {
        model.addAttribute("events", eventService.getAllEvents());
        return "event";
    }

    @GetMapping("/event-page/{type}")
    public String filterEventsByType(@PathVariable String type, Model model) {

        java.util.List<Event> filteredEvents = new java.util.ArrayList<>();

        for (Event event : eventService.getAllEvents()) {
            if (event.getType().equalsIgnoreCase(type)) {
                filteredEvents.add(event);
            }
        }

        model.addAttribute("events", filteredEvents);
        return "event";
    }

    @PostMapping("/add-event-form")
    public String addEventFromForm(Event event) {
        eventService.addEvent(event);
        return "redirect:/event-page";
    }

    @PostMapping("/delete-event-form")
    public String deleteEventFromForm(int id) {
        eventService.deleteEvent(id);
        return "redirect:/event-page";
    }

    @PostMapping("/update-event-form")
    public String updateEventFromForm(Event event) {

        eventService.updateEvent(event.getId(), event);

        return "redirect:/event-page";
    }

    @GetMapping("/event-details/{id}")
    public String showEventDetails(@PathVariable int id, Model model) {

        Event selectedEvent = null;
        String imagePath = "/images/concert.jpg";

        for (Event event : eventService.getAllEvents()) {
            if (event.getId() == id) {
                selectedEvent = event;

                if (event.getType().equalsIgnoreCase("seminar")) {
                    imagePath = "/images/seminar.jpg";
                } else if (event.getType().equalsIgnoreCase("sports")) {
                    imagePath = "/images/edm.jpg";
                }

                break;
            }
        }

        model.addAttribute("event", selectedEvent);
        model.addAttribute("imagePath", imagePath);

        return "details";
    }
}