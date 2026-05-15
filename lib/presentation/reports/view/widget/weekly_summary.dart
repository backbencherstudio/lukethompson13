import 'package:flutter/material.dart';

class WeeklySummaryWidget extends StatelessWidget {
  final String? title;
  final String? value;
  final String? subtitle;
  final IconData? icon;
  
 
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? valueColor;
  final Color? subtitleColor;
  final Color? iconColor;
  final Color? borderColor;

  const WeeklySummaryWidget({
    super.key,
    this.title,
    this.value,
    this.subtitle,
    this.icon,
    this.backgroundColor,
    this.titleColor,
    this.valueColor,
    this.subtitleColor,
    this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        
        color: backgroundColor ?? const Color(0xFF20252D),
        borderRadius: BorderRadius.circular(16),
        
        border: borderColor != null 
            ? Border.all(color: borderColor!, width: 1) 
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor ?? Colors.redAccent, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                title ?? "",
                style: TextStyle(
                  color: titleColor ?? Colors.white, 
                  fontSize: 14, 
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value ?? "",
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle ?? "",
            style: TextStyle(
              color: subtitleColor ?? Colors.grey, 
              fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}