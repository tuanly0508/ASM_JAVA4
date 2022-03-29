package com.laptopshop.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.laptopshop.entities.NguoiDung;
import com.laptopshop.service.NguoiDungService;
import com.laptopshop.service.SecurityService;
import com.laptopshop.validator.NguoiDungValidator;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.Date;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Controller
public class RegisterController {

    @Autowired
    private NguoiDungService nguoiDungService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private NguoiDungValidator nguoiDungValidator;

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("newUser", new NguoiDung());
        return "client/register";
    }

    @PostMapping("/register")
    public String registerProcess(@ModelAttribute("newUser") @Valid NguoiDung nguoiDung, BindingResult bindingResult,
            Model model) {

        nguoiDungValidator.validate(nguoiDung, bindingResult);

        if (bindingResult.hasErrors()) {
            return "client/register";
        }

        nguoiDungService.saveUserForMember(nguoiDung);

        try {
            sendMail(nguoiDung.getEmail(), nguoiDung.getEmail(), nguoiDung.getPassword());
        } catch (Exception e) {
        }

        securityService.autologin(nguoiDung.getEmail(), nguoiDung.getConfirmPassword());

        return "redirect:/";
    }

    public static void sendMail(String email, String username, String pass)
            throws MessagingException, UnsupportedEncodingException {
        final String fromEmail = "anhttpk01720@fpt.edu.vn";
        final String password = "anhnhama159";
        final String toEmail = email;
        final String subject = "Register success !!!";
        final String body = "You have successfully registered an account with username: " + username + " ";
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };
        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);
        // set message headers
        msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
        msg.addHeader("format", "flowed");
        msg.addHeader("Content-Transfer-Encoding", "8bit");
        msg.setFrom(new InternetAddress(fromEmail, "NoReply-JD"));
        msg.setReplyTo(InternetAddress.parse(fromEmail, false));
        msg.setSubject(subject, "UTF-8");
        msg.setText(body, "UTF-8");
        msg.setSentDate(new Date());
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
        Transport.send(msg);
    }
}
