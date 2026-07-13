import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';

class CustomJobCard extends StatelessWidget {
  final String? title;
  final String? dateTime;
  final String? amount;
  final Widget? statusWidget;
  final Color? amountColor;
  final Color? statusTextColor;
  final Color? statusBgColor;
  final Color? borderColor;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const CustomJobCard({
    super.key,
    this.title,
    this.dateTime,
    this.amount,
    this.statusWidget,
    this.amountColor,
    this.statusTextColor,
    this.statusBgColor,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon ?? Icons.business,
                    color: iconColor ?? Colors.blueAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateTime ?? "",
                        style: TextStyle(color: Colors.grey[400], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount ?? "",
                  style: TextStyle(
                    color: amountColor ?? Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ?statusWidget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
