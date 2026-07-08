import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/gen/assets.gen.dart';

class ProofPackageList extends StatelessWidget {
  final List<String> fineNames;
  final void Function(int index)? onRemoveItem;

  const ProofPackageList({
    super.key,
    required this.fineNames,
    this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        fineNames.length,
        (index) => _buildItem(fineNames[index], onRemoveItem, index),
      ),
    );
  }

  Widget _buildItem(
    String fileName,
    void Function(int index)? onRemoveItem,
    int index,
  ) {
    return AppCard(
      backgroundColor: ColorManager.surfaceBacground,
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Stack(
        children: [
          Positioned(top: 1, child: SvgPicture.asset(Assets.icons.linkAlt)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              24.width,
              Expanded(
                child: Text(
                  fileName,
                  style: getSubtextStyle(color: const Color(0xff00A3FF)),
                ),
              ),
              if (onRemoveItem != null)
                GestureDetector(
                  onTap: () => onRemoveItem(index),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, right: 4),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: ColorManager.subtextColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
