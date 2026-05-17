package com.example.eventbookingsystem.eventService;

import com.example.eventbookingsystem.eventModel.Event;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EventService {

    private final List<Event> eventList = new ArrayList<>();

    public void addEvent(Event event) {
        eventList.add(event);
    }

    public List<Event> getAllEvents() {
        return eventList;
    }

    public List<Event> searchEvents(String name) {

        List<Event> results = new ArrayList<>();

        for (Event event : eventList) {

            if (event.getName().toLowerCase().contains(name.toLowerCase())) {
                results.add(event);
            }
        }

        return results;
    }

    public boolean updateEvent(int id, Event updatedEvent) {

        for (int i = 0; i < eventList.size(); i++) {

            if (eventList.get(i).getId() == id) {
                updatedEvent.setId(id);
                eventList.set(i, updatedEvent);
                return true;
            }
        }

        return false;
    }

    public boolean deleteEvent(int id) {

        return eventList.removeIf(event -> event.getId() == id);
    }
}
