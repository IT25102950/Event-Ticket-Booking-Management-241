package com.example.eventbookingsystem.service;

import org.springframework.stereotype.Service;
import java.io.*;
import java.util.Scanner;

    @Service
    public class DashboardService {
        // Path to my text files in the root
        private final String BOOKING_FILE = "data/bookings.txt";

        public double calculateTotalRevenue() {
            double revenue = 0;
            try (Scanner scanner = new Scanner(new File(BOOKING_FILE))) {
                while (scanner.hasNextLine()) {
                    String line = scanner.nextLine();

                    // Assuming format:( user,event,price)
                    String[] parts = line.split(",");
                    revenue += Double.parseDouble(parts[2]);
                }
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            return revenue;
        }

        public int countTotalBookings() {
            int count = 0;
            try (BufferedReader reader = new BufferedReader(new FileReader(BOOKING_FILE))) {
                while (reader.readLine() != null) count++;
            } catch (IOException e) {
                e.printStackTrace();
            }
            return count;
        }
    }

