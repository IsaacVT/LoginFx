package uia.dapp.login.dao;

import uia.dapp.login.model.Product;

import java.util.List;

public interface IProductDAO {
    List<Product> getProducts();
    List<Product> updateAllProducts(List<Product> personList);

    void updateProduct(Product p);

    void setNewProduct(Product p);

    void deleteProduct(Product p, int indexFromTable);

    String selectQuery(int i);
}
