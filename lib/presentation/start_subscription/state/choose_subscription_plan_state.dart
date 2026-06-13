import 'package:flutter_riverpod/flutter_riverpod.dart';

const planIdMonthly = 'monthly';
const planIdYearly = 'yearly';
const paymentMethodCard = 'card';
const paymentMethodApple = 'apple';

const _monthlyFeatures = [
  'Unlimited stop logging',
  'Invoice Export & Send',
  'Advanced analytics',
  'Debt Collection & Legal Services',
  'Ad-free experience',
];

const _yearlyFeatures = [
  'Unlimited stop logging',
  'Invoice Export & Send',
  'Advanced analytics',
  'Debt Collection & Legal Services',
  'Ad-free experience',
];

List<String> getFeaturedPlanItems(String selectedPlanId) {
  return selectedPlanId == planIdMonthly ? _monthlyFeatures : _yearlyFeatures;
}

class SubscriptionPlanState {
  const SubscriptionPlanState({
    this.selectedPlanId = planIdMonthly,
    this.paymentMethod = '',
  });

  final String selectedPlanId;
  final String paymentMethod;

  SubscriptionPlanState copyWith({
    String? selectedPlanId,
    String? paymentMethod,
  }) {
    return SubscriptionPlanState(
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
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

  void selectPaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method);
  }
}
