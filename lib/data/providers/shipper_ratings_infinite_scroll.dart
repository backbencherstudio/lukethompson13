import 'package:riverpod/riverpod.dart';

import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/sources/remote/shipper.api.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_card.dart';

const _limit = 5;

class ShipperRatingsPaginationState {
  final List<ShipperRatingItem> ratings;
  final String? nextCursor;
  final bool hasMore;
  final bool isLoadingMore;
  final PayerCategory? status;

  const ShipperRatingsPaginationState({
    required this.ratings,
    this.nextCursor,
    required this.hasMore,
    required this.isLoadingMore,
    this.status,
  });

  ShipperRatingsPaginationState copyWith({
    List<ShipperRatingItem>? ratings,
    String? Function()? nextCursor,
    bool? hasMore,
    bool? isLoadingMore,
    PayerCategory? Function()? status,
  }) {
    return ShipperRatingsPaginationState(
      ratings: ratings ?? this.ratings,
      nextCursor: nextCursor != null ? nextCursor() : this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      status: status != null ? status() : this.status,
    );
  }
}

class ShipperRatingsPaginationNotifier
    extends AsyncNotifier<ShipperRatingsPaginationState> {
  @override
  Future<ShipperRatingsPaginationState> build() async {
    return _fetchRatings(cursor: null);
  }

  Future<ShipperRatingsPaginationState> _fetchRatings({
    required String? cursor,
    PayerCategory? status,
  }) async {
    final api = ref.read(shipperApiProvider);

    final response = await api.getAllShippersAndFacilitiesWithRatings(
      cursor,
      _limit,
      status?.value,
    );

    final ratings = response.data ?? [];
    final nextCursor = response.metaData?.nextCursor;

    return ShipperRatingsPaginationState(
      ratings: ratings,
      nextCursor: nextCursor,
      hasMore: nextCursor != null,
      isLoadingMore: false,
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
      final api = ref.read(shipperApiProvider);

      final response = await api.getAllShippersAndFacilitiesWithRatings(
        current.nextCursor,
        _limit,
        current.status?.value,
      );

      final newRatings = response.data ?? [];
      final nextCursor = response.metaData?.nextCursor;

      state = AsyncData(
        current.copyWith(
          ratings: [...current.ratings, ...newRatings],
          nextCursor: () => nextCursor,
          hasMore: nextCursor != null,
          isLoadingMore: false,
        ),
      );
    } catch (_, __) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> updateStatus(PayerCategory? status) async {
    final current = state.value;

    if (current == null || current.status == status) {
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _fetchRatings(cursor: null, status: status),
    );
  }
}

final shipperRatingsPaginationProvider =
    AsyncNotifierProvider.autoDispose<
      ShipperRatingsPaginationNotifier,
      ShipperRatingsPaginationState
    >(ShipperRatingsPaginationNotifier.new);
