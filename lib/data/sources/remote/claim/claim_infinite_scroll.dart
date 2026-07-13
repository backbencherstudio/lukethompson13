import 'dart:async';

import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:riverpod/riverpod.dart';

const _limit = 5;

class ClaimPaginationState {
  final List<ClaimItem> claims;
  final String? nextCursor;
  final bool hasMore;
  final bool isLoadingMore;
  final ClaimListMetaData? metaData;
  final String search;
  final ClaimStatus? status;

  const ClaimPaginationState({
    required this.claims,
    this.nextCursor,
    required this.hasMore,
    required this.isLoadingMore,
    this.metaData,
    required this.search,
    this.status,
  });

  ClaimPaginationState copyWith({
    List<ClaimItem>? claims,
    String? Function()? nextCursor,
    bool? hasMore,
    bool? isLoadingMore,
    ClaimListMetaData? metaData,
    String? search,
    ClaimStatus? Function()? status,
  }) {
    return ClaimPaginationState(
      claims: claims ?? this.claims,
      nextCursor: nextCursor != null ? nextCursor() : this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      metaData: metaData ?? this.metaData,
      search: search ?? this.search,
      status: status != null ? status() : this.status,
    );
  }
}

class ClaimPaginationNotifier extends AsyncNotifier<ClaimPaginationState> {
  Timer? _debounceTimer;

  @override
  Future<ClaimPaginationState> build() async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    return _fetchClaims(cursor: null, search: '', status: null);
  }

  Future<ClaimPaginationState> _fetchClaims({
    required String? cursor,
    required String search,
    required ClaimStatus? status,
  }) async {
    final api = ref.read(claimApiProvider);

    final response = await api.getMyClaims(
      cursor,
      _limit,
      search.isEmpty ? null : search,
      status?.value,
    );

    final claims = response.data;
    final nextCursor = response.metaData.nextCursor;

    return ClaimPaginationState(
      claims: claims,
      nextCursor: nextCursor,
      hasMore: nextCursor != null,
      isLoadingMore: false,
      metaData: response.metaData,
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
      final api = ref.read(claimApiProvider);

      final response = await api.getMyClaims(
        current.nextCursor,
        _limit,
        current.search.isEmpty ? null : current.search,
        current.status?.value,
      );

      final newClaims = response.data;
      final nextCursor = response.metaData.nextCursor;

      state = AsyncData(
        current.copyWith(
          claims: [...current.claims, ...newClaims],
          nextCursor: () => nextCursor,
          hasMore: nextCursor != null,
          isLoadingMore: false,
          metaData: response.metaData,
        ),
      );
    } catch (_) {
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
        () => _fetchClaims(
          cursor: null,
          search: search,
          status: current.status,
        ),
      );
    });
  }

  Future<void> updateStatus(ClaimStatus? status) async {
    final current = state.value;

    if (current == null || current.status == status) {
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _fetchClaims(
        cursor: null,
        search: current.search,
        status: status,
      ),
    );
  }
}

final claimPaginationProvider =
    AsyncNotifierProvider.autoDispose<
      ClaimPaginationNotifier,
      ClaimPaginationState
    >(ClaimPaginationNotifier.new);
