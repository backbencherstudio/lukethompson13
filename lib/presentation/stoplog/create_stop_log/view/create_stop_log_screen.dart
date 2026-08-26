import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';
import 'package:lukethompson/data/sources/remote/stoplog/stoplog_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/state/facility_search_state.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/facility_and_broker_search_sheet.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/searchable_field_section.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/timeline_section.dart';

class CreateStopLogScreen extends ConsumerStatefulWidget {
  const CreateStopLogScreen({super.key});

  @override
  ConsumerState<CreateStopLogScreen> createState() =>
      _CreateStopLogScreenState();
}

class _CreateStopLogScreenState extends ConsumerState<CreateStopLogScreen> {
  late final TextEditingController _facilityTextController;
  late final _facilityFocusNode = FocusNode();

  late final TextEditingController _brokerTextController;
  late final _brokerFocusNode = FocusNode();

  final _timelineKey = GlobalKey<TimelineSectionState>();
  String? _sessionId;
  bool _isActiveSessionLoading = true;
  bool _canCalculateAndPreview = false;
  bool _loadingActionBtn = false;

  var _logStarted = false;
  void endCurrentSession() async {
    setState(() {
      _logStarted = false;
      _sessionId = null;
    });

    await Future.delayed(Duration(milliseconds: 200));
    ref.read(selectedFacilityProvider.notifier).clear();
  }

  void activateCalculateBtn(bool enabled) {
    setState(() {
      _canCalculateAndPreview = enabled;
    });
  }

  void _onCreateFactility() async {
    if (!context.mounted) return;
    final newFacility = await context.push<ShipperLocationItem?>(
      Routes.createFacility,
    );
    print("====================================================");
    print(newFacility);
    print("====================================================");
  }

  @override
  void initState() {
    super.initState();
    final activeSession = ref.read(getCurrentActiveStoplog);
    _sessionId = activeSession.value?.id;
    _isActiveSessionLoading = activeSession.isLoading;

    _facilityTextController = TextEditingController(
      text: ref.read(selectedFacilityProvider)?.choosenShipper?.name ?? '',
    );

    _brokerTextController = TextEditingController(
      text: ref.read(selectedFacilityProvider)?.choosenBroker?.name ?? '',
    );

    ref.listenManual<CurrentStopLogState?>(selectedFacilityProvider, (
      previous,
      next,
    ) {
      final shipperName = next?.choosenShipper?.name ?? '';
      if (_facilityTextController.text != shipperName) {
        _facilityTextController.value = TextEditingValue(
          text: shipperName,
          selection: TextSelection.collapsed(offset: shipperName.length),
        );
      }

      final brokerName = next?.choosenBroker?.name ?? '';
      if (_brokerTextController.text != brokerName) {
        _brokerTextController.value = TextEditingValue(
          text: brokerName,
          selection: TextSelection.collapsed(offset: brokerName.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _facilityTextController.dispose();
    _facilityFocusNode.dispose();
    super.dispose();
  }

  Future<void> _onFacilityTap() async {
    final choosenFacility = await showFacilityOrBrokerSearchSheet(context);
    _facilityFocusNode.unfocus();
    if (choosenFacility == null) return;

    ref.read(selectedFacilityProvider.notifier).selectFacility(choosenFacility);

    final choosenBroker = ref.read(selectedFacilityProvider)?.choosenBroker;
    if (choosenBroker == null) return;

    setState(() {
      _logStarted = true;
    });
  }

  Future<void> _onFacilityAction() async {
    if (!context.mounted) return;
    final newFacility = await context.push<ShipperLocationItem?>(
      Routes.createFacility,
    );

    if (newFacility != null) {
      final fac = ShipperSearchFacilityItem(
        id: newFacility.id,
        name: newFacility.name!,
        address: newFacility.location?.address,
        rating: 0,
        lat: newFacility.location?.lat,
        lng: newFacility.location?.lng,
      );

      ref.read(selectedFacilityProvider.notifier).selectFacility(fac);
    }
  }

  Future<void> _onBrokerTap() async {
    final choosenBroker = await showFacilityOrBrokerSearchSheet(
      context,
      facilityType: .broker,
    );

    _brokerFocusNode.unfocus();
    if (choosenBroker == null) return;

    ref
        .read(selectedFacilityProvider.notifier)
        .selectBroker(
          id: choosenBroker.id!,
          name: choosenBroker.name,
          email: choosenBroker.email!,
        );

    final choosenShipper = ref.read(selectedFacilityProvider)?.choosenShipper;
    if (choosenShipper == null) return;

    setState(() {
      _logStarted = true;
    });
  }

  Future<void> _onBrokerAction() async {
    if (!context.mounted) return;
    final newBroker = await context.push<CreateBrokerResponseData?>(
      Routes.createBroker,
    );

    if (newBroker == null) return;

    ref
        .read(selectedFacilityProvider.notifier)
        .selectBroker(
          id: newBroker.id!,
          email: newBroker.email!,
          name: newBroker.name!,
        );
  }

  @override
  Widget build(BuildContext context) {
    final session = _sessionId != null && _sessionId!.isNotEmpty
        ? ref.watch(getSingleLogWithId(_sessionId!))
        : const AsyncValue.data(null);

    ref.listen(getCurrentActiveStoplog, (prev, next) {
      if (!mounted) return;

      setState(() {
        _sessionId = next.value?.id;
        _isActiveSessionLoading = next.isLoading;
      });
    });

    ref.listen(getSingleLogWithId(_sessionId), (prev, next) {
      if (!mounted) return;

      next.when(
        data: (data) {
          setState(() {
            _logStarted = data?.id != null;
          });

          if (data?.facilityName != null) {
            // TODO: update lat,lon from here
            ref
                .read(selectedFacilityProvider.notifier)
                .selectFacility(
                  ShipperSearchFacilityItem(
                    id: data?.id,
                    name: data!.facilityName!,
                    address: data.address,
                  ),
                );
          }

          final broker = data?.broker;
          if (broker != null && broker.id != null) {
            ref
                .read(selectedFacilityProvider.notifier)
                .selectBroker(
                  id: broker.id!,
                  email: broker.email!,
                  name: broker.name!,
                );
          }
          // Success
        },
        loading: () {
          // Loading
        },
        error: (err, stack) {
          // Error
        },
      );
    });

    final isLoading =
        _isActiveSessionLoading && _sessionId == null ||
        session.isLoading && !session.hasValue;

    // print("value ==========================================");
    // print(session.value);
    // print(session.value?.status);
    // print(session.value?.currentStep);
    // print("==========================================");
    // final canCalculateAndPreview = session.value?.status == .completed;
    // print(session.error.toString());
    // print(session.stackTrace);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0F1419),
      appBar: GlobalAppBar(
        hideBackButton: true,
        title: 'Log Stop',
        subTitle: "Review details before sending",
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: isLoading
              ? Center(child: ActivityIndicator())
              : session.hasError
              ? StatusDisplay.error(session.error.toString())
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.screenPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      SearchableFieldSection(
                        icon: Icons.business,
                        title: "Facility Name",
                        hintText: "Select a facility",
                        controller: _facilityTextController,
                        focusNode: _facilityFocusNode,
                        enabled: !(_logStarted && _sessionId != null),
                        onTap: _onFacilityTap,
                        onAction: _onFacilityAction,
                      ),
                      SizedBox(height: 8.h),
                      SearchableFieldSection(
                        icon: Icons.person,
                        title: "Broker Name",
                        hintText: "Select a broker",
                        controller: _brokerTextController,
                        focusNode: _brokerFocusNode,
                        enabled: !(_logStarted && _sessionId != null),
                        onTap: _onBrokerTap,
                        onAction: _onBrokerAction,
                      ),

                      SizedBox(height: 24.h),
                      TimelineSection(
                        logStarted: _logStarted,
                        key: _timelineKey,
                        onSingleLogComplete: (_) {},
                        activateCalculateBtn: activateCalculateBtn,
                        session: session.value,
                      ),

                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPadding.screenPadding,
          0,
          AppPadding.screenPadding,
          12,
        ),
        child: GlobalButton(
          isLoading: _loadingActionBtn,
          isDisabled: !_canCalculateAndPreview,
          label: "Calculate & Preview",
          onPressed: () async {
            setState(() {
              _loadingActionBtn = true;
            });
            final success = await _timelineKey.currentState
                ?.logBolNumberAndAttachment();

            setState(() {
              _loadingActionBtn = false;
            });

            if (success == true) endCurrentSession();
          },
        ),
      ),
    );
  }
}
