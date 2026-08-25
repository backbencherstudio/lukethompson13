import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';

class CreateFacilityMapview extends StatefulWidget {
  const CreateFacilityMapview({super.key});

  @override
  State<CreateFacilityMapview> createState() => _CreateFacilityMapviewState();
}

class _CreateFacilityMapviewState extends State<CreateFacilityMapview> {
  final MapController _mapController = MapController();

  double get currentZoom => _mapController.camera.zoom;
  var initialCenter = LatLng(0.0, -0.0);
  var location = LatLng(0.0, -0.0);

  void updateLocation(double? lat, lon, {bool centerLocation = false}) {
    if (lat == null || lon == null) {
      return;
    }
    location = LatLng(lat, lon);
    if (centerLocation) {
      _mapController.move(location, currentZoom);
    }
  }

  @override
  void initState() {
    super.initState();
    GpsService.getCurrentPosition().then((pos) {
      setState(() {
        updateLocation(pos?.latitude, pos?.longitude, centerLocation: true);
      });
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onTap: (tapPos, latLng) {
          setState(() {
            updateLocation(latLng.latitude, latLng.longitude);
          });
        },
        initialCenter: initialCenter,
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: AppConfig.bundleId,
          userAgentPackageName: AppConfig.bundleId,
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: location,
              child: Icon(
                Icons.location_on,
                color: ColorManager.errorColor,
                size: 40.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
