package com.example.eventbookingsystem.util;

import com.example.eventbookingsystem.eventModel.Event;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

    private static final String FILE_NAME = "events.txt";

    public static void saveEvents(List<Event> events) {

        try (ObjectOutputStream oos =
                     new ObjectOutputStream(new FileOutputStream(FILE_NAME))) {

            oos.writeObject(events);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static List<Event> loadEvents() {

        File file = new File(FILE_NAME);

        if (!file.exists()) {
            return new ArrayList<>();
        }

        try (ObjectInputStream ois =
                     new ObjectInputStream(new FileInputStream(FILE_NAME))) {

            return (List<Event>) ois.readObject();

        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
}
