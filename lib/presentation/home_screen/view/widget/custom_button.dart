import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  const CustomButton({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color:Color(0xff33D17A)
      ),child: Center(
      child: Text(title,style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600
      ),),
    ),
    );
  }
}
