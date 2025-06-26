import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../core/services/firebase_service.dart';
import '../core/services/notification_service.dart';
import '../models/message_model.dart';
import '../db/message_dao.dart';
import '../routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  final messageController = TextEditingController();
  final messages = <MessageModel>[].obs;

  final receiverToken = ''.obs;
  final box = GetStorage();

  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? 'unknown';

  @override
  void onInit() {
    super.onInit();
    loadMessages();
    FirebaseService().init(); // Optional: Firebase setup if not done globally
  }

  Future<void> loadMessages() async {
    messages.value = await MessageDao().getAll();
  }

  void sendMessage() async {
    if (receiverToken.value.isEmpty) {
      Get.snackbar('Error', 'Receiver not set. Please scan QR.');
      return;
    }

    final msgText = messageController.text.trim();
    if (msgText.isEmpty) return;

    final msg = MessageModel(
      senderId: currentUserId,
      receiverId: receiverToken.value,
      message: msgText,
      timestamp: DateTime.now().toIso8601String(),
    );

    await MessageDao().insert(msg);
    messages.add(msg);
    messageController.clear();

    // Send push notification to other user
    await NotificationService().sendMessage(
      targetToken: receiverToken.value,
      title: 'New message from ${currentUserId}',
      body: msgText,
    );
  }

  void setReceiverToken(String token) {
    receiverToken.value = token;
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    box.erase(); // Clear storage
    Get.offAllNamed(Routes.LOGIN);
  }
}
