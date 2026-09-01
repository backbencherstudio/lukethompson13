import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_card.dart';

class FormFieldMapView extends StatelessWidget {
  final MapController mapController;
  final String label;
  final Widget? labelActtion;
  final LatLng? location;
  final bool isLoading;
  final double height;
  final Color? backgroundColor;

  const FormFieldMapView({
    super.key,
    required this.label,
    required this.mapController,
    required this.location,
    this.labelActtion,
    this.isLoading = false,
    this.height = 300,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: backgroundColor,
      borderRadius: 12.r,
      padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            child: SizedBox(
              height: height,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: location ?? const LatLng(50.5, 30.51),
                      initialZoom: 15,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: AppConfig.mapProvider,
                        userAgentPackageName: AppConfig.bundleId,
                      ),
                      MarkerLayer(
                        markers: [
                          if (location != null)
                            Marker(
                              point: location!,
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
                  if (isLoading) Center(child: ActivityIndicator()),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 56,
            child: Row(
              spacing: 12,
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: context.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ?labelActtion,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
