package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import com.example.sweater.service.UserSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Set;

@Controller
public class UserMessagesController {
    @Autowired
    private UserSevice userSevice;

    @GetMapping ("/messages/{username}")
    public String getUserMessages(
            @AuthenticationPrincipal User user,
            @PathVariable String username,
            Model model
    ){
        User interestedUser = userSevice.findByUsername(username);
        Set<Message> userMessages = interestedUser.getMessages();
        model.addAttribute("messages", userMessages);
        model.addAttribute("author", interestedUser.getUsername());
        if (userSevice.isSubscribed(interestedUser.getId(), user.getId())) {
            model.addAttribute("isSubscribed", true);
        } else {
            model.addAttribute("isSubscribed", false);
        }
        return "userMessages";
    }

    @GetMapping ("/message/{message.id}")
    public String editMessage(
        @PathVariable ("message.id") Message message,
                Model model
    ){
        model.addAttribute("message", message);
        return "message";
    }


    public boolean isSubscribed (Long channelId, Long userId){
        return userSevice.isSubscribed(channelId, userId);
    }
}
