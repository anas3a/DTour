import 'sqlite_connector.dart';
import 'purchase_history.dart';
import 'user.dart';

class DataProvider {
  Future<int> addUser(User? user) async {
    await SqliteConnector.init();
    int temp = await SqliteConnector.insert(User.tableName, user);
    return temp;
  }

  Future<int> addPurchaseHistory(PurchaseHistory purchaseHistory) async {
    await SqliteConnector.init();
    int temp = await SqliteConnector.insert(
        PurchaseHistory.tableName, purchaseHistory);
    return temp;
  }

  Future<List<User>> getUserByEmail(String? email) async {
    await SqliteConnector.init();
    List<Map<String, dynamic>> users =
        await SqliteConnector.getUserByEmail(User.tableName, email);
    return users.map((e) => User.fromMap(e)).toList();
  }

  Future<List<User>> getUserByEmailAndPassword(
      String? email, String? password) async {
    await SqliteConnector.init();
    List<Map<String, dynamic>> users =
        await SqliteConnector.getUserByEmailAndPassword(
            User.tableName, email, password);
    return users.map((e) => User.fromMap(e)).toList();
  }

  Future<List<PurchaseHistory>> getPurchaseHistory(String? email) async {
    await SqliteConnector.init();
    List<Map<String, dynamic>> tasks =
        await SqliteConnector.historyByEmail(PurchaseHistory.tableName, email);
    return tasks.map((e) => PurchaseHistory.fromMap(e)).toList();
  }
}
