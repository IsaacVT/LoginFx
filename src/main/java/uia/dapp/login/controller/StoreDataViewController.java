package uia.dapp.login.controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.text.Text;
import uia.dapp.login.MainStore;
import uia.dapp.login.model.Product;

public class StoreDataViewController {
    @FXML
    private TableView<Product> tablaProducto;
    @FXML
    private TableColumn<Product, String> nombreProducto;
    @FXML
    private Label tipoLabel;
    @FXML
    private Label nombreLabel;
    @FXML
    private ComboBox<String> stockSeleccion;
    @FXML
    private Label costoLabel;
    @FXML
    private Label envioLabel;
    @FXML
    private Text descripcionField;
    @FXML
    private Label vendedorLabel;
    @FXML
    private Button cartLabel;
    private MainStore mainStore;

    public StoreDataViewController() {
    }

    @FXML
    private void initialize() {
        nombreProducto.setCellValueFactory(
                cellData -> cellData.getValue().nombreProperty());

        showProductData(null);

        tablaProducto.getSelectionModel().selectedItemProperty().addListener(
                (observable, oldValue, newValue) -> showProductData(newValue));
    }

    public void setMainLogin(MainStore main) {
        this.mainStore = main;
        tablaProducto.setItems(mainStore.getProducts());
        cartLabel.setText(String.valueOf(main.getCart().size()));
    }

    public void showProductData (Product product) {
        if (product != null) {
            tipoLabel.setText(product.getTipo());
            nombreLabel.setText(product.getNombre());
            stockSeleccion.setItems(cantidadProd(product.getStock()));
            costoLabel.setText("Costo : $ " + String.valueOf(product.getCosto()));
            envioLabel.setText("Envío : $ " + String.valueOf(product.getEnvio()));
            descripcionField.setText(product.getDescripcion().getText());
            descripcionField.wrappingWidthProperty().set(300);
            vendedorLabel.setText(product.getVendedor());
        } else {
            tipoLabel.setText("Tipo");
            nombreLabel.setText("Nombre");
            stockSeleccion.setItems(cantidadProd(1));
            costoLabel.setText("Costo : $ 0.0");
            envioLabel.setText("Envío : $ 0.0");
            descripcionField.setText("Descripción");
            vendedorLabel.setText("Vendedor");
        }
    }

    public ObservableList<String> cantidadProd (int cantidad) {
        ObservableList<String> cantProd = FXCollections.observableArrayList();
        for (int i = 1; i < cantidad; i++) {
            cantProd.add(String.valueOf(i));
         }

        return cantProd;
    }

    @FXML
    public void handleAgregar() {
        Product temp = tablaProducto.getSelectionModel().getSelectedItem();
        temp.setStock(Integer.parseInt(stockSeleccion.getSelectionModel().getSelectedItem()));

        boolean okClicked = mainStore.getCart().add(temp);
        if (okClicked) {
            cartLabel.setText(String.valueOf(mainStore.getCart().size()));
        } else {
            // Nothing selected.
            Alert alert = new Alert(Alert.AlertType.WARNING);
            alert.initOwner(mainStore.getPrincipalStage());
            alert.setTitle("Precaución");
            alert.setHeaderText("Ningún contacto seleccionado");
            alert.setContentText("Por favor seleccione un contacto del registro.");

            alert.showAndWait();
        }
    }

    @FXML
    public void handleShoppingCart() {
        mainStore.initPrincipalStage();
        mainStore.showShoppingCartStage();
    }

    @FXML
    public void handleUsuario() {
        mainStore.initPrincipalStage();
        mainStore.showUserDataDialog();
    }
}
