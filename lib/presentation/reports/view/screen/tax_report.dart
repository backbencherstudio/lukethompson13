import 'package:flutter/material.dart';

import '../widget/custome_date_selector.dart';

class TaxReport extends StatelessWidget {
  const TaxReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
    CustomDateSelector (),
    ]);
  }
}
