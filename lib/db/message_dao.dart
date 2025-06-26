import '../core/utils/constants.dart';
import 'db_helper.dart';
import '../models/message_model.dart';

class MessageDao {
  final DBHelper _helper = DBHelper();

  Future<void> insert(MessageModel m) async {
    final db = await _helper.db;
    await db.insert(Constants.MSG_TABLE, {
      'senderId': m.senderId,
      'receiverId': m.receiverId,
      'message': m.message,
      'timestamp': m.timestamp,
    });
  }

  List<MessageModel> getAll() {
    // Simplified for brevity
    return [];
  }
}
