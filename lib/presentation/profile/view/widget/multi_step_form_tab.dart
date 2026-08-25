import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';

class MultiStepFormTab extends StatelessWidget {
  const MultiStepFormTab({
    super.key,
    required this.pageController,
    required this.steps,
  }) : totalStep = steps.length;

  final PageController pageController;
  final List<String> steps;
  final int totalStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          final page = pageController.hasClients
              ? (pageController.page ?? 0).round()
              : 0;

          final currentStep = page + 1;

          final currentTitle = (currentStep > 0 && currentStep <= steps.length)
              ? steps[page]
              : 'STEP $currentStep';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currentTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorManager.primaryButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'STEP $currentStep OF $totalStep',
                    style: TextStyle(
                      color: ColorManager.subtextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              6.height,
              LinearProgressIndicator(
                value: currentStep / totalStep,
                color: ColorManager.primaryButton,
                backgroundColor: ColorManager.secondary,
              ),
              14.height,
            ],
          );
        },
      ),
    );
  }
}

