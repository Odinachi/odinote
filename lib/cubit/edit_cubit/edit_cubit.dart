import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odinote/models/task.dart';
import 'package:odinote/service/app_service.dart';

part 'edit_state.dart';

class EditScreenCubit extends Cubit<EditScreenState> {
  late final TaskService taskService;

  EditScreenCubit(TaskService service) : super(InitialEditState()) {
    taskService = service;
  }

  void createTask(
      {TaskService? taskService, required String title, String? desc}) async {
    emit(OnEditLoading());
    Task _t = Task(title: title, desc: desc, done: false);
    await this.taskService.insert(_t);
    emit(
      OnEditSuccess(),
    );
  }

  void updateTask(
      {TaskService? taskService,
      required int id,
      required String title,
      String? desc,
      required bool done}) async {
    emit(
      OnEditLoading(),
    );
    Task _t = Task(title: title, desc: desc, done: done, id: id);
    var p = await this.taskService.update(_t);
    if (p != null) {
      emit(
        OnEditUpdateSuccess(),
      );
    } else {
      emit(
        OnEditUpdateFailure(error: ""),
      );
    }
  }

  void deleteTask({TaskService? taskService, required int taskId}) async {
    emit(
      OnEditLoading(),
    );
    var p = await this.taskService.delete(taskId);
    if (p != null) {
      emit(
        OnEditDeleteSuccess(),
      );
    } else {
      emit(
        OnEditDeleteFailure(error: ""),
      );
    }
  }
}
