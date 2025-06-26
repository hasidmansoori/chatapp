import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MapController c = Get.put(MapController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('map'.tr)),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              if (!c.isReady.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (kIsWeb) {
                return Center(
                  child: Text('Google Maps not supported on Web.'),
                );
              } else {
                return RepaintBoundary(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: c.currentLatLng.value, zoom: 14),
                    polygons: c.polygons.toSet(),
                    markers: c.pondMarkers.toSet(),
                    onMapCreated: c.onMapCreated,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(() =>
                          EagerGestureRecognizer()),
                    },
                  ),
                );
              }
            }),

            // Floating buttons aligned bottom right
            Positioned(
              bottom: 20,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'refreshBtn',
                    mini: true,
                    backgroundColor: theme.colorScheme.primary,
                    tooltip: 'Refresh Map',
                    child: Icon(Icons.refresh, color: Colors.white),
                    onPressed: c.refreshMap,
                  ),
                  SizedBox(height: 12),
                  FloatingActionButton(
                    heroTag: 'locateBtn',
                    mini: true,
                    backgroundColor: theme.colorScheme.primary,
                    tooltip: 'Go to Current Location',
                    child: Icon(Icons.my_location, color: Colors.white),
                    onPressed: c.goToCurrentLocation,
                  ),
                ],
              ),
            ),

            // Optional: Bottom info panel with blur background
            Positioned(
              left: 16,
              right: 16,
              bottom: 80,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Obx(() {
                  return Text(
                    'Selected Location: ${c.currentLatLng.value.latitude.toStringAsFixed(5)}, '
                        '${c.currentLatLng.value.longitude.toStringAsFixed(5)}',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
