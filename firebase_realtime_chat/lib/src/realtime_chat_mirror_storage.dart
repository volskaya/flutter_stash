import 'package:firebase_database/firebase_database.dart';
import 'package:log/log.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class _RealtimeChatMirrorStorageRef {
  _RealtimeChatMirrorStorageRef({
    required this.collection,
    required this.record,
  }) : store = stringMapStoreFactory.store(collection);

  factory _RealtimeChatMirrorStorageRef.fromPath(String path) {
    final pathArray = path.split('/').toList(growable: false);
    assert(pathArray.length > 2, 'This path does not have a collection');
    assert(pathArray.length.isEven, 'Path must point to a document');

    return _RealtimeChatMirrorStorageRef(
      collection: pathArray.take(pathArray.length - 1).join('/'),
      record: pathArray.last,
    );
  }

  factory _RealtimeChatMirrorStorageRef.fromCollection(String path) {
    final pathArray = path.split('/').toList(growable: false);
    assert(pathArray.length > 1, 'This path does not have a collection');
    assert(pathArray.length.isOdd, 'Path is not a collection');

    return _RealtimeChatMirrorStorageRef(collection: path, record: null);
  }

  String collection;
  String? record;
  StoreRef<String, dynamic> store;
}

/// Offline persistent cache of [FirebaseRealtimeChat] messages.
class RealtimeChatMirrorStorage {
  RealtimeChatMirrorStorage._(this.key);

  static final _log = Log.named('RealtimeChatMirrorStorage');

  /// The key with what this [RealtimeChatMirrorStorage] was stored in the [instances].
  final String key;

  late final Database _database;
  bool _initialized = false;

  /// True when the database is initialized;
  bool get initialized => _initialized;

  /// Instances keyed by chat reference's path and the client count.
  static final instances = <String, MapEntry<int, RealtimeChatMirrorStorage>>{};

  /// Initialize storage database.
  Future init([String? key]) async {
    if (_initialized) {
      _log.d('`Mirror` database already initialized');
      return;
    }

    _log.v('Initializing `Mirror` database at $key…');
    final documents = await getApplicationDocumentsDirectory();
    final databasePath = join(documents.path, key != null ? '$key.db' : 'mirror.db');
    await documents.create(recursive: true);

    // Initialize once per whole app.
    _database = await getDatabaseFactorySqflite(sqflite.databaseFactory).openDatabase(databasePath);
    _initialized = true;
    _log.v('`Mirror` database initialized at $key');
  }

  /// Initialize a mirror storage for the key, usually chat reference's path.
  static Future<RealtimeChatMirrorStorage> initialize(DatabaseReference reference) async {
    final storage = RealtimeChatMirrorStorage._(reference.path);
    instances[reference.path] ??= MapEntry((instances[reference.path]?.key ?? 0) + 1, storage);

    // When a new instance is created, open the database.
    if (instances[reference.path]!.key == 1) {
      _log.i('Opening a new mirror storage under ${reference.path}');
      await storage.init(reference.path.replaceAll('/', '.'));

      // If the key was unreference while the database was initializing, dispose it.
      if ((instances[reference.path]?.key ?? 0) <= 0) {
        _log.w('Mirror ${reference.path} was unreferenced right after opening, disposing it');
        await storage.dispose();
      }
    }

    return instances[reference.path]!.value;
  }

  /// Unreferences and closes the database.
  Future dispose() async {
    if (!instances.containsKey(key)) {
      _log.w('Mirror storage of $key was disposed, but the instance cached didn\'t contain its key.');
      return; // Already disposed? This might indicate some race condition.
    }

    instances[key] = MapEntry(instances[key]!.key - 1, instances[key]!.value);
    if (instances[key]!.key <= 0) {
      instances.remove(key);
      if (_initialized) {
        _log.i('Closing mirror storage under $key');
        _database.close();
      }
    }
  }

  /// Put a file in the storage.
  Future put(String path, Map json) async {
    final ref = _RealtimeChatMirrorStorageRef.fromPath(path);
    if (ref.record != null) await ref.store.record(ref.record!).put(_database, json, merge: true);
  }

  /// Delete the record at the path.
  Future delete(String path) async {
    final ref = _RealtimeChatMirrorStorageRef.fromPath(path);
    if (ref.record != null) await ref.store.record(ref.record!).delete(_database);
  }

  /// Get a document from the storage.
  Future<Map<String, dynamic>?> get(String path) async {
    final ref = _RealtimeChatMirrorStorageRef.fromPath(path);
    final dynamic record = ref.record != null ? await ref.store.record(ref.record!).get(_database) : null;
    return record == null ? null : record as Map<String, dynamic>;
  }

  /// Query a document in the storage.
  Future<List<RecordSnapshot<String, dynamic>>> find(String collection, [Finder? finder]) async {
    final ref = _RealtimeChatMirrorStorageRef.fromCollection(collection);
    return ref.store.find(_database, finder: finder);
  }
}
