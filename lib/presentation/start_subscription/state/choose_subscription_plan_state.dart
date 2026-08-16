import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/resource/constants/config.dart';

class SubscriptionPlanState {
  const SubscriptionPlanState({
    this.selectedPlanId = AppConfig.revenueCatMonthlyPackageId,
  });

  final String selectedPlanId;

  SubscriptionPlanState copyWith({String? selectedPlanId}) {
    return SubscriptionPlanState(
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
    );
  }
}

final selectedPlanIdProvider =
    NotifierProvider<ChooseSubscriptionPlanNotifier, SubscriptionPlanState>(
      ChooseSubscriptionPlanNotifier.new,
    );

class ChooseSubscriptionPlanNotifier extends Notifier<SubscriptionPlanState> {
  @override
  SubscriptionPlanState build() => const SubscriptionPlanState();

  void selectPlan(String planId) {
    state = state.copyWith(selectedPlanId: planId);
  }
}
