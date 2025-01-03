import 'package:file_nest/config.dart';
import 'package:file_nest/model/TargetArtefact.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DBApdater {
  static final DBApdater _instance = DBApdater._internal();

  factory DBApdater() => _instance;

  DBApdater._internal();

  static late Isar isar;

  static Future<Isar> init() async {
    final dir = await getSettingFolderPath();
    isar = await Isar.open(
      [TargetArtefactSchema],
      inspector: false,
      directory: dir.path,
      name: "file_nest",
    );

    return isar;
  }

  static Future<List<TargetArtefact>> getAllTargetArtefacts() async {
    return isar.targetArtefacts.where().findAll();
  }

  static Future<void> addArtefact(TargetArtefact ta) async {
    await isar.writeTxn(() => isar.targetArtefacts.put(ta));
  }

  static Future<void> updateArtefact(TargetArtefact ta) async {
    await isar.writeTxn(() => isar.targetArtefacts.put(ta));
  }

  static Future<void> deleteArteFact(int taId) async {
    await isar.writeTxn(() => isar.targetArtefacts.delete(taId));
  }
}
