import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lukethompson/core/extensions/datetime_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';
import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/log_stop_result_screen.dart';

import 'attachment_upload_section.dart';
import 'timeline_item.dart';

class TimelineSection extends ConsumerStatefulWidget {
  const TimelineSection({
    super.key,
    this.session,
    required this.onSingleLogComplete,
    required this.activateCalculateBtn,
  });

  final SingleStoplogDetailData? session;
  final void Function(StopLogStep step) onSingleLogComplete;
  final void Function(bool) activateCalculateBtn;

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
  List<XFile> _attachmentFile = [];

  static const String _initialDepartureTime = '01:00 PM';

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

  Future<void> _logArrivalTime() async {
    final activeSessionId = widget.session?.id;
    if (activeSessionId != null) return;

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
      _arrivalStatus = TimelineItemStatus.completed;
      _dockInStatus = TimelineItemStatus.active;
    });

    if (mounted) {
      context.showSuccessSnackBar("Arrival Time logged successfully");
      widget.onSingleLogComplete(.arrivalTime);
      _refetchSession();
    }
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

  Future<void> logBolNumberAndAttachment() async {
    await tryCatch(
      _logBolNumberAndAttachment(),
      onError: (e, _) => context.showErrorSnackBar(e.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recordStopLogMutation = ref.watch(recordStopLogProviderAction);
    print(widget.session?.arrivedAt.runtimeType);

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
          status: _arrivalStatus,
          child: TimelineContent(
            value: widget.session?.arrivedAt?.formatTime(),
            status: _arrivalStatus,
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
          status: _dockInStatus,
          child: TimelineContent(
            value: widget.session?.dockedAt?.formatTime(),
            status: _dockInStatus,
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
          status: _completedStatus,
          child: TimelineContent(
            value: widget.session?.completedAt?.formatTime(),
            status: _completedStatus,
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
          status: _departureStatus,
          child: TimelineContent(
            value: widget.session?.departedAt?.formatTime(),
            status: _departureStatus,
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
          status: _bolNumberStatus,
          child: TimelineContentField(
            canSkip: true,
            controller: bolNumberController,
            status: _bolNumberStatus,
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
              _attachmentsStatus == .active && recordStopLogMutation.isPending,
          label: 'Attachments',
          status: _attachmentsStatus,
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
