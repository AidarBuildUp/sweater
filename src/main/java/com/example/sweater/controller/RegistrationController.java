package com.example.sweater.controller;

import com.example.sweater.domain.User;
import com.example.sweater.dto.reCAPTCHAdto;
import com.example.sweater.service.UserSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.annotation.AliasFor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class RegistrationController {
    static final String reCaptchaURL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Autowired
    private UserSevice userSevice;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${recaptcha.secretkey}")
    private String recaptchaKey;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@RequestParam String passwordConfirmation,
                          @RequestParam ("g-recaptcha-response") String gRecaptchaResponse,
                          @Valid User user,
                          BindingResult bindingResult,
                          Model model) {

        boolean passwordConfirmationFall = passwordConfirmation == null || !passwordConfirmation.equals(user.getPassword());
        if (passwordConfirmationFall){
            model.addAttribute("password2Error","Password and his confirmation are different");
        }

        boolean reCaptchaError = false;
        if (gRecaptchaResponse.isEmpty()){
            model.addAttribute("reCaptchaError", "Please check reCAPTCHA box");
            reCaptchaError = true;
        } else {
            String URL = String.format(reCaptchaURL, recaptchaKey, gRecaptchaResponse);
            reCAPTCHAdto reCaptchadto = restTemplate.getForObject(URL, reCAPTCHAdto.class);
            if (!reCaptchadto.isSuccess()) reCaptchaError = true;
        }

        if (passwordConfirmationFall || bindingResult.hasErrors() || reCaptchaError){
            Map <String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("user", user);
            return "registration";
        } else {
            boolean userSuccessfullyAdded = userSevice.addUser(user);
            if (!userSuccessfullyAdded) {
                model.addAttribute("message", "User exists!");
            } else {
                model.addAttribute("message", "Activation code is sending on your mail, please check it");
            }
        }
        return "/login";
    }

    @GetMapping ("/activate/{activationCode}")
    public String activate (Model model, @PathVariable String activationCode){
        boolean isActivated = userSevice.activateUser(activationCode);
        if (isActivated){
            model.addAttribute("message", "User successfully activated!");
            return "/login";
        } else {
            model.addAttribute("message", "Activation code is already accepted!");
        }
        return "/registration";
    }

}
