package uia.dapp.login.controller;

import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.ImageView;
import javafx.stage.FileChooser;
import javafx.stage.Modality;
import javafx.stage.Stage;
import uia.dapp.login.MainStore;
import uia.dapp.login.model.User;
import uia.dapp.login.util.DateUtil;
import uia.dapp.login.util.PasswordEncrypt;

import java.io.File;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.Optional;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

public class UserDataViewController {
    @FXML
    private TextField fNombreField;
    @FXML
    private TextField sNombreField;
    @FXML
    private TextField paternoField;
    @FXML
    private TextField maternoField;
    @FXML
    private TextField nacimientoField;
    @FXML
    private TextField telefonoField;
    @FXML
    private TextField emailField;
    @FXML
    private TextField newPasswordField;
    @FXML
    private TextField repeatPasswordField;

    private Stage dialogStage;
    private User us;
    private boolean okClicked = false;
    private boolean cambio = false;
    private MainStore mainStore;
    private PasswordEncrypt encrypt = new PasswordEncrypt();

    @FXML
    private void initialize() {
    }

    public void setDialogStage(Stage dialogStage) {
        this.dialogStage = dialogStage;
    }

    public void setMainStore(MainStore mainStore) {
        this.mainStore = mainStore;
    }

    public void setUser(User user) {
        this.us = user;

        fNombreField.setText(us.getNombre1());
        sNombreField.setText(us.getNombre2());
        paternoField.setText(us.getPaterno());
        maternoField.setText(us.getMaterno());
        nacimientoField.setText(DateUtil.format(us.getFechaNacimiento()));
        nacimientoField.setPromptText("dd/mm/yyyy");
        telefonoField.setText(us.getCelNumber());
        emailField.setText(us.getEmail());
        newPasswordField.setText("12345678");
        newPasswordField.setEditable(false);
        repeatPasswordField.setText("12345678");
        repeatPasswordField.setEditable(false);
    }

    public boolean isOkClicked() {
        return okClicked;
    }

    @FXML
    private void handleGuardar() {
        try {
            if (isInputValid()) {
                us.setNombre1(fNombreField.getText());
                us.setNombre2(sNombreField.getText());
                us.setPaterno(paternoField.getText());
                us.setMaterno(maternoField.getText());
                us.setFechaNacimiento(DateUtil.parse(nacimientoField.getText()));
                us.setCelNumber(telefonoField.getText());
                us.setEmail(emailField.getText());
                if (cambio) {
                    us.setPassword(encrypt.hashPassword(newPasswordField.getText()));
                }

                okClicked = true;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @FXML
    private void handleCambiarPasword() {
        newPasswordField.setText(null);
        repeatPasswordField.setText(null);

        newPasswordField.setEditable(true);
        repeatPasswordField.setEditable(true);

        cambio = true;
    }

    @FXML
    private void handleBorrar() {
        int selectedIndex = mainStore.getUsers().indexOf(us);
        if (selectedIndex >= 0) {

            Alert sure = new Alert(Alert.AlertType.CONFIRMATION);
            sure.initOwner(mainStore.getPrincipalStage());
            sure.setTitle("Precaución");
            sure.setHeaderText(null);
            sure.setHeaderText("¿Quieres eliminar tu cuenta?");

            Optional<ButtonType> result = sure.showAndWait();

            if (result.get() == ButtonType.OK){

                //mainApp.deletePersonInServer(selectedIndex);

                mainStore.getUsers().remove(selectedIndex);

                Alert info = new Alert(Alert.AlertType.INFORMATION);
                info.initOwner(mainStore.getPrincipalStage());
                info.setTitle("Borrado exitoso");
                info.setHeaderText(null);
                info.setContentText("La información del contacto ha sido eliminada.");

                info.showAndWait();


            } else {
                // ... user chose CANCEL or closed the dialog
                return;
            }


        }
    }

    @FXML
    public void handleRegresar() {
        mainStore.initPrincipalStage();
        mainStore.showStoreDataStage();
    }

    @FXML
    public void handleLogout() {
        mainStore.setDataView(false);
        mainStore.setLoginStage(true);
        mainStore.setLoginUser(null);
        mainStore.initPrincipalStage();
        mainStore.selectStage();
    }

    private boolean isInputValid() {
        String errorMessage = "";

        if (fNombreField.getText() == null || fNombreField.getText().length() == 0 || fNombreField.getText().length() > 60 || fNombreField.getText().length() < 2) {
            errorMessage += "Primer nombre no válido!\n";
        }

        if (paternoField.getText() == null || paternoField.getText().length() == 0 || paternoField.getText().length() > 60 || paternoField.getText().length() < 2) {
            errorMessage += "Apellido Paterno no válido!\n";
        }

        if (maternoField.getText() == null || maternoField.getText().length() == 0 || maternoField.getText().length() > 60 || maternoField.getText().length() < 2) {
            errorMessage += "Apellido Materno no válido!\n";
        }

        if (nacimientoField.getText() == null || nacimientoField.getText().length() == 0) {
            errorMessage += "Fecha de cumpleaños no válida!\n";
        } else {
            if (!DateUtil.validDate(nacimientoField.getText())) {
                errorMessage += "Fecha de cumpleaños no válida. Usa el formato dd.mm.yyyy!\n";
            }
        }

        if (telefonoField.getText() == null || telefonoField.getText().length() == 0 || telefonoField.getText().length() > 10 || telefonoField.getText().length() < 10) {
            errorMessage += "Número de celular no válido!\n";
        } else {
            try {
                Long.parseLong(telefonoField.getText());
            } catch (NumberFormatException e) {
                errorMessage += "Número de celular no válido (intenta con valor tipo long)!\n";
            }
        }

        if (errorMessage.length() == 0) {
            return true;
        } else {
            // Show the error message.
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.initOwner(dialogStage);
            alert.setTitle("Campos inválidos");
            alert.setHeaderText("Por favor corrige los campos erróneos para continuar");
            alert.setContentText(errorMessage);

            alert.showAndWait();

            return false;
        }
    }
}
