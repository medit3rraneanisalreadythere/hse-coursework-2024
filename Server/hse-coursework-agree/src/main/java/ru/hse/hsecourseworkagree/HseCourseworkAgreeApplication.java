package ru.hse.hsecourseworkagree;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackages = {"ru.hse.hsecourseworkagree.*"})
@EnableJpaRepositories(basePackages = {"ru.hse.hsecourseworkagree.*"})
@ComponentScan(basePackages = {"ru.hse.hsecourseworkagree.*"})
public class HseCourseworkAgreeApplication {

	public static void main(String[] args) {
		SpringApplication.run(HseCourseworkAgreeApplication.class, args);
	}

}
