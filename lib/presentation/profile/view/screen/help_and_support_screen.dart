import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/expansion_tile_radio_list_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/section_header.dart';

class FAQItem {
  final int id;
  final String title;
  final String content;

  FAQItem({required this.id, required this.title, required this.content});
}

final _instructions = [
  FAQItem(
    id: 1,
    title: 'What is detention pay for truck drivers?',
    content:
        "Detention pay is money you're owed for time spent waiting at a shipper or receiver beyond a set free-time window, usually two hours. It is billed to whoever is on your rate confirmation — on a brokered load, that is the broker, not the facility that made you wait. Most contracts pay detention at an hourly rate — commonly \$50 to \$75 per hour — once free time runs out. GetDockPay tracks that time automatically so you can prove and claim what you're owed.",
  ),
  FAQItem(
    id: 2,
    title: 'When does detention time start?',
    content:
        'Detention typically starts after a standard two-hour free-time window at a shipper or receiver, though grace periods range from one to four hours depending on the facility and your rate confirmation. GetDockPay timestamps your arrival and dock time so the exact moment detention begins is documented.',
  ),
  FAQItem(
    id: 3,
    title: 'How much detention pay am I owed?',
    content:
        "Detention rates aren't standardized. They typically run \$50 to \$75 per hour and can reach \$125 or more per hour for specialized or hazmat loads, depending on your contract. GetDockPay calculates the exact amount based on your free-time window, your hourly rate, and the detention time it recorded.",
  ),
  FAQItem(
    id: 4,
    title: 'How much money do drivers lose to detention?',
    content:
        'The U.S. Department of Transportation estimated detention cuts truck driver pay by roughly \$1.1 to \$1.3 billion a year — an average of about \$1,281 to \$1,534 per driver annually. Many owner-operators lose \$200 to \$500 every single week in unpaid detention. GetDockPay is built to help you recover that money.',
  ),
  FAQItem(
    id: 5,
    title: 'Who actually pays detention — the shipper or the broker?',
    content:
        'On a brokered load, the broker pays. Your contract is the rate confirmation, and it is between you and the broker — the shipper or receiver that made you wait has no agreement with you. The broker may recover the cost from their customer afterward, but that is their business, not yours. If you are leased to a carrier, the carrier pays you; if you haul under a direct shipper contract, the shipper pays. The rule that covers every case: whoever is on the rate confirmation is who owes you. That is also why getting detention terms in writing before you roll matters so much.',
  ),
  FAQItem(
    id: 6,
    title: 'What is a Dock Score and a Broker Pay Score?',
    content:
        "They are two community scores built from real drivers' stops and claims. The Dock Score tells you whether you will sit at a facility — average wait time and how often it runs past your free-time window. The Broker Pay Score tells you whether you will actually get paid — the percentage of detention claims that broker pays, their average days to pay, and their denial rate. The dock costs you time; the broker owes you money, so GetDockPay scores them separately.",
  ),
  FAQItem(
    id: 7,
    title: 'Who is GetDockPay for?',
    content:
        'GetDockPay is built for owner-operators and small-fleet truck drivers who wait at docks and want a fast, reliable way to track detention time and file claims that actually get paid.',
  ),
];

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Help & Support'),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: .symmetric(horizontal: AppPadding.screenPadding),
              child: Column(
                children: [
                  24.height,
                  SectionHeader(
                    textAlign: .center,
                    title: 'Detention pay\nquestions, answered',
                    subtitle:
                        'Straight answers to what truck drivers ask about\ndetention time and getting paid.',
                  ),

                  24.height,
                  ExpansionTileRadioListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    items: _instructions,
                    titleBuilder: (context, item, index) {
                      return Text(
                        "${index + 1}. ${item.title}",
                        style: TextStyle(fontSize: 14.sp),
                      );
                    },
                    childrenBuilder: (context, item, index) {
                      return Text(
                        item.content,
                        style: TextStyle(
                          fontSize: 12.sp,
                          height: 1.6,
                          color: ColorManager.subtextColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
