package uia.dapp.login.dao;

import uia.dapp.login.model.Product;
import uia.dapp.login.model.User;

import java.util.List;

public interface IUserDAO {
    public List<User> getUsers();
    public List<User> updateAllUsers(List<User> usersList);

    void updateUser(User user);

    public void setNewUser(User user);

    void deleteUser(User user, int indexFromTable);
    String selectQuery(int i);

    void setAccount(User tempo);

}
