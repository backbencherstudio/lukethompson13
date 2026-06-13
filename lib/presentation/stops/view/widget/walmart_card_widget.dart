import 'package:flutter/material.dart';
// not in use

class WalmartCard extends StatelessWidget {
  final String? title;
  final String? dateTime;
  final String? amount;
  final String? statusText;
  final String? buttonText;
  final IconData? icon;
  final VoidCallback? onButtonPressed;

  
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? amountColor;
  final Color? statusTextColor;
  final Color? statusBgColor;
  final Color? buttonColor;
  final Color? iconColor;
  final Color? iconBgColor;

  const WalmartCard({
    super.key,
    this.title = "Walmart DC Shelbyville. TN",
    this.dateTime = "Oct 24, 2026 • 08:30 AM",
    this.amount = "\$135",
    this.statusText = "Paid",
    this.buttonText = "Rate Shipper",
    this.icon = Icons.domain,
    this.onButtonPressed,
  
    this.backgroundColor = const Color(0xFF1A1D23),
    this.titleColor = Colors.white,
    this.subtitleColor = const Color(0x80FFFFFF),
    this.amountColor = const Color(0xFF34D399),
    this.statusTextColor = const Color(0xFF34D399),
    this.statusBgColor = const Color(0x1A4CAF50), 
    this.buttonColor = Colors.orangeAccent,
    this.iconColor = const Color(0xFFFFE0B2), 
    this.iconBgColor = const Color(0x0DFFFFFF), 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),

             
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateTime!,
                      style: TextStyle(
                        color: subtitleColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

       
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText!,
                  style: TextStyle(
                    color: statusTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount!,
                style: TextStyle(
                  color: amountColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onButtonPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: buttonColor!.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    buttonText!,
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
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
