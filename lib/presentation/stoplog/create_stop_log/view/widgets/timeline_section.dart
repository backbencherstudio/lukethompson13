import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lukethompson/core/extensions/datetime_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/custom_dialog.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/state/facility_search_state.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/log_stop_result_screen.dart';

import 'attachment_upload_section.dart';
import 'timeline_item.dart';

class TimelineSection extends ConsumerStatefulWidget {
  const TimelineSection({
    super.key,
    this.session,
    required this.onSingleLogComplete,
    required this.activateCalculateBtn,
    required this.logStarted,
    this.arrivalDestinationDistance,
  });

  final SingleStoplogDetailData? session;
  final void Function(StopLogStep step) onSingleLogComplete;
  final void Function(bool) activateCalculateBtn;
  final bool logStarted;
  final double? arrivalDestinationDistance;

  @override
  ConsumerState<TimelineSection> createState() => TimelineSectionState();
}

class TimelineSectionState extends ConsumerState<TimelineSection> {
  var _arrivalStatus = TimelineItemStatus.idle;
  var _dockInStatus = TimelineItemStatus.idle;
  var _completedStatus = TimelineItemStatus.idle;
  var _departureStatus = TimelineItemStatus.idle;
  var _bolNumberStatus = TimelineItemStatus.idle;
  var _attachmentsStatus = TimelineItemStatus.idle;

  TimelineItemStatus _activateTimelineLogging(TimelineItemStatus status) {
    return widget.logStarted ? status : .idle;
  }

  List<XFile> _attachmentFile = [];

  final bolNumberController = TextEditingController();

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
    if (s == null) {
      setState(() {
        _arrivalStatus = TimelineItemStatus.active;
        _dockInStatus = TimelineItemStatus.idle;
        _completedStatus = TimelineItemStatus.idle;
        _departureStatus = TimelineItemStatus.idle;
        _attachmentsStatus = TimelineItemStatus.idle;
        _bolNumberStatus = TimelineItemStatus.idle;
      });
      return;
    }

    setState(() {
      if (s.bolNumber != null && bolNumberController.text != s.bolNumber) {
        bolNumberController.text = s.bolNumber!;
      }

      _arrivalStatus = TimelineItemStatus.idle;
      _dockInStatus = TimelineItemStatus.idle;
      _completedStatus = TimelineItemStatus.idle;
      _departureStatus = TimelineItemStatus.idle;
      _attachmentsStatus = TimelineItemStatus.idle;
      _bolNumberStatus = TimelineItemStatus.idle;

      switch (s.currentStep) {
        case StopLogStep.arrivalTime:
          _arrivalStatus = TimelineItemStatus.completed;
          _dockInStatus = TimelineItemStatus.active;
        case StopLogStep.dockInTime:
          _arrivalStatus = TimelineItemStatus.completed;
          _dockInStatus = TimelineItemStatus.completed;
          _completedStatus = TimelineItemStatus.active;
        case StopLogStep.completedTime:
          _arrivalStatus = TimelineItemStatus.completed;
          _dockInStatus = TimelineItemStatus.completed;
          _completedStatus = TimelineItemStatus.completed;
          _departureStatus = TimelineItemStatus.active;
        case StopLogStep.departureTime:
          _arrivalStatus = TimelineItemStatus.completed;
          _dockInStatus = TimelineItemStatus.completed;
          _completedStatus = TimelineItemStatus.completed;
          _departureStatus = TimelineItemStatus.completed;
          _bolNumberStatus = TimelineItemStatus.active;
        case StopLogStep.uploadDocuments:
          _arrivalStatus = TimelineItemStatus.completed;
          _dockInStatus = TimelineItemStatus.completed;
          _completedStatus = TimelineItemStatus.completed;
          _departureStatus = TimelineItemStatus.completed;
          _attachmentsStatus = TimelineItemStatus.active;
        case null:
      }

      if (s.bolNumber != null && s.bolNumber!.isNotEmpty) {
        _bolNumberStatus = TimelineItemStatus.completed;
      }

      if (s.attachments != null && s.attachments!.isNotEmpty) {
        _attachmentFile = s.attachments!
            .map((a) => XFile(a.fileUrl ?? '', name: a.fileName))
            .toList();
        _attachmentsStatus = TimelineItemStatus.completed;
      }
    });
  }

  @override
  void dispose() {
    bolNumberController.dispose();
    super.dispose();
  }

  ShipperSearchFacilityItem? getCurrentFacility() {
    final currentFacility = ref.read(selectedFacilityProvider)?.choosenShipper;

    if (currentFacility == null) {
      context.showErrorSnackBar("Select a facility");
      return null;
    }

    return currentFacility;
  }

  Future<void> _logArrivalTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId != null) return;

    final position = await GpsService.getCurrentPosition();
    if (position == null) return;

    final currentFacility = getCurrentFacility();
    if (currentFacility == null) return;

    final (
      withinRadius,
      distance,
    ) = await GpsService.isTruckWithinArrivalRadius(
      selectedFacility: currentFacility,
      currentPosition: position,
      mock: false,
    );

    final ctx = context;

    if (!withinRadius) {
      if (!ctx.mounted) return;
      openNowReachedMsg(ctx, distance);
      return;
    }

    final params = RecordStopLogParams(
      step: .arrivalTime,
      shipperId: currentFacility.id,
      facilityName: currentFacility.name,
      location: StopLogLocation(
        // city: 'Dhaka',
        // state: 'Dhaka Division',
        // country: 'BD',
        // zip: '10001',
        address: currentFacility.address,
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
      _arrivalStatus = TimelineItemStatus.completed;
      _dockInStatus = TimelineItemStatus.active;
    });

    if (mounted) {
      context.showSuccessSnackBar("Arrival Time logged successfully");
      widget.onSingleLogComplete(.arrivalTime);
      _refetchSession();
    }
  }

  Future<dynamic> openNowReachedMsg(BuildContext ctx, double? distance) {
    return showDialog(
      context: ctx,
      builder: (context) => CustomDialog(
        title: 'Destination not reached',
        subtitle:
            'You’re ${_formatDistance(distance ?? 0)} away from the destination. Please move closer to continue.',
        bottomWidget: Row(
          spacing: 12,
          children: [
            Expanded(
              child: GlobalButton.outlined(
                label: 'Close',
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logDockedInTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentPosition();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .dockInTime,
      location: StopLogLocation(
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
      _dockInStatus = TimelineItemStatus.completed;
      _completedStatus = TimelineItemStatus.active;
    });
    if (mounted) {
      context.showSuccessSnackBar("Dock In Time logged successfully");
      widget.onSingleLogComplete(.dockInTime);
      _refetchSession();
    }
  }

  Future<void> _logCompletedTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentPosition();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .completedTime,
      location: StopLogLocation(
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
      _completedStatus = TimelineItemStatus.completed;
      _departureStatus = TimelineItemStatus.active;
    });
    if (mounted) {
      context.showSuccessSnackBar("Completed Time logged successfully");
      widget.onSingleLogComplete(.completedTime);
      _refetchSession();
    }
  }

  Future<void> _logDepartureTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final position = await GpsService.getCurrentPosition();
    if (position == null) return;

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: .departureTime,
      location: StopLogLocation(
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
      _departureStatus = TimelineItemStatus.completed;
    });
    if (mounted) {
      context.showSuccessSnackBar("Departure Time logged successfully");
      widget.onSingleLogComplete(.departureTime);
      _refetchSession();
    }
  }

  bool _isActionPending(StopLogStep? step, bool isPending) {
    return isPending && widget.session?.currentStep == step;
  }

  void _refetchSession() {
    ref.invalidate(getCurrentActiveStoplog);
    ref.invalidate(getSingleLogWithId);
  }

  Future<void> _pickAttachmentFile(List<XFile> files) async {
    _attachmentFile = files;
    setState(() {
      _attachmentsStatus = TimelineItemStatus.completed;
    });
    widget.activateCalculateBtn(true);
  }

  Future<void> _logBolNumberAndAttachment() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId == null) return;

    final hasExistingAttachments =
        widget.session?.attachments != null &&
        widget.session!.attachments!.isNotEmpty;
    if (_attachmentFile.isEmpty && !hasExistingAttachments) {
      context.showErrorSnackBar("Please select an attachment file");
      return;
    }

    final multipartFiles = _attachmentFile
        .map((f) => MultipartFile.fromFileSync(f.path, filename: f.name))
        .toList();

    final params = RecordStopLogParams(
      id: activeSessionId,
      step: StopLogStep.uploadDocuments,
      bolNumber: bolNumberController.text.trim().isEmpty
          ? null
          : bolNumberController.text.trim(),
      attachments: multipartFiles.isNotEmpty ? multipartFiles : null,
    );

    final res = await ref
        .read(recordStopLogProviderAction.notifier)
        .record(params);

    if (!res.success && mounted) {
      context.showErrorSnackBar(res.message);
      return;
    }

    setState(() {
      _bolNumberStatus = TimelineItemStatus.completed;
    });

    if (mounted) {
      context.push(
        Routes.logStopResult,
        extra: LogStopResultScreenArg(stopLogId: widget.session?.id),
      );
      _attachmentFile = [];
      widget.activateCalculateBtn(false);
      _refetchSession();
    }
  }

  Future<bool> logBolNumberAndAttachment() async {
    final (res, err) = await tryCatch(
      _logBolNumberAndAttachment(),
      onError: (e, _) => context.showErrorSnackBar(e.toString()),
    );

    return err == null;
  }

  @override
  Widget build(BuildContext context) {
    final recordStopLogMutation = ref.watch(recordStopLogProviderAction);
    // final validatedArrivalStatus =
    //     _arrivalStatus == .active && !widget.isWithinArrivalRadius
    //     ? TimelineItemStatus.idle
    //     : _arrivalStatus;

    return Column(
      children: [
        // Text(
        //   "isPending ${recordStopLogMutation.isPending.toString()} | currentStep ${widget.session?.currentStep}",
        // ),
        TimelineItem(
          isActionPending: _isActionPending(
            null,
            recordStopLogMutation.isPending,
          ),
          label: 'Arrival Time',
          labelTail: widget.arrivalDestinationDistance == null
              ? null
              : Text(
                  _formatDistance(widget.arrivalDestinationDistance ?? 0.0),
                  style: TextStyle(
                    fontWeight: .w700,
                    color: ColorManager.subtextColor.withValues(alpha: 0.8),
                  ),
                ),
          status: _activateTimelineLogging(_arrivalStatus),
          child: TimelineContent(
            value: widget.session?.arrivedAt?.formatTime(),
            status: _activateTimelineLogging(_arrivalStatus),
            isActionPending: _isActionPending(
              null,
              recordStopLogMutation.isPending,
            ),
            onChanged: (value) => setState(() {}),
            onConfirm: () => tryCatch(
              _logArrivalTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending: _isActionPending(
            .arrivalTime,
            recordStopLogMutation.isPending,
          ),
          label: 'Dock In Time',
          status: _activateTimelineLogging(_dockInStatus),
          child: TimelineContent(
            value: widget.session?.dockedAt?.formatTime(),
            status: _activateTimelineLogging(_dockInStatus),
            isActionPending: _isActionPending(
              .arrivalTime,
              recordStopLogMutation.isPending,
            ),
            onChanged: (_) {},
            onConfirm: () => tryCatch(
              _logDockedInTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending: _isActionPending(
            .dockInTime,
            recordStopLogMutation.isPending,
          ),
          label: 'Completed Time',
          status: _activateTimelineLogging(_completedStatus),
          child: TimelineContent(
            value: widget.session?.completedAt?.formatTime(),
            status: _activateTimelineLogging(_completedStatus),
            isActionPending: _isActionPending(
              .dockInTime,
              recordStopLogMutation.isPending,
            ),
            onChanged: (_) {},
            onConfirm: () => tryCatch(
              _logCompletedTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending: _isActionPending(
            .completedTime,
            recordStopLogMutation.isPending,
          ),
          label: 'Departure Time',
          status: _activateTimelineLogging(_departureStatus),
          child: TimelineContent(
            value: widget.session?.departedAt?.formatTime(),
            status: _activateTimelineLogging(_departureStatus),
            isActionPending: _isActionPending(
              .completedTime,
              recordStopLogMutation.isPending,
            ),
            onChanged: (_) {},
            onConfirm: () => tryCatch(
              _logDepartureTime(),
              onError: (e, _) => context.showErrorSnackBar(e.toString()),
            ),
          ),
        ),
        TimelineItem(
          isActionPending:
              _bolNumberStatus == TimelineItemStatus.active &&
              recordStopLogMutation.isPending,
          label: 'BOL Number',
          labelHint: '(Optional)',
          status: _activateTimelineLogging(_bolNumberStatus),
          child: TimelineContentField(
            canSkip: true,
            controller: bolNumberController,
            status: _activateTimelineLogging(_bolNumberStatus),
            isActionPending:
                _bolNumberStatus == TimelineItemStatus.active &&
                recordStopLogMutation.isPending,
            onChanged: (_) {},
            onConfirm: () {
              setState(() {
                _bolNumberStatus = TimelineItemStatus.completed;
                _attachmentsStatus = TimelineItemStatus.active;
              });
            },
          ),
        ),
        TimelineItem(
          isLastStep: true,
          isActionPending:
              widget.logStarted &&
              _attachmentsStatus == .active &&
              recordStopLogMutation.isPending,
          label: 'Attachments',
          status: _activateTimelineLogging(_attachmentsStatus),
          child: AttachmentUploadSection(
            attachments: _attachmentFile,
            disabled: _attachmentsStatus != .active,
            onAttachmentPicked: (file) => _pickAttachmentFile(file),
            onAttachmentRemoved: (files, _) {
              setState(() {
                _attachmentFile = files;
                if (_attachmentFile.isEmpty) {
                  _attachmentsStatus = TimelineItemStatus.active;
                  widget.activateCalculateBtn(false);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}

String _formatDistance(double meters) {
  if (meters >= 1000) {
    return '${(meters / 1000).toStringAsFixed(2)} km';
  }
  return '${meters.toStringAsFixed(1)} m';
}
