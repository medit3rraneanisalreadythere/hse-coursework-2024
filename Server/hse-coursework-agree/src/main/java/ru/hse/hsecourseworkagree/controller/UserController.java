package ru.hse.hsecourseworkagree.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import ru.hse.hsecourseworkagree.dto.UserDTO;
import ru.hse.hsecourseworkagree.dto.UsernameDTO;
import ru.hse.hsecourseworkagree.model.User;
import ru.hse.hsecourseworkagree.service.UserService;

@RestController
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/api/register")
    public ResponseEntity<String> registerUser(@RequestBody UserDTO userDTO) {
        if (userService.isUserExists(userDTO.getUsername())) {
            return ResponseEntity.badRequest().body("Пользователь с таким именем уже существует");
        }

        userService.registerUser(userDTO.getUsername(), userDTO.getPassword());
        return ResponseEntity.ok("Пользователь зарегистрирован успешно");
    }

    @PostMapping("/api/login")
    public ResponseEntity<String> loginUser(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();

        if (!userService.isUserExists(username)) {
            return ResponseEntity.badRequest().body("Пользователя с таким именем не существует");
        }

        if (!userService.isPasswordCorrect(username, password)) {
            return ResponseEntity.badRequest().body("Неверный пароль");
        }

        return ResponseEntity.ok("Авторизация прошла успешно");
    }

//    @PostMapping("/api/info")
//    public ResponseEntity<UserInfo> getUserInfo(@RequestBody String username) {
//        UserInfo user =
//    }

    @PostMapping("/api/getinfo")
    public ResponseEntity<User> getUserInfo(@RequestBody UsernameDTO usernameDTO) {
        String username = usernameDTO.getUsername();
        User user = userService.getUser(username);

        return ResponseEntity.ok(user);
    }
}