import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/gen/assets.gen.dart';

class ProofPackageCard extends StatelessWidget {
  final String title;

  const ProofPackageCard({super.key, this.title = 'PROOF PACKAGE'});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: getSubtextStyle()),
        SizedBox(height: 12),
        _buildItem('00140_4437_0009964.jpg'),
        SizedBox(height: 8),
        _buildItem('00140_4437_0009964.pdf'),
      ],
    );
  }

  Widget _buildItem(String fileName) {
    return AppCard(
      backgroundColor: const Color(0xff111926),
      borderRadius: 8,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          SvgPicture.asset(Assets.icons.linkAlt),
          8.width,
          Text(
            fileName,
            style: getSubtextStyle(color: const Color(0xff00A3FF)),
          ),
        ],
      ),
    );
  }
}
