import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';

class CurrentBrokerInfo {
  const CurrentBrokerInfo({
    required this.id,
    required this.name,
    required this.email,
  });
  final String id;
  final String name;
  final String email;
}

class CurrentStopLogState {
  const CurrentStopLogState({this.choosenShipper, this.choosenBroker});
  final ShipperSearchFacilityItem? choosenShipper;
  final CurrentBrokerInfo? choosenBroker;
}

class CurrentStopLogStateNotifier extends Notifier<CurrentStopLogState?> {
  @override
  CurrentStopLogState? build() => null;

  void selectFacility(ShipperSearchFacilityItem item) {
    state = CurrentStopLogState(
      choosenShipper: item,
      choosenBroker: state?.choosenBroker,
    );
  }

  void selectBroker({
    required String id,
    required String name,
    required String email,
  }) {
    state = CurrentStopLogState(
      choosenShipper: state?.choosenShipper,
      choosenBroker: CurrentBrokerInfo(id: id, name: name, email: email),
    );
  }

  void clear() => state = null;
}

final selectedFacilityProvider =
    NotifierProvider.autoDispose<
      CurrentStopLogStateNotifier,
      CurrentStopLogState?
    >(CurrentStopLogStateNotifier.new);
