class MessageModel {
  final int? id;
  final String senderId, receiverId, message, timestamp;
  MessageModel({this.id, required this.senderId, required this.receiverId, required this.message, required this.timestamp});
}
