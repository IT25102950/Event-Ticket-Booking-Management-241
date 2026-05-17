package com.example.eventbookingsystem.eventController;

import com.example.eventbookingsystem.eventModel.Event;
import com.example.eventbookingsystem.eventService.EventService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/events")
public class EventController {

    private final EventService eventService;

    public EventController(EventService eventService) {
        this.eventService = eventService;
    }

    // Add Event
    @PostMapping
    public String addEvent(@RequestBody Event event) {

        eventService.addEvent(event);

        return "Event Added Successfully";
    }

    @GetMapping
    public List<Event> getAllEvents() {

        return eventService.getAllEvents();
    }

    @GetMapping("/search/{name}")
    public List<Event> searchEvents(@PathVariable String name) {

        return eventService.searchEvents(name);
    }

    @PutMapping("/{id}")
    public String updateEvent(@PathVariable int id,
                              @RequestBody Event updatedEvent) {

        boolean updated = eventService.updateEvent(id, updatedEvent);

        if (updated) {
            return "Event Updated Successfully";
        }

        return "Event Not Found";
    }

    @DeleteMapping("/{id}")
    public String deleteEvent(@PathVariable int id) {

        boolean deleted = eventService.deleteEvent(id);

        if (deleted) {
            return "Event Deleted Successfully";
        }

        return "Event Not Found";
    }
}