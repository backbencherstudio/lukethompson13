import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/data/models/stops/stop_log_list_response.model.dart';
import 'package:lukethompson/presentation/parent_screen/parent_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/claim_now_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/claim_review_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/rate_shipper_screen.dart';

class StopActionButton extends ConsumerWidget {
  const StopActionButton({super.key, required this.stop});

  final StopLogListItem stop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = getStopAction(stop);
    if (action.onPressed == null || stop.rating != null) {
      return SizedBox.shrink();
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: action.color,
        backgroundColor: action.color?.withValues(alpha: 0.1),
        side: BorderSide(color: action.color ?? Colors.grey, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => action.onPressed?.call(context, ref),
      child: Text(action.label),
    );
  }
}

class StopAction {
  const StopAction({required this.label, required this.onPressed, this.color});

  final String label;
  final void Function(BuildContext context, WidgetRef ref)? onPressed;
  final Color? color;
}

StopAction getStopAction(StopLogListItem stop) {
  if (stop.status == .active) {
    return StopAction(
      label: 'Open Log',
      color: ColorManager.infoColor,
      onPressed: (_, ref) {
        ref.read(parentScreenIndexProvider.notifier).goToLog();
      },
    );
  }

  switch (stop.claimStatus) {
    case ClaimStatus.draft:
      return StopAction(
        label: 'Claim Now',
        color: ColorManager.successColor,
        onPressed: (context, _) {
          context.push(
            Routes.claimNow,
            extra: ClaimNowScreenArg(
              steplogId: stop.id,
              facilityName: stop.facilityName,
              shipperFacilityId: stop.shipperFacilityId,
            ),
          );
        },
      );

    case ClaimStatus.submitted:
      return StopAction(
        label: 'Review Claim',
        color: ColorManager.infoColor,
        onPressed: (context, _) {
          context.push(
            Routes.claimReview,
            extra: ClaimReviewScreenArg(steplogId: stop.id),
          );
        },
      );

    case ClaimStatus.paid:
    case ClaimStatus.denied:
      return StopAction(
        label: 'Rate Shipper',
        color: ColorManager.warningColor,
        onPressed: (context, _) {
          context.push(
            Routes.rateShipper,
            extra: RateShipperScreenArg(
              id: stop.id,
              facilityName: stop.facilityName,
            ),
          );
        },
      );

    default:
      return StopAction(label: '-', onPressed: null);
  }
}
