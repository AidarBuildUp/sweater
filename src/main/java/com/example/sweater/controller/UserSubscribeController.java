package com.example.sweater.controller;

import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import com.example.sweater.service.UserSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Set;

@Controller
public class UserSubscribeController {

    @Autowired
    private UserSevice userSevice;

    @GetMapping("subscribe/{channel}")
    public String subscribeToAuthor(
            @PathVariable String channel,
            @AuthenticationPrincipal User user
    ){
        Long channelId = userSevice.findByUsername(channel).getId();
        userSevice.subscribe(channelId, user.getId());
        return ("redirect:/messages/" + channel);
    }

    @GetMapping("unsubscribe/{channel}")
    public String unsubscribeFromAuthor(
            @PathVariable String channel,
            @AuthenticationPrincipal User user,
            Model model
    ){
        Long channelId = userSevice.findByUsername(channel).getId();
        userSevice.unsubscribe(channelId, user.getId());
        return "redirect:/messages/" + channel;
    }

    @GetMapping ("subscriptions")
    public String subscriptions (
            @AuthenticationPrincipal User user,
            Model model
    ){
        User currentUser = userSevice.findByUsername(user.getUsername());
        Set<User> subscribers = currentUser.getSubscribers();
        model.addAttribute("subscribers", subscribers);
        Set<User> subscriptions = currentUser.getSubscriptions();
        model.addAttribute("subscriptions", subscriptions);
        return "userSubscriptions";
    }
}
