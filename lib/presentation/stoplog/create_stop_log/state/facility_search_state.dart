import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';

class SelectedFacilityNotifier extends Notifier<ShipperSearchFacilityItem?> {
  @override
  ShipperSearchFacilityItem? build() => null;

  void select(ShipperSearchFacilityItem item) => state = item;
  void updateName(String name) => state = ShipperSearchFacilityItem(name: name);
  void clear() => state = null;
}

final selectedFacilityProvider =
    NotifierProvider<SelectedFacilityNotifier, ShipperSearchFacilityItem?>(
      SelectedFacilityNotifier.new,
    );
