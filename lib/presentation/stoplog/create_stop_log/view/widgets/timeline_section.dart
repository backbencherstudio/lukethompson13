import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/data/models/stops/single_stoplog.model.dart';
import 'package:lukethompson/data/models/stops/stop_log.model.dart';
import 'package:lukethompson/data/models/stops/stop_log_location.model.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';
import 'package:lukethompson/data/sources/local/gps_service.dart';

import 'timeline_item.dart';

class TimelineSection extends ConsumerStatefulWidget {
  const TimelineSection({super.key, this.session});

  final SingleStoplogData? session;

  @override
  ConsumerState<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends ConsumerState<TimelineSection> {
  var arrivalStatus = TimelineItemStatus.idle;
  var dockInStatus = TimelineItemStatus.idle;
  var completedStatus = TimelineItemStatus.idle;
  var departureStatus = TimelineItemStatus.idle;

  static const String _initialDockInTime = '08:15 AM';
  static const String _initialCompletedTime = '12:45 AM';
  static const String _initialDepartureTime = '01:00 PM';

  final TextEditingController dockInController = TextEditingController(
    text: _initialDockInTime,
  );
  final TextEditingController completedController = TextEditingController(
    text: _initialCompletedTime,
  );
  final TextEditingController departureController = TextEditingController(
    text: _initialDepartureTime,
  );

  @override
  void initState() {
    super.initState();
    _updateStatuses();
  }

  @override
  void didUpdateWidget(TimelineSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.session != widget.session) {
      _updateStatuses();
    }
  }

  void _updateStatuses() {
    final s = widget.session;
    if (s == null) return;

    setState(() {
      switch (s.currentStep) {
        case StopLogStep.arrivalTime:
          arrivalStatus = .completed;
          dockInStatus = .active;
        case StopLogStep.dockInTime:
          arrivalStatus = .completed;
          dockInStatus = .completed;
          completedStatus = .active;
        case StopLogStep.completedTime:
          arrivalStatus = .completed;
          dockInStatus = .completed;
          completedStatus = .completed;
          departureStatus = .active;
        case StopLogStep.departureTime:
          arrivalStatus = .completed;
          dockInStatus = .completed;
          completedStatus = .completed;
          departureStatus = .completed;
        case null:
          context.showErrorSnackBar("currentStep is null");
      }
    });
  }

  @override
  void dispose() {
    dockInController.dispose();
    completedController.dispose();
    departureController.dispose();
    super.dispose();
  }

  Future<void> _logArrivalTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      step: .arrivalTime,
      facilityName: "Test facility",
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: 40.7128,
        lng: -74.006,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      arrivalStatus = TimelineItemStatus.completed;
      dockInStatus = TimelineItemStatus.active;
    });

    if (mounted) {
      context.showSuccessSnackBar("Arrival Time logged successfully");
    }
    ref.invalidate(getStoplogListQuery);
  }

  Future<void> _logDockedInTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .dockInTime,
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      dockInStatus = TimelineItemStatus.completed;
      completedStatus = TimelineItemStatus.active;
    });
    if (mounted) {
      context.showSuccessSnackBar("Dock In Time logged successfully");
    }
    ref.invalidate(getStoplogListQuery);
  }

  Future<void> _logCompletedTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .completedTime,
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      completedStatus = TimelineItemStatus.completed;
      departureStatus = TimelineItemStatus.active;
    });
    if (mounted) {
      context.showSuccessSnackBar("Completed Time logged successfully");
    }
    ref.invalidate(getStoplogListQuery);
  }

  Future<void> _logDepartureTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentLocation();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .departureTime,
      location: StopLogLocation(
        city: 'Dhaka',
        state: 'Dhaka Division',
        country: 'BD',
        address: 'Warehouse A, Williamsburg Bridge',
        zip: '10001',
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      departureStatus = TimelineItemStatus.completed;
    });
    if (mounted) {
      context.showSuccessSnackBar("Departure Time logged successfully");
    }
    ref.invalidate(getStoplogListQuery);
  }

  @override
  Widget build(BuildContext context) {
    final recordStopLogMutation = ref.watch(recordStopLogProviderAction);
    // print("===================== createLogState =====================");
    // print(recordStopLogMutation.status);
    // print("=========================================================");

    return Column(
      children: [
        if (recordStopLogMutation.isPending) ...[
          const CircularProgressIndicator(),
          const SizedBox(width: 8),
        ],

        TimelineItem(
          title: 'Arrival Time',
          status: arrivalStatus,
          controller: dockInController,
          onConfirm: () => tryAwait(
            _logArrivalTime(),
            onError: (e, _) => context.showErrorSnackBar(e.toString()),
          ),
          onChanged: (value) {
            setState(() {
              // no edited flag needed internally
            });
          },
        ),
        TimelineItem(
          title: 'Dock In Time',
          status: dockInStatus,
          controller: dockInController,
          onChanged: (_) {},
          onConfirm: () => tryAwait(
            _logDockedInTime(),
            onError: (e, _) => context.showErrorSnackBar(e.toString()),
          ),
        ),
        TimelineItem(
          title: 'Completed Time',
          status: completedStatus,
          controller: completedController,
          onChanged: (_) {},
          onConfirm: () => tryAwait(
            _logCompletedTime(),
            onError: (e, _) => context.showErrorSnackBar(e.toString()),
          ),
        ),
        TimelineItem(
          title: 'Departure Time',
          status: departureStatus,
          controller: departureController,
          isLastStep: true,
          onChanged: (_) {},
          onConfirm: () => tryAwait(
            _logDepartureTime(),
            onError: (e, _) => context.showErrorSnackBar(e.toString()),
          ),
        ),
      ],
    );
  }
}
