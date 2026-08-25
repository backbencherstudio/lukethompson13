import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/providers.dart';
import 'package:lukethompson/presentation/todo/data/todo.api.dart';
import 'package:lukethompson/presentation/todo/data/todo.model.dart';

class TodoRepository {
  final TodosApi _todosApi;
  TodoRepository({required TodosApi todosApi}) : _todosApi = todosApi;

  Future<List<Todo>> getTodos() => _todosApi.getTodos();

  Future<Todo> createTodo(Map<String, dynamic> body) =>
      _todosApi.createTodo(body);

  Future<void> updateTodo(int id, Map<String, dynamic> body) =>
      _todosApi.updateTodo(id, body);

  Future<void> deleteTodo(int id) => _todosApi.deleteTodo(id);
}

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  return TodoRepository(todosApi: TodosApi(dio));
});
