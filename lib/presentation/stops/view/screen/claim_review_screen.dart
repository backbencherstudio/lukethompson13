import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/utils/logger.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/claim/claim_api_controller.dart';
import 'package:lukethompson/data/sources/remote/stoplog/stoplog_list_infinite_scroll.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stops/view/widget/claim_status_card.dart';
import 'package:lukethompson/presentation/stops/view/widget/export_pdf_button.dart';
import 'package:lukethompson/presentation/stops/view/widget/full_claim_preview_card.dart';

class ClaimReviewScreenArg {
  const ClaimReviewScreenArg({this.steplogId});

  final String? steplogId;
}

class ClaimReviewScreen extends ConsumerWidget {
  const ClaimReviewScreen({super.key, this.argument});

  final ClaimReviewScreenArg? argument;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = FullClaimPreviewCard.getSession(ref, argument?.steplogId);
    final markAClaimAsPaidState = ref.watch(markAClaimAsPaidMutation);
    final markAClaimAsDeniedState = ref.watch(markAClaimAsDeniedMutation);

    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(
          title: 'Claim Review',
          subTitle: 'Review details - Cannot edit after sending',
        ),
        body: SafeArea(
          child: session.when(
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            data: (data) {
              logger.t(data?.detentionSummaryPdf);
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.height,
                    FullClaimPreviewCard(data: data),
                    16.height,
                    ExportPdfButton(
                      fileUrl: data?.detentionSummaryPdf?.fileUrl,
                      fineName: data?.detentionSummaryPdf?.fileName,
                    ),

                    24.height,
                    if (data != null) ClaimStatusCard(data: data),
                    24.height,

                    GlobalButton(
                      isLoading: markAClaimAsPaidState.isPending,
                      label: 'Mark as Paid',
                      onPressed: () =>
                          _onMarkAsPaidPressed(context, ref, data?.claim?.id),
                    ),
                    16.height,
                    GlobalButton.outlined(
                      isLoading: markAClaimAsDeniedState.isPending,
                      label: 'Mark as Denied',
                      onPressed: () =>
                          _onMarkAsDeniedPressed(context, ref, data?.claim?.id),
                    ),
                    // 16.height,
                    // TODO: this page should navigate the user to claim details
                    // page & show current follow up section
                    // GlobalButton.secondary(
                    //   label: 'Send Follow-up',
                    //   onPressed: () => _onFollowUp(context, ref, data?.claim?.id),
                    // ),
                    24.height,
                  ],
                ),
              );
            },
            loading: () => const Center(child: ActivityIndicator()),
            error: (e, st) {
              return StatusDisplay.error(e.toString());
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onMarkAsPaidPressed(
    BuildContext context,
    WidgetRef ref,
    String? claimId,
  ) async {
    if (claimId == null) return;

    final (res, err) = await tryCatch(
      ref.read(markAClaimAsPaidMutation.notifier).submit(claimId),
    );
    if (!context.mounted) return;

    if (err != null) {
      context.showErrorSnackBar(ErrorHandle.formatErrorMessage(err));
      return;
    }

    if (res != null) {
      context.showResultSnackBar(res.message, isSuccess: res.success);

      if (res.success) {
        context.pop();
        ref.invalidate(stopLogPaginationProvider);
      }
    }
  }

  Future<void> _onMarkAsDeniedPressed(
    BuildContext context,
    WidgetRef ref,
    String? claimId,
  ) async {
    if (claimId == null) return;

    final (res, err) = await tryCatch(
      ref.read(markAClaimAsDeniedMutation.notifier).submit(claimId),
    );
    if (!context.mounted) return;

    if (err != null) {
      context.showErrorSnackBar(ErrorHandle.formatErrorMessage(err));
      return;
    }

    if (res != null) {
      context.showResultSnackBar(res.message, isSuccess: res.success);

      if (res.success) {
        context.pop();
        ref.invalidate(stopLogPaginationProvider);
      }
    }
  }

  Future<void> _onFollowUp(
    BuildContext context,
    WidgetRef ref,
    String? claimId,
  ) async {
    if (claimId == null) return;

    final (res, err) = await tryCatch(
      ref
          .read(sendClaimFollowUpEmailMutation.notifier)
          .sendFollowUp(claimId, 1),
    );
    if (!context.mounted) return;

    if (err != null) {
      context.showErrorSnackBar(ErrorHandle.formatErrorMessage(err));
      return;
    }

    if (res != null) {
      context.showResultSnackBar(res.message, isSuccess: res.success);
    }
  }
}
