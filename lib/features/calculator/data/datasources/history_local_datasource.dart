import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/history_model.dart';

class HistoryLocalDataSource {
  late Box<HistoryModel> _historyBox;

  Future<void> init() async {
    _historyBox = await Hive.openBox<HistoryModel>(AppConstants.historyBoxName);
  }

  List<HistoryModel> getHistory() {
    return _historyBox.values.toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> addHistory(HistoryModel item) async {
    await _historyBox.add(item);
  }

  Future<void> clearHistory() async {
    await _historyBox.clear();
  }
}