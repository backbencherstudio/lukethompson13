import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/models.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/create_facility_edit_map_screen.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/location_search_sheet.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateBrokerScreen extends ConsumerStatefulWidget {
  const CreateBrokerScreen({super.key});

  @override
  ConsumerState<CreateBrokerScreen> createState() => _CreateBrokerScreenState();
}

class _CreateBrokerScreenState extends ConsumerState<CreateBrokerScreen> {
  late final fieldMapController = MapController();
  String? choosenLocationAddress;
  LatLng? choosenPosition;

  final form = CreateBrokerForm();

  @override
  void dispose() {
    form.dispose();
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
    final createMutationState = ref.watch(createANewBrokerMutation);
    return ReactiveForm(
      formGroup: form,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlobalAppBar(title: 'Create Broker'),
        body: AppGradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.screenPadding,
              ),
              child: Column(
                spacing: 8,
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 8.h),
                  const InputLabel('Name'),
                  ReactiveTextField<String>(
                    autofocus: true,
                    formControl: form.brokerName,
                    textInputAction: TextInputAction.next,
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Broker name is required',
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your broker name',
                    ),
                  ),

                  SizedBox(height: 4.h),
                  const InputLabel('Email'),
                  ReactiveTextField<String>(
                    textInputAction: TextInputAction.next,
                    formControl: form.brokerEmail,
                    validationMessages: {
                      ValidationMessage.email: (_) =>
                          'Please enter a valid email',
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter broker Email',
                    ),
                  ),

                  SizedBox(height: 4.h),

                  const InputLabel('Phone number'),
                  ReactiveTextField<String>(
                    formControl: form.phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Phone number is required',
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                    ),
                  ),

                  SizedBox(height: 4.h),

                  const InputLabel('Broker ID (MC Number)'),
                  ReactiveTextField<String>(
                    formControl: form.brokerId,
                    textInputAction: TextInputAction.next,
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Broker ID is required',
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter MC number',
                    ),
                  ),

                  SizedBox(height: 4.h),

                  const InputLabel('Mailing Address'),

                  const InputLabel('Address', color: Colors.white70),
                  ReactiveTextField<String>(
                    formControl: form.address,
                    textInputAction: TextInputAction.next,
                    validationMessages: {
                      ValidationMessage.required: (_) => 'Address is required',
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter street address',
                    ),
                  ),

                  SizedBox(width: 4.w),

                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InputLabel('City', color: Colors.white70),
                            SizedBox(height: 4.h),
                            ReactiveTextField<String>(
                              formControl: form.city,
                              textInputAction: TextInputAction.next,
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                    'City is required',
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter city',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InputLabel('State', color: Colors.white70),
                            SizedBox(height: 4.h),
                            ReactiveTextField<String>(
                              formControl: form.state,
                              textInputAction: TextInputAction.next,
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                    'State is required',
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter state',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 4.w),

                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InputLabel(
                              'Postal Code',
                              color: Colors.white70,
                            ),
                            SizedBox(height: 4.h),
                            ReactiveTextField<String>(
                              formControl: form.postalCode,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                    'Postal code is required',
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter postal code',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InputLabel('Country', color: Colors.white70),
                            SizedBox(height: 4.h),
                            ReactiveTextField<String>(
                              formControl: form.country,
                              textInputAction: TextInputAction.done,
                              validationMessages: {
                                ValidationMessage.required: (_) =>
                                    'Country is required',
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter country',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  16.height,
                  ReactiveFormConsumer(
                    builder: (_, formGroup, _) {
                      return GlobalButton(
                        isLoading: createMutationState.isPending,
                        isDisabled: !formGroup.valid,
                        label: 'Create Broker',
                        onPressed: () async {
                          form.markAllAsTouched();
                          if (!form.valid) return;

                          final (res, err) = await tryCatch(
                            ref
                                .read(createANewBrokerMutation.notifier)
                                .create(
                                  CreateBrokerRequest(
                                    name: form.brokerName.value ?? '',
                                    email: form.brokerEmail.value ?? '',
                                    phone: form.phone.value ?? '',
                                    brokerId: form.brokerId.value ?? '',
                                    address: form.address.value ?? '',
                                    city: form.city.value ?? '',
                                    state: form.state.value ?? '',
                                    zip: form.postalCode.value ?? '',
                                    country: form.country.value ?? '',
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
                ],
              ),
            ),
            // child: FullHeightScrollView(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: AppPadding.screenPadding,
            //   ),
            //   child: Column(
            //     spacing: 8,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(height: 8.h),
            //       const InputLabel('Broker Name'),
            //       ReactiveTextField<String>(
            //         formControl: brokerName,
            //         decoration: const InputDecoration(
            //           hintText: 'Enter broker name',
            //         ),
            //       ),
            //
            //     ],
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}

class CreateBrokerForm extends FormGroup {
  CreateBrokerForm()
    : super({
        'name': FormControl<String>(validators: [Validators.required]),
        'email': FormControl<String>(
          validators: [Validators.email, Validators.required],
        ),
        'address': FormControl<String>(validators: [Validators.required]),
        'city': FormControl<String>(validators: [Validators.required]),
        'state': FormControl<String>(validators: [Validators.required]),
        'postalCode': FormControl<String>(validators: [Validators.required]),
        'country': FormControl<String>(validators: [Validators.required]),
        'phone': FormControl<String>(validators: [Validators.required]),
        'brokerId': FormControl<String>(validators: [Validators.required]),
      });

  FormControl<String> get brokerName => control('name') as FormControl<String>;

  FormControl<String> get brokerEmail =>
      control('email') as FormControl<String>;

  FormControl<String> get address => control('address') as FormControl<String>;

  FormControl<String> get city => control('city') as FormControl<String>;

  FormControl<String> get state => control('state') as FormControl<String>;

  FormControl<String> get postalCode =>
      control('postalCode') as FormControl<String>;

  FormControl<String> get country => control('country') as FormControl<String>;

  FormControl<String> get phone => control('phone') as FormControl<String>;

  FormControl<String> get brokerId =>
      control('brokerId') as FormControl<String>;
}
