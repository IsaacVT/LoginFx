package uia.dapp.login.controller;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TextField;
import uia.dapp.login.MainStore;
import uia.dapp.login.model.User;
import uia.dapp.login.util.Validate;

import java.util.Optional;

public class LoginController {
    @FXML
    private TextField emailField;
    @FXML
    private TextField passwordField;
    private MainStore mainStore;
    private final Validate validate = new Validate();

    public void setMainLogin(MainStore main) {
        this.mainStore = main;
    }

    @FXML
    public void handleLogin() {
        boolean check = false;

        for (User u : mainStore.getUsers()) {
            if (u.getEmail().equals(emailField.getText())) {
                if (validate.decodePasswordFromHash(passwordField.getText(), u.getPassword())){
                    check = true;
                    mainStore.setLoginStage(false);
                    mainStore.setDataView(true);
                    mainStore.setLoginUser(u);
                    mainStore.initPrincipalStage();
                    mainStore.selectStage();
                }
            }
        }

        if (!check) {
            Alert msg = new Alert(Alert.AlertType.INFORMATION);
            msg.initOwner(mainStore.getPrincipalStage());
            msg.setTitle("Error");
            msg.setHeaderText("The user not exists or the password is incorrect");

            Optional<ButtonType> result = msg.showAndWait();

            if (result.get() == ButtonType.OK) {
                emailField.setText("@ejemplo.com");
                passwordField.setText(null);
            }
        }
    }

    @FXML
    public void handleCancel() {
        System.exit(0);
    }

    @FXML
    public void handleNewUser() {
        mainStore.setLoginStage(false);
        mainStore.initPrincipalStage();
        mainStore.selectStage();
    }
}
