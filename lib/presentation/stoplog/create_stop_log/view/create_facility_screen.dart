import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/tinted_outlined_button.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/models.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/create_facility_edit_map_screen.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/location_search_sheet.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/create_broker_section.dart';

class CreateFacilityScreen extends ConsumerStatefulWidget {
  const CreateFacilityScreen({super.key});

  @override
  ConsumerState<CreateFacilityScreen> createState() =>
      _CreateFacilityScreenState();
}

class _CreateFacilityScreenState extends ConsumerState<CreateFacilityScreen> {
  late final fieldMapController = MapController();
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

  void onUseCurrentLocation() async {
    final pos = await GpsService.getCurrentPosition();

    if (pos == null) return;

    final address = await GpsService().getAddressFromLatLng(
      latitude: pos.latitude,
      longitude: pos.latitude,
    );

    final latlng = LatLng(pos.latitude, pos.longitude);
    fieldMapController.move(latlng, 15);

    setState(() {
      choosenLocationAddress = address;
      choosenPosition = latlng;
    });
  }

  void onSearchLocation(BuildContext context) async {
    final loc = await showLocationSearchSheet(context);

    if (!context.mounted) return;
    editAndUpdateLocation(context, loc);
  }

  void editAndUpdateLocation(
    BuildContext context,
    LocationDataModel? loc,
  ) async {
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

      if (latitude != null && longitude != null && address != null) {
        fieldMapController.move(LatLng(latitude, longitude), 15);

        setState(() {
          choosenLocationAddress = address;
          choosenPosition = LatLng(latitude, longitude);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressIsEmpty =
        choosenPosition == null || choosenLocationAddress == null;
    final createMutationState = ref.watch(createANewShipperFacilityMutation);
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
                Text("Facility address", style: context.labelLarge),

                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: TintedOutlinedButton(
                          color: ColorManager.primaryButton,
                          label: 'Current location',
                          onPressed: onUseCurrentLocation,
                        ),
                      ),
                      Expanded(
                        child: TintedOutlinedButton(
                          color: ColorManager.warningColor,
                          label: 'Search location',
                          onPressed: () => onSearchLocation(context),
                        ),
                      ),
                    ],
                  ),
                ),

                FormFieldMapView(
                  location: choosenPosition,
                  label: choosenLocationAddress ?? "Select Location",
                  mapController: fieldMapController,
                  labelActtion: addressIsEmpty
                      ? SizedBox(height: 40)
                      : TintedOutlinedButton(
                          label: 'Edit',
                          onPressed: () {
                            if (addressIsEmpty) {
                              return;
                            }

                            final loc = LocationDataModel(
                              latitude: choosenPosition!.latitude,
                              longitude: choosenPosition!.longitude,
                              address: choosenLocationAddress!,
                            );
                            editAndUpdateLocation(context, loc);
                          },
                        ),
                ),

                SizedBox(height: 8.h),
                CreateBrokerSection(),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 12, left: 12, right: 12),
          child: GlobalButton(
            isLoading: createMutationState.isPending,
            isDisabled: addressIsEmpty || _facilityNameController.text.isEmpty,
            label: 'Create',
            onPressed: () async {
              final (res, err) = await tryCatch(
                ref
                    .read(createANewShipperFacilityMutation.notifier)
                    .create(
                      CreateShippperRequest(
                        name: _facilityNameController.text,
                        address: choosenLocationAddress ?? '',
                        lat: choosenPosition?.latitude,
                        lng: choosenPosition?.longitude,
                      ),
                    ),
              );
              if (err != null) {
                Utils.showErrorToast(
                  message: ErrorHandle.formatErrorMessage(err),
                );
                return;
              }

              if (context.mounted) {
                context.pop(res?.data);
              }
            },
          ),
        ),
      ),
    );
  }
}

class FormFieldMapView extends StatelessWidget {
  final MapController mapController;
  final String label;
  final Widget? labelActtion;
  final LatLng? location;

  const FormFieldMapView({
    super.key,
    required this.label,
    required this.mapController,
    required this.location,
    this.labelActtion,
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
                ?labelActtion,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
