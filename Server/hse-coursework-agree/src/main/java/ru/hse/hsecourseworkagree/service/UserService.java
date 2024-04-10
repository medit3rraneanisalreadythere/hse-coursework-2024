package ru.hse.hsecourseworkagree.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.hse.hsecourseworkagree.model.User;
import ru.hse.hsecourseworkagree.repository.UserRepository;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public void registerUser(String username, String password) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName("Joe Testington");
        user.setInfo("I'm begin automatically created by SQL query!");
        userRepository.save(user);
    }

    public boolean isPasswordCorrect(String username, String password) {
        Optional<User> optionalUser = userRepository.findByUsername(username);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            return user.getPassword().equals(password);
        }
        return false; // Пользователь с таким именем не найден
    }

    public boolean isUserExists(String username) {
        return userRepository.existsByUsername(username);
    }

    public User getUser(String username) {
        Optional<User> optionalUser = userRepository.findByUsername(username);

        return optionalUser.get();
    }
}