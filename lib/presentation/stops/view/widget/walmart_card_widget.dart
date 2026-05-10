import 'package:flutter/material.dart';

class WalmartCard extends StatelessWidget {
  final String? title;
  final String? dateTime;
  final String? amount;
  final String? statusText;
  final String? buttonText;
  final IconData? icon;
  final VoidCallback? onButtonPressed;

  const WalmartCard({
    super.key,
    this.title = "Walmart DC Shelbyville. TN",
    this.dateTime = "Oct 24, 2026 • 08:30 AM",
    this.amount = "\$135",
    this.statusText = "Paid",
    this.buttonText = "Rate Shipper",
    this.icon = Icons.domain,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D23), 
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
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.orangeAccent.shade100,
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateTime!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
             
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText!,
                  style: const TextStyle(
                    color: Color(0xFF34D399),
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
                style: const TextStyle(
                  color: Color(0xFF34D399),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              GestureDetector(
                onTap: onButtonPressed,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    buttonText!,
                    style: const TextStyle(
                      color: Colors.orangeAccent,
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
