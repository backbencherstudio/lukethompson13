import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/big_stat_card.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/log_screen/view/widget/breakdown_card.dart';
import 'package:lukethompson/presentation/log_screen/view/widget/proof_package_card.dart';
import 'package:lukethompson/presentation/log_screen/view/widget/send_method_toggle.dart';

class LogStopResultScreen extends StatefulWidget {
  const LogStopResultScreen({super.key});

  @override
  State<LogStopResultScreen> createState() => _LogStopResultScreenState();
}

class _LogStopResultScreenState extends State<LogStopResultScreen> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: 'Walmart DC',
        subTitle: "3831 Cedar Lane, Somerville, MA 02143",
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                24.height,
                BigStatCard.success(
                  title: 'Detention Owed',
                  value: '\$225',
                  subtitle: '3h billable • \$50/hr',
                ),
                SizedBox(height: 16),
                BigStatCard.destructive(
                  title: 'Revenue Lost',
                  value: '\$300',
                  subtitle: 'Total 5h • \$50/hr',
                ),
                SizedBox(height: 16),
                const BreakdownCard(
                  items: [
                    BreakdownItem(label: 'Arrival - Departure', value: '5h'),
                    BreakdownItem(label: 'Free Wait Time', value: '2h'),
                    BreakdownItem(
                      label: 'Billable Time',
                      value: '3h',
                      valueColor: ColorManager.primaryButton,
                    ),
                  ],
                ),

                24.height,
                const ProofPackageCard(),
                24.height,
                SectionHeader(title: 'Send To'),
                24.height,
                InputLabel('Recipient Email', color: ColorManager.subtextColor),
                SizedBox(height: 12),
                CustomTextFieldWidget(
                  hintText: "Recipient Email",
                  controller: _recipientController,
                ),
                SizedBox(height: 16),

                InputLabel(
                  'CC Broker (Optional)',
                  color: ColorManager.subtextColor,
                ),
                SizedBox(height: 12),
                CustomTextFieldWidget(
                  hintText: "CC Broker",
                  controller: _ccController,
                ),

                SendMethodToggle(
                  selectedIndex: _sendMethodIndex,
                  onChanged: (index) =>
                      setState(() => _sendMethodIndex = index),
                ),

                16.height,
                GlobalButton(label: 'Claim Now', onPressed: () {}),
                16.height,
                GlobalButton.secondary(label: 'Export PDF', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
