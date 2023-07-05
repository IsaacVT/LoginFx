package uia.dapp.login.controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import uia.dapp.login.MainStore;
import uia.dapp.login.model.Product;

import java.util.Optional;

public class ShoppingCartController {
    @FXML
    private TableView<Product> tablaCarrito;
    @FXML
    private TableColumn<Product, String> productosPedidos;
    @FXML
    private TableColumn<Product, String> cantidadPedidos;
    @FXML
    private TableColumn<Product, String> costoPedidos;
    @FXML
    private TableColumn<Product, String> envioPedidos;
    @FXML
    private Label cantidadCarritoLabel;
    @FXML
    private Label costoProductosLabel;
    @FXML
    private Label costoEnviosLabel;
    @FXML
    private Label pagoTotalLabel;

    ObservableList<Product> carrito = FXCollections.observableArrayList();

    private MainStore mainStore;

    public ShoppingCartController() {
    }

    @FXML
    private void initialize() {
        productosPedidos.setCellValueFactory(cellData -> cellData.getValue().nombreProperty());
        cantidadPedidos.setCellValueFactory(cellData -> cellData.getValue().stockProperty().asString());
        costoPedidos.setCellValueFactory(cellData -> cellData.getValue().costoProperty().asString());
        envioPedidos.setCellValueFactory(cellData -> cellData.getValue().envioProperty().asString());
    }

    public void setMainStore(MainStore main) {
        this.mainStore = main;
        setCarrito();

        actualizarDatos();
    }

    public void actualizarDatos() {
        cantidadCarritoLabel.setText("Cantidad de productos : " + sumarValores(carrito,"cantidad"));
        costoProductosLabel.setText("Costo Productos : $ " + sumarValores(carrito,"costo"));
        costoEnviosLabel.setText("Costo Envío : $ " + sumarValores(carrito,"envio"));
        pagoTotalLabel.setText("Total a pagar : $ " + sumarValores(carrito,"total"));
    }

    public ObservableList<Product> getCarrito() {
        return carrito;
    }

    public void setCarrito() {
        this.carrito = mainStore.getCart();
        tablaCarrito.setItems(this.carrito);
    }

    public String sumarValores(ObservableList<Product> products, String valor) {
        Integer cant = 0;
        Float costoTotal = 0.0f;
        Float envioTotal = 0.0f;
        String resultado = "";
        for (Product p : products) {
            switch (valor) {
                case "cantidad":
                    cant = cant + p.getStock();
                    break;
                case "costo":
                    costoTotal = costoTotal + p.getCosto();
                    break;
                case "envio":
                    envioTotal = envioTotal + p.getEnvio();
                    break;
            }
        }

        switch (valor) {
            case "cantidad":
                resultado = String.valueOf(cant);
                break;
            case "costo":
                resultado = String.valueOf(costoTotal);
                break;
            case "envio":
                resultado = String.valueOf(envioTotal);
                break;
            case "total":
                resultado = String.valueOf(costoTotal + envioTotal);
                break;
        }

        return resultado;
    }

    @FXML
    public void handleComprar() {
        System.out.println("Comprar");
    }

    @FXML
    public void handleEliminar() {
        int selectedIndex = tablaCarrito.getSelectionModel().getSelectedIndex();
        if (selectedIndex >= 0) {

            Alert sure = new Alert(Alert.AlertType.CONFIRMATION);
            sure.initOwner(mainStore.getPrincipalStage());
            sure.setTitle("Precaución");
            sure.setHeaderText(null);
            sure.setHeaderText("¿Borrar este articulo?");

            Optional<ButtonType> result = sure.showAndWait();

            if (result.get() == ButtonType.OK){

                tablaCarrito.getItems().remove(selectedIndex);

                Alert info = new Alert(Alert.AlertType.INFORMATION);
                info.initOwner(mainStore.getPrincipalStage());
                info.setTitle("Borrado exitoso");
                info.setHeaderText(null);
                info.setContentText("La información del contacto ha sido eliminada.");

                actualizarDatos();

                info.showAndWait();
            } else {
                // ... user chose CANCEL or closed the dialog
                return;
            }

        } else {
            // Nothing selected.
            Alert alert = new Alert(Alert.AlertType.WARNING);
            alert.initOwner(mainStore.getPrincipalStage());
            alert.setTitle("Precaución");
            alert.setHeaderText("Ningún articulo seleccionado");
            alert.setContentText("Por favor seleccione un articulo para borrar.");

            alert.showAndWait();
        }
    }

    @FXML
    public void handleRegresar() {
        mainStore.initPrincipalStage();
        mainStore.showStoreDataStage();
    }
}
