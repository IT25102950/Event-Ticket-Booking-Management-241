package com.example.eventbookingsystem.eventService;

import com.example.eventbookingsystem.eventModel.Event;
import com.example.eventbookingsystem.repository.EventRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EventService {

    private final EventRepository eventRepository;

    public EventService(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    public void addEvent(Event event) {
        eventRepository.save(event);
    }

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    public List<Event> searchEvents(String name) {
        List<Event> results = new ArrayList<>();

        for (Event event : eventRepository.findAll()) {
            if (event.getName().toLowerCase().contains(name.toLowerCase())) {
                results.add(event);
            }
        }

        return results;
    }

    public boolean updateEvent(int id, Event updatedEvent) {
        if (eventRepository.existsById(id)) {
            updatedEvent.setId(id);
            eventRepository.save(updatedEvent);
            return true;
        }
        return false;
    }

    public boolean deleteEvent(int id) {
        if (eventRepository.existsById(id)) {
            eventRepository.deleteById(id);
            return true;
        }
        return false;
    }
}