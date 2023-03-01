import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../models/transactions.dart';

class TransactionDB {
  //DB Services
  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    var appDir = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDir.path, dbName);
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("Movie");

    //json
    var keyID = store.add(db, {
      "id": statement.id,
      "title": statement.title,
      "director": statement.director,
      "duration": statement.duration,
      "rating": statement.rating,
      "category": statement.category,
      "actor": statement.actor,
    });
    db.close();
    return keyID;
  }

  Future<List<Transactions>> loadAllData() async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("Movie");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    List<Transactions> transactionList = [];
    for (var record in snapshot) {
      int id = record.key;
      String title = record['title'].toString();
      String director = record['director'].toString();
      double duration = double.parse(record['duration'].toString());
      double rating = double.parse(record['rating'].toString());
      String category = record['category'].toString();
      String actor = record['actor'].toString();

      // print(record['title']);
      transactionList.add(Transactions(
        id: id,
        title: title,
        director: director,
        duration: duration,
        rating: rating,
        category: category,
        actor: actor,
      ));
    }
    db.close();
    return transactionList;
  }

  //my CRUD update code
  Future updateData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("Movie");
    print("item id ${statement.id}");

    //filter with 'id'
    final finder = Finder(filter: Filter.byKey(statement.id));
    var updateResult =
        await store.update(db, statement.toMap(), finder: finder);
    print("$updateResult row(s) updated.");
    db.close();
  }

  //my CRUD update code
  Future deleteData(Transactions statement) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("Movie");
    print("Statement id is ${statement.id}");

    //filter with 'id'
    final finder = Finder(filter: Filter.equals('id', statement.id));

    var deleteResult = await store.delete(db, finder: finder);
    print("$deleteResult row(s) deleted.");
    db.close();
  }

  Future<Transactions?> loadSingleRow(int rowId) async {
    //create db client obj
    var db = await openDatabase();

    //create store
    var store = intMapStoreFactory.store("Movie");

    //Filter store by field 'id'
    var snapshot =
        await store.find(db, finder: Finder(filter: Filter.byKey(rowId)));

    Transactions? transaction;

    int id = int.parse(snapshot.first['id'].toString());
    String title = snapshot.first['title'].toString();
    String director = snapshot.first['director'].toString();
    double duration = double.parse(snapshot.first['duration'].toString());
    double rating = double.parse(snapshot.first['rating'].toString());
    String category = snapshot.first['category'].toString();
    String actor = snapshot.first['actor'].toString();

    // print(record['title']);
    transaction = Transactions(
      id: id,
      title: title,
      director: director,
      duration: duration,
      rating: rating,
      category: category,
      actor: actor,
    );

    db.close();
    return transaction;
  }
}
