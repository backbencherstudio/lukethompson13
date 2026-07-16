import 'package:flutter_riverpod/flutter_riverpod.dart';

class FacilitySearchTextNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setText(String value) => state = value;

  void clear() => state = '';
}

final facilitySearchTextProvider =
    NotifierProvider<FacilitySearchTextNotifier, String>(
      FacilitySearchTextNotifier.new,
    );
