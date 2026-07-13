import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/presentation/todo/data/todo.api.dart';
import 'package:lukethompson/presentation/todo/data/todo.model.dart';
import 'package:lukethompson/presentation/todo/data/todo_repository.dart';

class GetTodosNotifier extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    final api = ref.read(todoRepositoryProvider);
    return api.getTodos();
  }
}

class CreateTodoNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> call(String title) async {
    if (title.trim().isEmpty) {
      state = AsyncError('Title cannot be empty', StackTrace.current);
      return;
    }

    state = const AsyncLoading();

    try {
      final api = ref.read(todoRepositoryProvider);
      await api.createTodo({"title": title, "completed": false, "userId": 1});
      state = const AsyncData(null);
      ref.invalidate(getTodosProvider);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

class UpdateTodoNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> call(int id, Map<String, dynamic> body) async {
    state = const AsyncLoading();

    try {
      final api = ref.read(todoRepositoryProvider);
      await api.updateTodo(id, body);
      state = const AsyncData(null);
      ref.invalidate(getTodosProvider);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

class DeleteTodoNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> call(int id) async {
    state = const AsyncLoading();

    try {
      final api = ref.read(todoRepositoryProvider);
      await api.deleteTodo(id);
      state = const AsyncData(null);
      ref.invalidate(getTodosProvider);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final getTodosProvider = AsyncNotifierProvider<GetTodosNotifier, List<Todo>>(
  GetTodosNotifier.new,
);

final createTodoProvider = AsyncNotifierProvider<CreateTodoNotifier, void>(
  CreateTodoNotifier.new,
);

final updateTodoProvider = AsyncNotifierProvider<UpdateTodoNotifier, void>(
  UpdateTodoNotifier.new,
);

final deleteTodoProvider = AsyncNotifierProvider<DeleteTodoNotifier, void>(
  DeleteTodoNotifier.new,
);
