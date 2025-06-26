import 'package:chatapp/views/home/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../controllers/home_controller.dart';
import '../../core/services/qr_service.dart';
import '../../routes/app_pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: Icon(Icons.logout),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              color: theme.colorScheme.primary.withOpacity(0.05),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 3,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                    ),
                    icon: Icon(Icons.qr_code, size: 24),
                    label: Text('Share Token', style: TextStyle(fontSize: 16)),
                    onPressed: () async {
                      final token = await FirebaseMessaging.instance.getToken();
                      Get.dialog(AlertDialog(
                        title: Text('My Device Token QR'),
                        content: QRService.generate(token ?? 'no-token'),
                      ));
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 3,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                    ),
                    icon: Icon(Icons.qr_code_scanner, size: 24),
                    label: Text('Scan Token', style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      Get.to(() => QRService.scanner((scannedToken) {
                        controller.setReceiverToken(scannedToken);
                        Get.back();
                        Get.snackbar('Scanned', 'Token set for chat!');
                      }));
                    },
                  ),
                  Tooltip(
                    message: 'Open Map',
                    child: IconButton(
                      iconSize: 28,
                      icon: Icon(Icons.map, color: theme.colorScheme.primary),
                      onPressed: () => Get.toNamed(Routes.MAP),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: ChatWidget()),
          ],
        ),
      ),
    );
  }
}
