import 'package:lost_and_found/global_constant.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db;
import 'package:lost_and_found/Config.dart' as config
    show server_url, server_port, db_name;

class DBConnection {
  static late DBConnection _instance;
  final String _host = config.server_url;
  final String _port = config.server_port;
  final String _dbName = config.db_name;
  late Db _db;

  static getInstance() {
    _instance = DBConnection();
    return _instance;
  }

  Future<Db> getConnection() async {
    try {
      _db = await Db.create(_getConnectionString());
      await _db.open();
    } catch (e) {
      logger.e(e);
    }
    return _db;
  }

  _getConnectionString() {
    return "mongodb+srv://$_host:$_port/$_dbName";
  }

  closeConnection() {
    _db.close();
  }
}
