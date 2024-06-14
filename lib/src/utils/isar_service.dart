// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:vec_gilang/src/models/product_model.dart';

typedef Identifier<T> = int Function(T);

class IsarService {
  late Isar isar;

  static List<CollectionSchema> get isarSchemas {
    return [ProductModelSchema];
  }

  // List db that sould be clear when user logout
  Future<void> logout() async {
    [
      clearAll<ProductModel>(),
    ].wait;
  }

  Future<void> init(List<CollectionSchema> schemas) async {
    final dir = await getApplicationDocumentsDirectory();
    final isarDir = Directory(p.join(dir.path, 'isar'));

    if (!await isarDir.exists()) {
      await isarDir.create(recursive: true);
    }

    isar = await Isar.open(
      schemas,
      directory: isarDir.path,
    );
  }

  IsarCollection<T> getCollection<T>() {
    return isar.collection<T>();
  }

  Future<void> save<T>(T object) async {
    await isar.writeTxn(() async {
      await getCollection<T>().put(object);
    });
  }

  Future<T?> get<T>(int id) async {
    return await getCollection<T>().get(id);
  }

  Future<List<T>> getAll<T>() async {
    return await getCollection<T>().where().findAll();
  }

  Future<void> update<T>(T object) async {
    await isar.writeTxn(() async {
      await getCollection<T>().put(object);
    });
  }

  Future<void> remove<T>(int id) async {
    await isar.writeTxn(() async {
      await getCollection<T>().delete(id);
    });
  }

  Future<void> clearAll<T>() async {
    await isar.writeTxn(() async {
      await getCollection<T>().clear();
    });
  }

  Future<void> saveOrRemove<T>(T object, Identifier<T> identifier) async {
    final removedId = identifier(object);
    final isInIsarDatabase = await get<T>(removedId) != null;
    if (isInIsarDatabase) {
      return await remove<T>(removedId);
    }

    await save<T>(object);
  }
}
