package uia.dapp.login.db;

import java.sql.Connection;

public interface IDBConnection {
    public Connection connectDB() throws ClassNotFoundException;
    public void disconnectDB(Connection connection);
}
