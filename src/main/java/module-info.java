module uia.dapp.login {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires jbcrypt;


    opens uia.dapp.login to javafx.fxml;
    opens uia.dapp.login.controller;
    opens uia.dapp.login.model;
    exports uia.dapp.login;

}