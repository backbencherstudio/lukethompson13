import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MutationStatus { idle, pending, success, error }

class MutationState<T> {
  final MutationStatus status;
  final T? data;
  final Object? error;
  final StackTrace? stackTrace;

  const MutationState({
    this.status = MutationStatus.idle,
    this.data,
    this.error,
    this.stackTrace,
  });

  bool get isIdle => status == MutationStatus.idle;
  bool get isPending => status == MutationStatus.pending;
  bool get isSuccess => status == MutationStatus.success;
  bool get isError => status == MutationStatus.error;

  MutationState<T> copyWith({
    MutationStatus? status,
    T? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    return MutationState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  factory MutationState.idle() => const MutationState();

  factory MutationState.pending() =>
      const MutationState(status: MutationStatus.pending);

  factory MutationState.success(T data) =>
      MutationState(status: MutationStatus.success, data: data);

  factory MutationState.error(Object error, StackTrace stack) => MutationState(
    status: MutationStatus.error,
    error: error,
    stackTrace: stack,
  );
}

abstract class MutationNotifier<T> extends Notifier<MutationState<T>> {
  @override
  MutationState<T> build() => MutationState.idle();

  Future<T> mutate(Future<T> Function() action) async {
    state = MutationState.pending();

    try {
      final result = await action();

      state = MutationState.success(result);

      return result;
    } catch (e, st) {
      state = MutationState.error(e, st);
      rethrow;
    }
  }

  void reset() {
    state = MutationState.idle();
  }
}

NotifierProvider<TNotifier, MutationState<TData>> mutationProvider<
  TNotifier extends MutationNotifier<TData>,
  TData
>(TNotifier Function() create) {
  return NotifierProvider<TNotifier, MutationState<TData>>(create);
}
