package com.example.eventbookingsystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.builder.SpringApplicationBuilder;
import com.example.eventbookingsystem.servlet.VenueServlet;
import com.example.eventbookingsystem.servlet.SeatServlet;

@SpringBootApplication
public class EventBookingSystemApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(EventBookingSystemApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(EventBookingSystemApplication.class);
    }

    @Bean
    public ServletRegistrationBean<VenueServlet> venueServlet() {
        ServletRegistrationBean<VenueServlet> bean =
                new ServletRegistrationBean<>(new VenueServlet(), "/venue");
        bean.setLoadOnStartup(1);
        return bean;
    }

    @Bean
    public ServletRegistrationBean<SeatServlet> seatServlet() {
        ServletRegistrationBean<SeatServlet> bean =
                new ServletRegistrationBean<>(new SeatServlet(), "/seat");
        bean.setLoadOnStartup(1);
        return bean;
    }
}