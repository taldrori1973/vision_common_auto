package com.radware.vision.automation.DatabaseStepHandlers.mariaDB;

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class JDBCConnectionSingleton {
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static String DB_URL_PATTERN = "jdbc:mysql://%s:%s/%s";

    private SUTManager sutManager;
    private String host;
    private String port;
    private String userName;
    private String password;
    private Map<VisionDBSchema, Connection> openConnections;

    private static JDBCConnectionSingleton _instance = new JDBCConnectionSingleton();

    private JDBCConnectionSingleton() {
        super();
        this.sutManager = SUTManagerImpl.getInstance();
        this.host = sutManager.getClientConfigurations().getHostIp();
        this.port = sutManager.getClientConfigurations().getSqlDbConnectionDefaultPort();
        this.userName = sutManager.getClientConfigurations().getSqlDbConnectionUsername();
        this.password = sutManager.getClientConfigurations().getSqlDbConnectionPassword();
        this.openConnections = new HashMap<>();
    }

    public static JDBCConnectionSingleton getInstance() {
        return _instance;
    }

    public Connection getDBConnection(VisionDBSchema schema) throws JDBCConnectionException {
        if (openConnections.containsKey(schema)) {
            Connection currentConnection = openConnections.get(schema);
            if (isConnectionStillUp(currentConnection)) return currentConnection;
            openConnections.remove(schema);
        }

        try {
            Connection newConnection = createSchemaConnection(schema);
            this.openConnections.put(schema, newConnection);
            return openConnections.get(schema);

        } catch (InstantiationException | SQLException | IllegalAccessException | ClassNotFoundException e) {
            throw new JDBCConnectionException(e.getMessage());
        }
    }

    private boolean isConnectionStillUp(Connection connection) {
        Statement statement = null;
        try {
            statement = connection.createStatement();
            ResultSet result = statement.executeQuery("SELECT 1");
            if (result.next() && result.getInt(1) == 1) return true;
        } catch (SQLException e) {
            return false;
        }
        return false;
    }

    public void closeAllConnections() {
        try {
            for (VisionDBSchema conn : this.openConnections.keySet()) {
                openConnections.get(conn).close();
            }
            this.openConnections.clear();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    private Connection createSchemaConnection(VisionDBSchema schema) throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
        Connection connection = null;
        Class.forName(JDBC_DRIVER).newInstance();
        String url = String.format(DB_URL_PATTERN, this.host, this.port, schema.toString().toLowerCase());
        connection = DriverManager.getConnection(url, this.userName, this.password);
        return connection;
    }

}