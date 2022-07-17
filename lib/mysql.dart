import 'package:mysql1/mysql1.dart';

class Mysql {
  Future<MySqlConnection> openConnection() {
    final settings = ConnectionSettings(
        host: 'kit301-mysql-server.mysql.database.azure.com',
        port: 3306,
        user: 'adminKevin@kit301-mysql-server',
        password: 'Admin301',
        db: 'MySql'
    );
    return MySqlConnection.connect(settings);
  }
}
