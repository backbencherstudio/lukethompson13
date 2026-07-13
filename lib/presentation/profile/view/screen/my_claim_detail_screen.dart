import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';

class MyClaimDetailScreenArg {
  final String id;
  final String facilityName;
  const MyClaimDetailScreenArg({required this.id, required this.facilityName});
}

class MyClaimDetailScreen extends ConsumerStatefulWidget {
  const MyClaimDetailScreen({super.key, this.arguments});
  final MyClaimDetailScreenArg? arguments;

  @override
  ConsumerState<MyClaimDetailScreen> createState() => _MyClaimScreenState();
}

class _MyClaimScreenState extends ConsumerState<MyClaimDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: 'Claim Detail',
        subTitle: widget.arguments?.facilityName,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: Center(
            child: Text(
              'Claim details (WIP)',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
