import 'package:flutter/material.dart';

import 'custom_button.dart';

class UnlockDialog extends StatelessWidget {
  const UnlockDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),

          Text(
            "Unlock Your Full\nDriver Log",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Get unlimited stop logging, instant PDF exports, advanced detention analytics, and an ad.free experience",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff8DA2B8)),
          ),

          const SizedBox(height: 20),

          CustomButton(title: "Subscribe Now"),
          SizedBox(height: 10,),
           Text(
            "Continue with Free Trial",

            textAlign: TextAlign.center,
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                color: Color(0xff33D17A)),
          ),
        ],
      ),
    );
  }
}
