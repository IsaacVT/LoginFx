package uia.dapp.login.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordEncrypt {
    public static final int PASSWORD_LENGTH = 8;

    public String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(10));
    }

    public Boolean decodePasswordFromHash(String entryPassword, String passwordExist){
        return BCrypt.checkpw(entryPassword, passwordExist);
    }

}
