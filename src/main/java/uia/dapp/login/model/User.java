package uia.dapp.login.model;

import javafx.beans.property.*;
import uia.dapp.login.util.Validate;

import java.time.LocalDate;

public class User {
    private final IntegerProperty id;
    private final StringProperty nombre1;
    private final StringProperty nombre2;
    private final StringProperty paterno;
    private final StringProperty materno;
    private final StringProperty email;
    private final StringProperty password;
    private final ObjectProperty<LocalDate> fechaNacimiento;
    private final SimpleStringProperty celNumber;

    private Integer contaUser = 0;

    public User(Integer id, String nombre1, String nombre2, String paterno, String materno, LocalDate fechaNacimiento, String celNumber, String email, String password) {
        this.id = new SimpleIntegerProperty(id);
        this.nombre1 = new SimpleStringProperty(nombre1);
        this.nombre2 = new SimpleStringProperty(nombre2);
        this.paterno = new SimpleStringProperty(paterno);
        this.materno = new SimpleStringProperty(materno);
        this.email = new SimpleStringProperty(email);
        this.password = new SimpleStringProperty(password);
        this.fechaNacimiento = new SimpleObjectProperty<LocalDate>(fechaNacimiento);
        this.celNumber = new SimpleStringProperty(celNumber);
    }

    public User(String fNombre, String sNombre, String pater, String mater, String email, String password) {
        this.id = new SimpleIntegerProperty(contaUser++);
        this.nombre1 = new SimpleStringProperty(fNombre);
        this.nombre2 = new SimpleStringProperty(sNombre);
        this.paterno = new SimpleStringProperty(pater);
        this.materno = new SimpleStringProperty(mater);
        this.email = new SimpleStringProperty(email);
        this.password = new SimpleStringProperty(password);
        this.fechaNacimiento = new SimpleObjectProperty<LocalDate>(LocalDate.of(1999, 1, 1));
        this.celNumber = new SimpleStringProperty("5512345678");
    }

    public int getId() {
        return id.get();
    }

    public IntegerProperty idProperty() {
        return id;
    }

    public void setId(int id) {
        this.id.set(id);
    }

    public String getNombre1() {
        return nombre1.get();
    }

    public StringProperty nombre1Property() {
        return nombre1;
    }

    public void setNombre1(String nombre1) {
        this.nombre1.set(nombre1);
    }

    public String getNombre2() {
        return nombre2.get();
    }

    public StringProperty nombre2Property() {
        return nombre2;
    }

    public void setNombre2(String nombre2) {
        this.nombre2.set(nombre2);
    }

    public String getPaterno() {
        return paterno.get();
    }

    public StringProperty paternoProperty() {
        return paterno;
    }

    public void setPaterno(String paterno) {
        this.paterno.set(paterno);
    }

    public String getMaterno() {
        return materno.get();
    }

    public StringProperty maternoProperty() {
        return materno;
    }

    public void setMaterno(String materno) {
        this.materno.set(materno);
    }

    public String getEmail() {
        return email.get();
    }

    public StringProperty emailProperty() {
        return email;
    }

    public void setEmail(String email) {
        this.email.set(email);
    }

    public String getPassword() {
        return password.get();
    }

    public StringProperty passwordProperty() {
        return password;
    }

    public void setPassword(String password) {
        this.password.set(password);
    }

    public String getCelNumber() {
        return celNumber.get();
    }

    public SimpleStringProperty celNumberProperty() {
        return celNumber;
    }

    public void setCelNumber(String celNumber) {
        this.celNumber.set(celNumber);
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento.get();
    }

    public ObjectProperty<LocalDate> fechaNacimientoProperty() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento.set(fechaNacimiento);
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nombre1=" + nombre1 +
                ", nombre2=" + nombre2 +
                ", paterno=" + paterno +
                ", materno=" + materno +
                ", email=" + email +
                ", password=" + password +
                ", fechaNacimiento=" + fechaNacimiento +
                ", celNumber=" + celNumber +
                '}';
    }
}