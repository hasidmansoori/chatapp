import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
