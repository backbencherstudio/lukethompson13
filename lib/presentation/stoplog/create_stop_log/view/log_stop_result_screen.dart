import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/big_stat_card.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/stoplog/stoplog_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/ClaimSendTo.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/breakdown_card.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/proof_package_list.dart';
import 'package:lukethompson/presentation/stops/view/screen/claim_now_screen.dart';

class LogStopResultScreenArg {
  final String? stopLogId;
  const LogStopResultScreenArg({this.stopLogId});
}

class LogStopResultScreen extends ConsumerWidget {
  const LogStopResultScreen({super.key, required this.argument});

  final LogStopResultScreenArg argument;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = argument.stopLogId != null && argument.stopLogId!.isNotEmpty
        ? ref.watch(getSingleLogWithId(argument.stopLogId!))
        : const AsyncValue.data(null);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: session.value?.facilityName ?? 'Claim Preview',
        subTitle: session.value?.address,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: session.when(
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            data: (data) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    24.height,
                    BigStatCard.success(
                      title: 'Detention Owed',
                      value: CurrencyFormatter.format(data?.detention),
                      subtitle: '3h billable • \$50/hr',
                    ),
                    SizedBox(height: 16),
                    BigStatCard.destructive(
                      title: 'Revenue Lost',
                      value: CurrencyFormatter.format(data?.lost),
                      subtitle: 'Total 5h • \$50/hr',
                    ),
                    SizedBox(height: 16),
                    BreakdownCard(
                      items: [
                        BreakdownItem(
                          label: 'Arrival - Departure',
                          value: data?.arrivalDepartureTime ?? '',
                        ),
                        BreakdownItem(
                          label: 'Free Wait Time',
                          value: data?.freeWaitTime.toString() ?? '',
                        ),
                        BreakdownItem(
                          label: 'Billable Time',
                          value: data?.billableTimeText ?? '',
                          valueColor: ColorManager.primaryButton,
                        ),
                      ],
                    ),

                    24.height,
                    Text('PROOF PACKAGE', style: getSubtextStyle()),

                    8.height,
                    ProofPackageList(
                      fineNames:
                          data?.attachments?.map((e) => e.fileName).toList() ??
                          [],
                    ),

                    if (data != null) ClaimSendTo(data: data),
                    16.height,
                    GlobalButton.outlined(
                      label: 'Export PDF',
                      onPressed: () {
                        ref.invalidate(getSingleLogWithId(argument.stopLogId!));
                        context.push(
                          Routes.claimNow,
                          extra: ClaimNowScreenArg(
                            steplogId: data?.id,
                            facilityName: data?.facilityName,
                            shipperFacilityId: data?.shipperFacilityId,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: ActivityIndicator()),
            error: (e, _) => StatusDisplay.error(e.toString()),
          ),
        ),
      ),
    );
  }
}
