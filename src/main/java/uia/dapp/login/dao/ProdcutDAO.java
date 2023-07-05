package uia.dapp.login.dao;

import uia.dapp.login.db.DBConnection;
import uia.dapp.login.db.IDBConnection;
import uia.dapp.login.model.Product;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProdcutDAO implements IProductDAO {
    private static Connection connection;
    private static IDBConnection iConn;

    public ProdcutDAO() {
    }

    @Override
    public List<Product> getProducts() {
        List<Product> prodList = null;

        try {
            connection = new DBConnection().connectDB();
            Statement state = connection.createStatement();

            ResultSet result = state.executeQuery(selectQuery(0));

            prodList = new ArrayList<>();

            while (result.next()) {
                Product prod = new Product(
                        result.getInt(1),
                        result.getString(2),    // tipo
                        result.getString(3),    // nombre
                        result.getInt(4),    // stock
                        result.getFloat(5),    // costo
                        result.getFloat(6),    // envio
                        result.getString(7),    //descripcion
                        result.getString(8)      // vendedor
                );

                prodList.add(prod);
            }

            iConn.disconnectDB(connection);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return prodList;
    }

    @Override
    public List<Product> updateAllProducts(List<Product> personList) {
        return null;
    }

    @Override
    public void updateProduct(Product p) {

    }

    @Override
    public void setNewProduct(Product p) {

    }

    @Override
    public void deleteProduct(Product p, int indexFromTable) {

    }
    @Override
    public String selectQuery(int i) {
        String query = "";
        switch (i) {
            case 0:
                query = "select id_producto, tipo_producto, nombre, stock, costo, costo_envio, descripcion, vendido_por from vista_catalogo";
                break;
            case 1:
                query = "select * from catalogo";
                break;
        }
        return query;
    }
}
