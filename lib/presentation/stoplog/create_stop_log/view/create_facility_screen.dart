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
import 'package:lukethompson/core/widgets/activity_indicator.dart';
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
import 'package:reactive_forms/reactive_forms.dart';

class CreateFacilityScreen extends ConsumerStatefulWidget {
  const CreateFacilityScreen({super.key});

  @override
  ConsumerState<CreateFacilityScreen> createState() =>
      _CreateFacilityScreenState();
}

class _CreateFacilityScreenState extends ConsumerState<CreateFacilityScreen> {
  late final fieldMapController = MapController();
  String? choosenLocationAddress;

  LatLng? choosenPosition;
  bool locatinIsLoading = true;

  final form = CreateFacilityForm();

  FormControl<String> get facilityName => form.facilityName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      onUseCurrentLocation();
    });
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  void onUseCurrentLocation() async {
    setState(() {
      locatinIsLoading = true;
    });
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
      locatinIsLoading = false;
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
    return ReactiveForm(
      formGroup: form,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlobalAppBar(title: 'Create facility'),
        body: AppGradientBackground(
          child: SafeArea(
            child: FullHeightScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.screenPadding,
              ),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  const InputLabel('Facility Name'),
                  ReactiveTextField<String>(
                    formControl: facilityName,
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Facility name is required',
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter facility name',
                    ),
                  ),

                  SizedBox(height: 8.h),
                  const InputLabel('Facility Address'),

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
                    isLoading: locatinIsLoading,
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
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            child: ReactiveFormConsumer(
              builder: (_, form, _) {
                return GlobalButton(
                  isLoading: createMutationState.isPending,
                  isDisabled: addressIsEmpty || !form.valid,
                  label: 'Create',
                  onPressed: () async {
                    form.markAllAsTouched();
                    if (!form.valid) return;

                    final (res, err) = await tryCatch(
                      ref
                          .read(createANewShipperFacilityMutation.notifier)
                          .create(
                            CreateShippperRequest(
                              name: facilityName.value ?? '',
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
                );
              },
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
  final Widget? labelActtion;
  final LatLng? location;
  final bool isLoading;

  const FormFieldMapView({
    super.key,
    required this.label,
    required this.mapController,
    required this.location,
    this.labelActtion,
    this.isLoading = false,
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

class CreateFacilityForm extends FormGroup {
  CreateFacilityForm()
    : super({
        'facilityName': FormControl<String>(validators: [Validators.required]),
      });

  FormControl<String> get facilityName =>
      control('facilityName') as FormControl<String>;
}
