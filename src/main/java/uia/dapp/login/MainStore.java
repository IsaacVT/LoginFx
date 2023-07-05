package uia.dapp.login;

import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import uia.dapp.login.controller.*;
import uia.dapp.login.dao.IProductDAO;
import uia.dapp.login.dao.IUserDAO;
import uia.dapp.login.dao.ProdcutDAO;
import uia.dapp.login.dao.UserDAO;
import uia.dapp.login.model.Product;
import uia.dapp.login.model.User;

import java.io.IOException;

public class MainStore extends Application {

    private Stage principalStage;
    private BorderPane loginView;
    private final ObservableList<User> users = FXCollections.observableArrayList();
    private final ObservableList<Product> products = FXCollections.observableArrayList();
    private final ObservableList<Product> cart = FXCollections.observableArrayList();
    private boolean loginStage = true;
    private boolean dataView = false;
    private final IProductDAO productDAO = new ProdcutDAO();
    private final IUserDAO usersDAO = new UserDAO();
    private User loginUser;

    public MainStore(){
    }

    public ObservableList<User> getUsers() {
        return users;
    }

    public ObservableList<Product> getProducts() {
        return products;
    }

    public ObservableList<Product> getCart() {
        return cart;
    }

    @Override
    public void start(Stage stage) {
        this.principalStage = stage;
        this.principalStage.setTitle("Tienda de Flores - Florería Armonía");

        this.principalStage.getIcons().add(new Image("file:src/main/resources/uia/dapp/login/img/FlowerIcon.png"));
        initPrincipalStage();
        selectStage();
    }

    public void imprimeListas () {
        for (Product p : products) {
            System.out.println(p);
        }
        for (User u : users) {
            System.out.println(u);
        }
    }

    public void selectStage() {
        if (loginStage) {
            showLoginStage();
        } else if (!dataView) {
            showRegisterStage();
        } else {
            showStoreDataStage();
        }
    }

    public void setLoginStage(boolean loginStage) {
        this.loginStage = loginStage;
    }

    public void setDataView(boolean dataView) {
        this.dataView = dataView;
    }

    public void initPrincipalStage() {
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainStore.class.getResource("views/RootStoreView.fxml"));
            loginView = (BorderPane) loader.load();

            Scene scene = new Scene(loginView);
            principalStage.setScene(scene);

            RootLoginViewController controller = loader.getController();
            loadProductFromServer();
            //loadUsersFromServer();
            //imprimeListas();
            controller.setMainLogin(this);

            principalStage.show();

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void showLoginStage() {
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainStore.class.getResource("views/LoginStoreView.fxml"));
            AnchorPane login = (AnchorPane) loader.load();

            loginView.setCenter(login);

            LoginController controller = loader.getController();
            controller.setMainLogin(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void showRegisterStage() {
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainStore.class.getResource("views/RegisterStoreView.fxml"));
            AnchorPane register = (AnchorPane) loader.load();

            loginView.setCenter(register);

            RegisterController controller = loader.getController();
            controller.setMainLogin(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void showStoreDataStage() {
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainStore.class.getResource("views/StoreView.fxml"));
            AnchorPane data = (AnchorPane) loader.load();

            principalStage.setWidth(800);
            principalStage.setHeight(600);
            loginView.setCenter(data);

            StoreDataViewController controller = loader.getController();
            controller.setMainLogin(this);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void showShoppingCartStage() {
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainStore.class.getResource("views/ShoppingCartView.fxml"));
            AnchorPane data = (AnchorPane) loader.load();

            principalStage.setWidth(800);
            principalStage.setHeight(600);
            loginView.setCenter(data);

            ShoppingCartController controller = loader.getController();
            controller.setMainStore(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public User getLoginUser() {
        return loginUser;
    }

    public void setLoginUser(User loginUser) {
        this.loginUser = loginUser;
    }

    public boolean showUserDataDialog() {
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(MainStore.class.getResource("views/UserDataView.fxml"));
            AnchorPane data = (AnchorPane) loader.load();

            principalStage.setWidth(620);
            principalStage.setHeight(435);
            loginView.setCenter(data);

            UserDataViewController controller = loader.getController();
            controller.setMainStore(this);
            controller.setUser(getLoginUser());

            return controller.isOkClicked();
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void loadProductFromServer() {
        products.clear();
        products.addAll(productDAO.getProducts());
    }

    public void loadUsersFromServer() {
        users.clear();
        users.addAll(usersDAO.getUsers());
    }

    public void setNewUserInServer(User tempo) {
        usersDAO.setNewUser(tempo);
        usersDAO.setAccount(tempo);
    }

    public Stage getPrincipalStage() {
        return principalStage;
    }

    public static void main(String[] args) {
        launch(args);
    }
}