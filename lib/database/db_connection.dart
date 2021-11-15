import 'package:mongo_dart/mongo_dart.dart' show Db;
import 'Config.dart' as config show server_url, server_port, db_name;

class DBConnection {
  static late DBConnection _instance;
  final String _host = config.server_url;
  final String _port = config.server_port;
  final String _dbName = config.db_name;
  late Db _db;

  static getInstance() {
    // ignore: unnecessary_null_comparison
    if (_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async {
    // ignore: unnecessary_null_comparison
    if (_db == null) {
      try {
        _db = Db(_getConnectionString());
        await _db.open();
      } catch (e) {
        print(e);
      }
    }
    return _db;
  }

  _getConnectionString() {
    return "mongodb://$_host:$_port/$_dbName";
  }

  closeConnrction() {
    _db.close();
  }
}
