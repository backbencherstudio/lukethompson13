import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/data/models/stops/active_stoplog.model.dart';
import 'package:lukethompson/data/models/stops/single_stoplog.model.dart';
import 'package:lukethompson/data/models/stops/stop_log_location.model.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';

import 'timeline_item.dart';

class TimelineSection extends ConsumerStatefulWidget {
  const TimelineSection({super.key, this.activeSession});

  final ActiveStoplogData? activeSession;

  @override
  ConsumerState<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends ConsumerState<TimelineSection> {
  var arrivalStatus = TimelineItemStatus.active;
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

  SingleStoplogData? currentAciveSession;

  @override
  void initState() {
    super.initState();

    final session = widget.activeSession;
    if (session != null) {
      currentAciveSession = ref.watch(getSingleLogWithId(session.id)).value;
    }
  }

  @override
  void dispose() {
    dockInController.dispose();
    completedController.dispose();
    departureController.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
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
      debugPrint('Location: $position');
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _logArrivalTime() async {
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

    _getLocation().then((_) {
      setState(() {
        arrivalStatus = TimelineItemStatus.completed;
        dockInStatus = TimelineItemStatus.active;
      });
    });
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
            onError: (e, _) => showSnackbarError(context, e),
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
          onConfirm: () {
            _getLocation().then((_) {
              setState(() {
                dockInStatus = TimelineItemStatus.completed;
                completedStatus = TimelineItemStatus.active;
              });
            });
          },
        ),
        TimelineItem(
          title: 'Completed Time',
          status: completedStatus,
          controller: completedController,
          onChanged: (_) {},
          onConfirm: () {
            _getLocation().then((_) {
              setState(() {
                completedStatus = TimelineItemStatus.completed;
                departureStatus = TimelineItemStatus.active;
              });
            });
          },
        ),
        TimelineItem(
          title: 'Departure Time',
          status: departureStatus,
          controller: departureController,
          isLastStep: true,
          onChanged: (_) {},
          onConfirm: () {
            _getLocation().then((_) {
              setState(() {
                departureStatus = TimelineItemStatus.completed;
              });
            });
          },
        ),
      ],
    );
  }
}
