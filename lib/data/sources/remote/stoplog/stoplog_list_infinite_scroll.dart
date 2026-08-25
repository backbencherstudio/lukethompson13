import 'dart:async';

import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:riverpod/riverpod.dart';

const _limit = 5;

class StopLogPaginationState {
  final List<StopLogListItem> stops;
  final String? nextCursor;
  final bool hasMore;
  final bool isLoadingMore;
  final String search;
  final StopLogStatus status;

  const StopLogPaginationState({
    required this.stops,
    this.nextCursor,
    required this.hasMore,
    required this.isLoadingMore,
    required this.search,
    required this.status,
  });

  StopLogPaginationState copyWith({
    List<StopLogListItem>? stops,
    String? Function()? nextCursor,
    bool? hasMore,
    bool? isLoadingMore,
    String? search,
    StopLogStatus? status,
  }) {
    return StopLogPaginationState(
      stops: stops ?? this.stops,
      nextCursor: nextCursor != null ? nextCursor() : this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      search: search ?? this.search,
      status: status ?? this.status,
    );
  }
}

class StopLogPaginationNotifier extends AsyncNotifier<StopLogPaginationState> {
  Timer? _debounceTimer;

  @override
  Future<StopLogPaginationState> build() async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    return _fetchStops(cursor: null, search: '', status: StopLogStatus.all);
  }

  Future<StopLogPaginationState> _fetchStops({
    required String? cursor,
    required String search,
    required StopLogStatus status,
  }) async {
    final api = ref.read(stoplogApiProvider);

    final response = await api.getStopLogList(
      cursor,
      _limit,
      search.isEmpty ? null : search,
      status == StopLogStatus.all ? null : status,
    );

    final stops = response.data ?? [];
    final nextCursor = response.metaData?.nextCursor;

    return StopLogPaginationState(
      stops: stops,
      nextCursor: nextCursor,
      hasMore: nextCursor != null,
      isLoadingMore: false,
      search: search,
      status: status,
    );
  }

  Future<void> loadNextPage() async {
    final current = state.value;

    if (current == null || current.isLoadingMore || !current.hasMore) {
      return;
    }

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final api = ref.read(stoplogApiProvider);

      final response = await api.getStopLogList(
        current.nextCursor,
        _limit,
        current.search.isEmpty ? null : current.search,
        current.status == StopLogStatus.all ? null : current.status,
      );

      final newStops = response.data ?? [];
      final nextCursor = response.metaData?.nextCursor;

      state = AsyncData(
        current.copyWith(
          stops: [...current.stops, ...newStops],
          nextCursor: () => nextCursor,
          hasMore: nextCursor != null,
          isLoadingMore: false,
        ),
      );
    } catch (_, __) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  void updateSearch(String search) {
    final current = state.value;

    if (current == null || current.search == search) {
      return;
    }

    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = const AsyncLoading();

      state = await AsyncValue.guard(
        () => _fetchStops(cursor: null, search: search, status: current.status),
      );
    });
  }

  Future<void> updateStatus(StopLogStatus status) async {
    final current = state.value;

    if (current == null || current.status == status) {
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _fetchStops(cursor: null, search: current.search, status: status),
    );
  }
}

final stopLogPaginationProvider =
    AsyncNotifierProvider.autoDispose<
      StopLogPaginationNotifier,
      StopLogPaginationState
    >(StopLogPaginationNotifier.new);
