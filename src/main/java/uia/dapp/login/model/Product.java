package uia.dapp.login.model;

import javafx.beans.property.*;
import javafx.beans.value.ObservableValue;
import javafx.collections.ObservableList;
import javafx.scene.control.TextArea;

import java.time.LocalDate;

public class Product {
    private final IntegerProperty id;
    private final StringProperty tipo;
    private final StringProperty nombre;
    private final IntegerProperty stock;
    private final FloatProperty costo;
    private final FloatProperty envio;
    private final TextArea descripcion;
    private final StringProperty vendedor;

    private StringProperty info;
    private Integer contaProd = 0;

    public Product(Integer id, String tipo, String nombre, Integer stock, Float costo, Float envio, String descripcion, String vendedor) {
        this.id = new SimpleIntegerProperty(id);
        this.tipo = new SimpleStringProperty(tipo);
        this.nombre = new SimpleStringProperty(nombre);
        this.stock = new SimpleIntegerProperty(stock);
        this.costo = new SimpleFloatProperty(costo);
        this.envio = new SimpleFloatProperty(envio);
        this.descripcion = new TextArea(descripcion);
        this.vendedor = new SimpleStringProperty(vendedor);
    }

    public Product(String tipo, String nombre, Integer stock, Float costo, Float envio, String descripcion, String vendedor) {
        this.id = new SimpleIntegerProperty(contaProd++);
        this.tipo = new SimpleStringProperty(tipo);
        this.nombre = new SimpleStringProperty(nombre);
        this.stock = new SimpleIntegerProperty(stock);
        this.costo = new SimpleFloatProperty(costo);
        this.envio = new SimpleFloatProperty(envio);
        this.descripcion = new TextArea(descripcion);
        this.vendedor = new SimpleStringProperty(vendedor);
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

    public String getTipo() {
        return tipo.get();
    }

    public StringProperty tipoProperty() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo.set(tipo);
    }

    public String getNombre() {
        return nombre.get();
    }

    public StringProperty nombreProperty() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre.set(nombre);
    }

    public int getStock() {
        return stock.get();
    }

    public IntegerProperty stockProperty() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock.set(stock);
    }

    public float getCosto() {
        return costo.get();
    }

    public FloatProperty costoProperty() {
        return costo;
    }

    public void setCosto(float costo) {
        this.costo.set(costo);
    }

    public float getEnvio() {
        return envio.get();
    }

    public FloatProperty envioProperty() {
        return envio;
    }

    public void setEnvio(float envio) {
        this.envio.set(envio);
    }

    public TextArea getDescripcion() {
        return descripcion;
    }

    public String getVendedor() {
        return vendedor.get();
    }

    public StringProperty vendedorProperty() {
        return vendedor;
    }

    public void setVendedor(String vendedor) {
        this.vendedor.set(vendedor);
    }

    public String getInfo() {
        return info.get();
    }

    public StringProperty infoProperty() {
        return info;
    }

    public void setInfo(Product p) {

        String info = p.getNombre() + '\t'
                + p.getStock() + '\n'
                + String.valueOf(p.getCosto()) + '\t'
                + String.valueOf(p.getEnvio());

        this.info.set(info);
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", tipo=" + tipo +
                ", nombre=" + nombre +
                ", stock=" + stock +
                ", costo=" + costo +
                ", envio=" + envio +
                ", descripcion=" + descripcion +
                ", vendedor=" + vendedor +
                '}';
    }

}
