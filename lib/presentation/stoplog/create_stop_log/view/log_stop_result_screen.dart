import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/big_stat_card.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/breakdown_card.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/proof_package_list.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/send_method_toggle.dart';

class LogStopResultScreenArg {
  final String? stopLogId;
  const LogStopResultScreenArg({this.stopLogId});
}

class LogStopResultScreen extends ConsumerStatefulWidget {
  const LogStopResultScreen({super.key, required this.argument});

  final LogStopResultScreenArg argument;

  @override
  ConsumerState<LogStopResultScreen> createState() =>
      _LogStopResultScreenState();
}

class _LogStopResultScreenState extends ConsumerState<LogStopResultScreen> {
  int _sendMethodIndex = 0;
  final _recipientController = TextEditingController();
  final _ccController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _ccController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session =
        widget.argument.stopLogId != null &&
            widget.argument.stopLogId!.isNotEmpty
        ? ref.watch(getSingleLogWithId(widget.argument.stopLogId!))
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

                    12.height,
                    ProofPackageList(
                      fineNames:
                          data?.attachments?.map((e) => e.fileName).toList() ??
                          [],
                    ),

                    24.height,
                    SectionHeader(title: 'Send To'),
                    12.height,
                    InputLabel('Recipient Email'),
                    8.height,
                    CustomTextFieldWidget(
                      hintText: "Enter recipient email",
                      controller: _recipientController,
                    ),
                    SizedBox(height: 16),

                    InputLabel('CC Broker', hint: '(Optional)'),
                    8.height,
                    CustomTextFieldWidget(
                      hintText: "Enter CC broker",
                      controller: _ccController,
                    ),

                    16.height,
                    SendMethodToggle(
                      selectedIndex: _sendMethodIndex,
                      onChanged: (index) =>
                          setState(() => _sendMethodIndex = index),
                    ),

                    16.height,
                    GlobalButton(label: 'Claim Now', onPressed: () {}),
                    16.height,
                    GlobalButton.secondary(
                      label: 'Export PDF',
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: ActivityIndicator()),
            error: (e, _) => StatusDisplay.error(e.toString()),
          ),
          // child: SingleChildScrollView(
          //   padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
          //   child: Column(
          //     crossAxisAlignment: .stretch,
          //     children: [
          //       24.height,
          //       BigStatCard.success(
          //         title: 'Detention Owed',
          //         value: '\$225',
          //         subtitle: '3h billable • \$50/hr',
          //       ),
          //       SizedBox(height: 16),
          //       BigStatCard.destructive(
          //         title: 'Revenue Lost',
          //         value: '\$300',
          //         subtitle: 'Total 5h • \$50/hr',
          //       ),
          //       SizedBox(height: 16),
          //       const BreakdownCard(
          //         items: [
          //           BreakdownItem(label: 'Arrival - Departure', value: '5h'),
          //           BreakdownItem(label: 'Free Wait Time', value: '2h'),
          //           BreakdownItem(
          //             label: 'Billable Time',
          //             value: '3h',
          //             valueColor: ColorManager.primaryButton,
          //           ),
          //         ],
          //       ),
          //
          //       24.height,
          //       const ProofPackageCard(),
          //       24.height,
          //       SectionHeader(title: 'Send To'),
          //       24.height,
          //       InputLabel('Recipient Email', color: ColorManager.subtextColor),
          //       SizedBox(height: 12),
          //       CustomTextFieldWidget(
          //         hintText: "Recipient Email",
          //         controller: _recipientController,
          //       ),
          //       SizedBox(height: 16),
          //
          //       InputLabel(
          //         'CC Broker (Optional)',
          //         color: ColorManager.subtextColor,
          //       ),
          //       SizedBox(height: 12),
          //       CustomTextFieldWidget(
          //         hintText: "CC Broker",
          //         controller: _ccController,
          //       ),
          //
          //       SendMethodToggle(
          //         selectedIndex: _sendMethodIndex,
          //         onChanged: (index) =>
          //             setState(() => _sendMethodIndex = index),
          //       ),
          //
          //       16.height,
          //       GlobalButton(label: 'Claim Now', onPressed: () {}),
          //       16.height,
          //       GlobalButton.secondary(label: 'Export PDF', onPressed: () {}),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
