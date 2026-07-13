import 'package:dio/dio.dart';
import 'package:lukethompson/presentation/todo/data/todo.model.dart';
import 'package:retrofit/retrofit.dart';

part 'todo.api.g.dart';

@RestApi()
abstract class TodosApi {
  factory TodosApi(Dio dio) = _TodosApi;

  @GET("/todos")
  Future<List<Todo>> getTodos();

  @POST("/todos")
  Future<Todo> createTodo(@Body() Map<String, dynamic> body);

  @PUT("/todos/{id}")
  Future<void> updateTodo(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("/todos/{id}")
  Future<void> deleteTodo(@Path("id") int id);
}
