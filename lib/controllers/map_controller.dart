import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController {
  var isReady = false.obs;
  var currentLatLng = LatLng(0, 0).obs;
  var polygons = <Polygon>[].obs;
  var pondMarkers = <Marker>[].obs;
  GoogleMapController? mapCtrl;

  @override
  void onInit() {
    super.onInit();
    _initLocation();
  }

  Future<void> _initLocation() async {
    await Geolocator.requestPermission();
    final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentLatLng.value = LatLng(pos.latitude, pos.longitude);
    _updateMap();
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        distanceFilter: 10,
      ),
    ).listen((u) {
      currentLatLng.value = LatLng(u.latitude, u.longitude);
      _updateMap();
    });
    isReady.value = true;
  }

  void onMapCreated(GoogleMapController c) => mapCtrl = c;

  Future<void> _updateMap() async {
    _drawRect();
    await _loadPonds();
    mapCtrl?.animateCamera(CameraUpdate.newLatLng(currentLatLng.value));
  }

  void _drawRect() {
    final center = currentLatLng.value;
    final d = 0.018; // ~2 km in degrees
    polygons.value = [Polygon(polygonId: PolygonId('b'), points: [
      LatLng(center.latitude - d, center.longitude - d),
      LatLng(center.latitude - d, center.longitude + d),
      LatLng(center.latitude + d, center.longitude + d),
      LatLng(center.latitude + d, center.longitude - d),
    ], strokeColor: Colors.blue, fillColor: Colors.blue.withOpacity(0.1))];
  }

  Future<void> _loadPonds() async {
    final c = currentLatLng.value;
    final bbox = '${c.latitude-0.018},${c.longitude-0.018},${c.latitude+0.018},${c.longitude+0.018}';
    final q = '[out:json];(way["natural"="water"]($bbox););out center;';
    final res = await http.post(Uri.parse('https://overpass-api.de/api/interpreter'), body: {'data': q});
    if (res.statusCode == 200) {
      final jsonData = json.decode(res.body);
      pondMarkers.value = (jsonData['elements'] as List).map((e) {
        final lat = e['center']['lat'], lon = e['center']['lon'];
        return Marker(markerId: MarkerId('p${e['id']}'), position: LatLng(lat, lon));
      }).toList();
    }
  }

  @override
  void onClose() {
    mapCtrl?.dispose();
    super.onClose();
  }

  Future<void> refreshMap() async {
    isReady.value = false;
    await _initLocation();
    isReady.value = true;
  }

  Future<void> goToCurrentLocation() async {
    if (mapCtrl == null) return;
    try {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLatLng.value = LatLng(pos.latitude, pos.longitude);
      mapCtrl!.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng.value, 14));
      await _updateMap();
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
}

