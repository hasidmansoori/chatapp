import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRService {
  /// QR Code Generator
  static Widget generate(String data, {double size = 200}) {
    final qrCode = QrCode.fromData(
      data: data,
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );
    return CustomPaint(
      size: Size.square(size),
      painter: QrPainter.withQr(
        qr: qrCode,
        color: Colors.black,
        emptyColor: Colors.white,
        gapless: true,
      ),
    );
  }

  /// QR Code Scanner
  static Widget scanner(void Function(String result) onResult) => Scaffold(
    body: QRView(
      key: GlobalKey(debugLabel: 'QR'),
      onQRViewCreated: (ctrl) {
        ctrl.scannedDataStream.listen((scanData) {
          if (scanData.code != null) {
            onResult(scanData.code!);
          }
          ctrl.dispose();
          Navigator.of(Get.context!).pop();
        });
      },
    ),
  );
}
