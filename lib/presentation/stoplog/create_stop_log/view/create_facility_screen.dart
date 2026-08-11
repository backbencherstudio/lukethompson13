import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/link_button.dart';
import 'package:lukethompson/core/widgets/tinted_outlined_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/create_facility_edit_map_screen.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/location_search_sheet.dart';

class CreateFacilityScreen extends StatefulWidget {
  const CreateFacilityScreen({super.key});

  @override
  State<CreateFacilityScreen> createState() => _CreateFacilityScreenState();
}

class _CreateFacilityScreenState extends State<CreateFacilityScreen> {
  final MapController fieldMapController = MapController();
  late final _facilityNameController = TextEditingController();
  String? choosenLocationAddress;
  LatLng? choosenPosition;

  @override
  void initState() {
    super.initState();
    _facilityNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _facilityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: 'Create facility',
        // subTitle: session.value?.address,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: FullHeightScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text("Facility Name", style: context.labelLarge),
                CustomTextFieldWidget(
                  hintText: "Enter facility name",
                  controller: _facilityNameController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  textInputAction: .next,
                ),

                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text("Facility address", style: context.labelLarge),
                    LinkButton(
                      child: Text("Use current location"),
                      onPressed: () {},
                    ),
                  ],
                ),
                FormFieldMapView(
                  location: choosenPosition,
                  label: choosenLocationAddress ?? "Select Location",
                  mapController: fieldMapController,
                  onEditPressed: () async {
                    final loc = await showLocationSearchSheet(context);

                    if (loc != null && context.mounted) {
                      final savedRes = await context.push<CurrentLocationArgs?>(
                        Routes.createFacilityEditMap,
                        extra: CurrentLocationArgs(
                          latitude: loc.latitude,
                          longitude: loc.longitude,
                          address: loc.address,
                        ),
                      );

                      if (savedRes == null) return;

                      final latitude = savedRes.latitude;
                      final longitude = savedRes.longitude;
                      final address = savedRes.address;

                      if (latitude != null &&
                          longitude != null &&
                          address != null) {
                        fieldMapController.move(
                          LatLng(latitude, longitude),
                          15,
                        );

                        setState(() {
                          choosenLocationAddress = address;
                          choosenPosition = LatLng(latitude, longitude);
                        });
                      }
                    }
                  },
                ),
                Spacer(),
                GlobalButton(
                  isDisabled:
                      choosenLocationAddress == null ||
                      choosenPosition == null ||
                      _facilityNameController.text.isEmpty,
                  label: 'Create',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormFieldMapView extends StatelessWidget {
  final MapController mapController;
  final String label;
  final void Function()? onEditPressed;
  final LatLng? location;

  const FormFieldMapView({
    super.key,
    required this.label,
    required this.mapController,
    this.onEditPressed,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
              height: 300,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: location ?? const LatLng(50.5, 30.51),
                  initialZoom: 15,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
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
                TintedOutlinedButton(label: 'Edit', onPressed: onEditPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
