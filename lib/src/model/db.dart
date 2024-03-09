import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_nest/src/model/TargetArtefact.dart';

class DBApdater {
  static final DBApdater _instance = DBApdater._internal();

  factory DBApdater() => _instance;

  DBApdater._internal();

  static late Isar isar;

  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TargetArtefactSchema],
      inspector: true,
      directory: dir.path,
    );

    return isar;
  }



  static Future<List<TargetArtefact>> getAllTargetArtefacts() async {
    
    return isar.targetArtefacts.where().findAll();
  }

  static Future<void> addUser(TargetArtefact user) async {
  //   final isar = await _db;
      await isar.writeTxn(() => isar.targetArtefacts.put(user));
    }



   static Future<void> updateArtefact(TargetArtefact user) async {
     await isar.writeTxn(() => isar.targetArtefacts.put(user));
   }

   static Future<void> deleteArteFact(int userId) async {
     await isar.writeTxn(() => isar.targetArtefacts.delete(userId));
   }

  // Future<void> clearUser() async {
  //   await isar.writeTxn(() => isar.users.clear());
  // }
}
