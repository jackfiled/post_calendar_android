import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// Hive相关操作提供类
class HiveProvider {
  static HiveProvider? _instance;

  late Box settingsBox;

  /// 初始化Hive
  static Future<void> initHive() async {
    final document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);

    _instance ??= HiveProvider();
    _instance!.settingsBox = await Hive.openBox("settings");
  }

  /// 获取单例
  static HiveProvider getInstance() {
    _instance ??= HiveProvider();
    return _instance!;
  }
}
