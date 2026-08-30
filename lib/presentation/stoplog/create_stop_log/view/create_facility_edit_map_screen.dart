import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';

class CurrentLocationArgs {
  const CurrentLocationArgs({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double? latitude;
  final double? longitude;
  final String? address;
}

class CreateFacilityEditMapScreen extends StatefulWidget {
  const CreateFacilityEditMapScreen({super.key, required this.args});

  final CurrentLocationArgs args;

  @override
  State<CreateFacilityEditMapScreen> createState() =>
      _CreateFacilityEditMapScreenState();
}

class _CreateFacilityEditMapScreenState
    extends State<CreateFacilityEditMapScreen> {
  final _mapController = MapController();
  late LatLng _selectedLocation = LatLng(
    widget.args.latitude ?? 0.0,
    widget.args.longitude ?? 0.0,
  );

  Future<String?> getCurrentLocationAddress() async {
    final gps = GpsService();
    // final pos = await GpsService.getCurrentPosition();
    // if (pos == null) return null;

    final locAddress = await gps.getAddressFromLatLng(
      latitude: _selectedLocation.latitude,
      longitude: _selectedLocation.longitude,
    );
    return locAddress;
  }

  void onConfirm() async {
    final (foundAddress, err) = await tryCatch(getCurrentLocationAddress());
    if (err != null) {
      Utils.showErrorToast(message: "Failed to save location");
      return;
    }
    if (foundAddress == null) return;

    Navigator.pop(
      context,
      CurrentLocationArgs(
        latitude: _selectedLocation.latitude,
        longitude: _selectedLocation.longitude,
        address: foundAddress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPaddingInset = Utils.bottomPaddingInset(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: GlobalAppBar(
        title: 'Select Location',
        // subTitle: session.value?.address,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 12,
          right: 12,
          bottom: bottomPaddingInset,
        ),
        child: GlobalButton(label: 'Confirm', onPressed: onConfirm),
      ),
      body: AppGradientBackground(
        child: SafeArea(
          bottom: false,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedLocation = point;
                });
              },
              initialCenter: _selectedLocation,
              initialZoom: 15,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: AppConfig.mapProvider,
                userAgentPackageName: AppConfig.bundleId,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation,
                    child: Icon(
                      Icons.location_on,
                      color: ColorManager.errorColor,
                      size: 40.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
