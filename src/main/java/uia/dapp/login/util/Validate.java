package uia.dapp.login.util;

import uia.dapp.login.model.User;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validate extends PasswordEncrypt {
    public boolean validatorUser(User user) {
        return isValidUser(user);
    }

    private boolean isValidUser(User user) {

        // Nombre 1
        if(!isPresent(user.getNombre1().trim())) {
            return false;
        }

        if(!isValidAlphaNumeric(user.getNombre1().trim())) {
            return false;
        }

        user.setNombre1(user.getNombre1().trim());

        // Nombre 2
        user.setNombre2(user.getNombre2().trim());

        // Paterno
        if(!isPresent(user.getPaterno().trim())) {
            return false;
        }

        if(!isValidAlphaNumeric(user.getPaterno().trim())) {
            return false;
        }

        user.setPaterno(user.getPaterno().trim());

        // Materno
        if(!isPresent(user.getMaterno().trim())) {
            return false;
        }

        if(!isValidAlphaNumeric(user.getMaterno().trim())) {
            return false;
        }

        user.setMaterno(user.getMaterno().trim());

        // Email
        if(user.getEmail() == null || user.getEmail().trim().length() == 0) {
            return false;
        }

        user.setEmail(user.getEmail().trim());

        if(!isValidEmail(user.getEmail())) {
            return false;
        }

        // Password
        if(!isPresent(user.getPassword())) {
            return false;
        }

        if(!isValidPassword(user.getPassword())) {
            return false;
        }

        user.setPassword(user.getPassword().trim());

        return true;
    }

    private boolean isPresent(String value) {
        return value != null && value.trim().length() > 0;
    }

    private boolean isValidAlphaNumeric(String value) {
        Pattern pattern = Pattern.compile("[^A-Za-z0-9]");
        Matcher matcher = pattern.matcher(value);
        return !matcher.find();
    }

    private boolean isValidEmail(String value) {
        Pattern pattern = Pattern.compile("^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
        Matcher matcher = pattern.matcher(value);
        return matcher.find();
    }

    private static boolean isValidPassword(String password) {
        if (password.length() < PASSWORD_LENGTH)
            return false;

        int charCount = 0;
        int numCount = 0;

        for (int i = 0; i < password.length(); i++) {
            char ch = password.charAt(i);
            if (isNumeric(ch)) numCount++;
            else if (isLetter(ch)) charCount++;
            else return false;
        }
        return (charCount >= 2 && numCount >= 2);
    }

    private static boolean isLetter(char ch) {
        ch = Character.toUpperCase(ch);
        return (ch >= 'A' && ch <= 'Z');
    }

    private static boolean isNumeric(char ch) {
        return (ch >= '0' && ch <= '9');
    }
}

