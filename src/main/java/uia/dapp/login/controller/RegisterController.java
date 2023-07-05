package uia.dapp.login.controller;

import javafx.fxml.FXML;
import javafx.scene.control.*;
import uia.dapp.login.MainStore;
import uia.dapp.login.model.User;
import uia.dapp.login.util.Validate;

import java.util.Optional;

public class RegisterController {
    @FXML
    private TextField fNombreField;
    @FXML
    private TextField sNombreField;
    @FXML
    private TextField paternoField;
    @FXML
    private TextField maternoField;
    @FXML
    private TextField emailField;
    @FXML
    private TextField newPasswordField;
    @FXML
    private TextField repeatPasswordField;
    private MainStore mainStore;
    private final Validate validator = new Validate();

    public void setMainLogin(MainStore main) {
        this.mainStore = main;
    }
    @FXML
    public void handleRegister() {
        boolean check = false;

        User uTemp = new User(fNombreField.getText(), sNombreField.getText(), paternoField.getText(), maternoField.getText(), emailField.getText(), newPasswordField.getText());

        if (validator.validatorUser(uTemp)) {
            if (uTemp.getPassword().equals(repeatPasswordField.getText())) {
                uTemp.setPassword(validator.hashPassword(repeatPasswordField.getText()));
                check = true;
            } else {
                Alert atention = new Alert(Alert.AlertType.INFORMATION);
                atention.initOwner(mainStore.getPrincipalStage());
                atention.setTitle("Error");
                atention.setHeaderText("Passwords no match");

                Optional<ButtonType> result = atention.showAndWait();

                if (result.get() == ButtonType.OK){
                    newPasswordField.setText(null);
                    repeatPasswordField.setText(null);
                }
            }

            if (check) {
                mainStore.getUsers().add(uTemp);
                System.out.println(mainStore.getUsers().toString());
                //mainStore.setNewUserInServer(uTemp);

                Alert atention = new Alert(Alert.AlertType.INFORMATION);
                atention.initOwner(mainStore.getPrincipalStage());
                atention.setTitle("Success");
                atention.setHeaderText("You can login now");

                Optional<ButtonType> result = atention.showAndWait();

                if (result.get() == ButtonType.OK){
                    handleCancelRegister();
                }
            }
        } else {
            Alert error = new Alert(Alert.AlertType.ERROR);
            error.initOwner(mainStore.getPrincipalStage());
            error.setTitle("Error");
            error.setHeaderText("Incorrect information!");

            Optional<ButtonType> result = error.showAndWait();

            if (result.get() == ButtonType.OK){
                mainStore.initPrincipalStage();
                mainStore.selectStage();
            }
        }
    }
    @FXML
    public void handleCancelRegister() {
        mainStore.setLoginStage(true);
        mainStore.initPrincipalStage();
        mainStore.selectStage();
    }
}
