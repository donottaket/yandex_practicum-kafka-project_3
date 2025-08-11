package kz.yandex_practicum.kafka.practical_work_5.consumer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.kafka.annotation.KafkaListener;

import java.util.List;

@SpringBootApplication
public class ConsumerApplication {

    public static void main(String[] args) {
        SpringApplication.run(ConsumerApplication.class, args);
    }

    @KafkaListener(topics = "practical_work_5.public.orders", groupId = "practical_work_5_group")
    public void consumeOrders(List<practical_work_5.public$.orders.Value> orders) {
        System.out.println("Received orders: " + orders + " | Total orders: " + orders.size());
    }

    @KafkaListener(topics = "practical_work_5.public.users", groupId = "practical_work_5_group")
    public void consumeUsers(List<practical_work_5.public$.users.Value> users) {
        System.out.println("Received users: " + users + " | Total users: " + users.size());
    }
}