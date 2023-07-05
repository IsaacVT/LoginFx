package uia.dapp.login.dao;

import uia.dapp.login.db.DBConnection;
import uia.dapp.login.db.IDBConnection;
import uia.dapp.login.model.User;
import uia.dapp.login.util.DateUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements IUserDAO {
    private static IDBConnection conn;
    private static Connection connection;

    public UserDAO() {
    }

    @Override
    public List<User> getUsers() {
        List<User> userList = null;

        try {
            connection = new DBConnection().connectDB();
            Statement state = connection.createStatement();

            ResultSet result = state.executeQuery(selectQuery(1));

            userList = new ArrayList<>();

            while (result.next()) {
                User person = new User(
                        result.getInt(1),    // id
                        result.getString(2),    // fNombre
                        result.getString(3),    // sNombre
                        result.getString(4),    // paterno
                        result.getString(5),    // materno
                        result.getDate(6).toLocalDate(),    // nacimiento
                        result.getString(7),      // celNumber
                        result.getString(8),    // email
                        result.getString(9)    // password
                );

                userList.add(person);
            }

            conn.disconnectDB(connection);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return userList;
    }

    @Override
    public List<User> updateAllUsers(List<User> usersList) {
        return null;
    }

    @Override
    public void updateUser(User user) {

    }

    @Override
    public void setNewUser(User user) {
        try {
            connection = new DBConnection().connectDB();

            PreparedStatement state = connection.prepareStatement(selectQuery(2));

            state.setString(1, user.getNombre1());
            state.setString(2, user.getNombre2());
            state.setString(3, user.getPaterno());
            state.setString(4, user.getMaterno());
            state.setDate(5, Date.valueOf(user.getFechaNacimiento()));
            state.setString(6, user.getCelNumber());
            state.setInt(7, 1);
            state.setInt(8, 1);

            state.executeUpdate();

            conn.disconnectDB(connection);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void setAccount(User user) {
        try {
            connection = new DBConnection().connectDB();
            int idtemp = extractIDByName(user);

            PreparedStatement state2 = connection.prepareStatement(selectQuery(4));

            state2.setInt(1,idtemp);
            state2.setString(2,user.getEmail());
            state2.setString(3, user.getPassword());

            state2.executeUpdate();

            conn.disconnectDB(connection);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public int extractIDByName(User user){
        boolean exist = false;

        try {
            connection = new DBConnection().connectDB();

            PreparedStatement state = connection.prepareStatement(selectQuery(3));

            state.setString(1, user.getNombre1());

            ResultSet res = state.executeQuery();
            int contador = 0;

            while (res.next()) {
                contador++;
            }

            if (contador == 1 || contador == 0) {
                exist = true;
            }

            conn.disconnectDB(connection);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return (exist ? user.getId() : -1);
    }

    @Override
    public void deleteUser(User user, int indexFromTable) {

    }

    @Override
    public String selectQuery(int i) {
        String query = "";
        switch (i) {
            case 0:
                query = "select id_producto, tipo_producto, nombre, stock, costo, costo_envio, descripcion, vendido_por from vista_catalogo";
                break;
            case 1:
                query = "select t1.id_usuario, t1.nombre1, t1.nombre2, t1.paterno, t1.materno, t1.fecha_nacimiento, t1.num_celular, t2.email, t2.pass_word\n" +
                        "from usuario as t1\n" +
                        "inner join cuentas as t2 on t1.id_usuario = t2.id_usuario_fk";
                break;
            case 2:
                query = "insert into usuario (nombre1, nombre2, paterno, materno, fecha_nacimiento, num_celular, id_direccion, id_tipo) VALUES (?,?,?,?,?,?,?,?)";
                break;
            case 3:
                query = "select id_usuario from usuario where nombre1 = ?";
                break;
            case 4:
                query = "insert into cuentas (id_usuario_fk, email, pass_word) VALUES (?,?,?)";
                break;
        }
        return query;
    }
}
