import 'package:flutter/foundation.dart';
import 'package:log/log.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class _FirebaseRealtimeChatMirrorStorageRef {
  _FirebaseRealtimeChatMirrorStorageRef({
    @required this.collection,
    @required this.record,
  }) : store = stringMapStoreFactory.store(collection);

  factory _FirebaseRealtimeChatMirrorStorageRef.fromPath(String path) {
    final pathArray = path.split('/').toList(growable: false);
    assert(pathArray.length > 2, 'This path does not have a collection');
    assert(pathArray.length.isEven, 'Path must point to a document');

    return _FirebaseRealtimeChatMirrorStorageRef(
      collection: pathArray.take(pathArray.length - 1).join('/'),
      record: pathArray.last,
    );
  }

  factory _FirebaseRealtimeChatMirrorStorageRef.fromCollection(String path) {
    final pathArray = path.split('/').toList(growable: false);
    assert(pathArray.length > 1, 'This path does not have a collection');
    assert(pathArray.length.isOdd, 'Path is not a collection');

    return _FirebaseRealtimeChatMirrorStorageRef(collection: path, record: null);
  }

  String collection;
  String record;
  StoreRef<String, dynamic> store;
}

/// Offline persistent cache of [FirebaseRealtimeChat] messages.
class FirebaseRealtimeChatMirrorStorage {
  FirebaseRealtimeChatMirrorStorage._();

  static final _log = Log.named('FirebaseRealtimeChatMirrorStorage');
  Database _database;
  bool _initialized = false;

  /// True when the database is initialized;
  bool get initialized => _initialized;

  /// Single instance of this storage.
  static FirebaseRealtimeChatMirrorStorage instance = FirebaseRealtimeChatMirrorStorage._();

  /// Initialize storage database.
  Future init() async {
    if (_initialized) {
      _log.d('`Mirror` database already initialized');
      return;
    }

    _log.v('Initializing `Mirror` database…');
    final documents = await getApplicationDocumentsDirectory();
    final databasePath = join(documents.path, 'mirror.db');
    await documents.create(recursive: true);

    // Initialize once per whole app
    _database = await databaseFactoryIo.openDatabase(databasePath);
    _initialized = true;
    _log.v('`Mirror` database initialized');
  }

  /// Put a file in the storage.
  Future put(String path, Map json) async {
    final ref = _FirebaseRealtimeChatMirrorStorageRef.fromPath(path);
    await ref.store.record(ref.record).put(_database, json, merge: true);
  }

  /// Delete the record at the path.
  Future delete(String path) async {
    final ref = _FirebaseRealtimeChatMirrorStorageRef.fromPath(path);
    await ref.store.record(ref.record).delete(_database);
  }

  /// Get a document from the storage.
  Future<Map<String, dynamic>> get(String path) async {
    final ref = _FirebaseRealtimeChatMirrorStorageRef.fromPath(path);
    final dynamic record = await ref.store.record(ref.record).get(_database);
    return record == null ? null : record as Map<String, dynamic>;
  }

  /// Query a document in the storage.
  Future<List<RecordSnapshot<String, dynamic>>> find(String collection, [Finder finder]) async {
    final ref = _FirebaseRealtimeChatMirrorStorageRef.fromCollection(collection);
    return ref.store.find(_database, finder: finder);
  }
}
