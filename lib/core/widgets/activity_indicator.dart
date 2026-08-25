import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({super.key, this.radius = 12});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(color: Colors.white, radius: radius);
  }
}
