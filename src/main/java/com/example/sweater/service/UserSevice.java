package com.example.sweater.service;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserSevice implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private MailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepo.findByUsername(username);
    }

    public boolean addUser (User user){
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if (userFromDb != null) {
            return false;
        }

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        sendMessage(user);
        userRepo.save(user);

        return true;
    }

    public boolean activateUser (String activationCode){
       User userFromDb = userRepo.findByActivationCode(activationCode);
        if (userFromDb == null) {
            return false;
        }
        userFromDb.setActivationCode(null);
        userRepo.save(userFromDb);
        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public User findByUsername(String username){return  userRepo.findByUsername(username);}

    public boolean isSubscribed (Long channelId, Long userId){return userRepo.isSubscribed(channelId, userId);}

    public boolean subscribe (Long channelId, Long subscriptionId){return userRepo.subscribe(channelId, subscriptionId);}

    public boolean unsubscribe (Long channelId, Long subscriptionId) {return userRepo.unsubscribe(channelId, subscriptionId);}

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepo.save(user);
    }

    public void userUpdate(User user, String mail, String password) {
        String userEmail = user.getMail();
        boolean isEmailChanged = (userEmail != null && !userEmail.equals(mail)) || (mail != null && mail.equals(userEmail));
        if (isEmailChanged){
            user.setMail(mail);

            if (StringUtils.isEmpty(mail)){
               user.setActivationCode(UUID.randomUUID().toString());
            }
            sendMessage(user);
        }
        if (StringUtils.isEmpty(password)){
            user.setPassword(password);
        }

        userRepo.save(user);
    }

    public void sendMessage(User user){
        if (!StringUtils.isEmpty(user.getMail())){
            String message = String.format(
                    "Hello, %s \n" +
                            "Welcome to Sweater. To proove your e-mail please visit nest link: http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );
            mailSender.send(user.getMail(),"Activation code", message);
        }
    }
}
