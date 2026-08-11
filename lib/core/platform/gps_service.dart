import 'package:geocoding/geocoding.dart' show Placemark, Geocoding;
import 'package:geolocator/geolocator.dart';

String joinNonEmptyStrings(List<String?> values, {String separator = ", "}) {
  return values
      .where((value) => value?.trim().isNotEmpty ?? false)
      .join(separator);
}

class LocationDataModel {
  final double latitude;
  final double longitude;
  final String address;

  LocationDataModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class GpsService {
  late final _geocoading = Geocoding();

  static Future<Position?> getCurrentPosition() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return position;
    } catch (e) {
      return null;
    }
  }

  // ================= GET CURRENT POSITION =================

  // Future<Position> getCurrentPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Check service
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //
  //   if (!serviceEnabled) {
  //     throw Exception('Location services are disabled.');
  //   }
  //
  //   // Check permission
  //
  //   permission = await Geolocator.checkPermission();
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //
  //     if (permission == LocationPermission.denied) {
  //       throw Exception('Location permission denied');
  //     }
  //   }
  //
  //   // Permanently denied
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     throw Exception('Location permission permanently denied');
  //   }
  //
  //   // Get location
  //
  //   return await Geolocator.getCurrentPosition();
  // }

  // ================= GET ADDRESS =================

  Future<String> getAddressFromLatLng({
    required double latitude,
    required double longitude,
  }) async {
    List<Placemark> placemarks = await _geocoading.placemarkFromCoordinates(
      latitude,
      longitude,
    );

    Placemark place = placemarks.first;

    return joinNonEmptyStrings([place.street, place.locality, place.country]);
  }

  Future<List<LocationDataModel>> performSearch(String query) async {
    final locations = await _geocoading.locationFromAddress(query);
    final results = <LocationDataModel>[];
    for (final loc in locations) {
      try {
        final placemarks = await _geocoading.placemarkFromCoordinates(
          loc.latitude,
          loc.longitude,
        );
        final place = placemarks.first;
        final address = joinNonEmptyStrings([
          place.street,
          place.locality,
          place.country,
        ]);
        results.add(
          LocationDataModel(
            address: address.trim().isEmpty ? query : address,
            latitude: loc.latitude,
            longitude: loc.longitude,
          ),
        );
      } catch (_) {
        results.add(
          LocationDataModel(
            address:
                '$query (${loc.latitude.toStringAsFixed(4)}, ${loc.longitude.toStringAsFixed(4)})',
            latitude: loc.latitude,
            longitude: loc.longitude,
          ),
        );
      }
    }

    return results;
  }

  // ================= FULL LOCATION DATA =================

  // Future<LocationDataModel> getLocationData() async {
  //   final position = await getCurrentPosition();
  //
  //   final address = await getAddressFromLatLng(
  //     latitude: position.latitude,
  //     longitude: position.longitude,
  //   );
  //
  //   return LocationDataModel(
  //     latitude: position.latitude,
  //     longitude: position.longitude,
  //     address: address,
  //   );
  // }

  // ================= OPEN SETTINGS =================

  Future<void> openSettings() async {
    await Geolocator.openAppSettings();
  }
}
