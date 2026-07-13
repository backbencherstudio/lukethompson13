import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';

class MyClaimDetailScreen extends ConsumerStatefulWidget {
  const MyClaimDetailScreen({super.key});

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
        subTitle: "Amazon Distribution DC4",
      ),
      body: AppGradientBackground(
        child: SafeArea(child: Column(children: [Text("claim details")])),
      ),
    );
  }
}
