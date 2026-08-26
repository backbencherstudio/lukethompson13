import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';

class CurrentStopLogState {
  const CurrentStopLogState({this.choosenShipper, this.choosenBroker});
  final ShipperSearchFacilityItem? choosenShipper;
  final ShipperSearchFacilityItem? choosenBroker;
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

  void selectBroker(ShipperSearchFacilityItem item) {
    state = CurrentStopLogState(
      choosenShipper: state?.choosenShipper,
      choosenBroker: item,
    );
  }

  void clear() => state = null;
}

final selectedFacilityProvider =
    NotifierProvider.autoDispose<
      CurrentStopLogStateNotifier,
      CurrentStopLogState?
    >(CurrentStopLogStateNotifier.new);
