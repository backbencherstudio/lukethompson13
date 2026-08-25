import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/platform/gps_service.dart';

class LocationSearchNotifier extends AsyncNotifier<List<LocationDataModel>> {
  final _gpsService = GpsService();

  @override
  Future<List<LocationDataModel>> build() async => const [];

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();

    try {
      final results = await _gpsService.performSearch(query);
      state = AsyncData(results);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final locationSearchProvider =
    AsyncNotifierProvider<LocationSearchNotifier, List<LocationDataModel>>(
      LocationSearchNotifier.new,
    );

