import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odinote/models/task.dart';
import 'package:odinote/service/app_service.dart';

part 'edit_state.dart';

class EditScreenCubit extends Cubit<EditScreenState> {
  EditScreenCubit() : super(InitialEditState());
  final TaskService _taskService = TaskService.instance;

  void createTask({required String title, String? desc}) async {
    emit(OnEditLoading());
    Task _t = Task(title: title, desc: desc, done: false);
    await _taskService.insert(_t);
    emit(
      OnEditSuccess(),
    );
  }

  void updateTask(
      {required int id,
      required String title,
      String? desc,
      required bool done}) async {
    emit(
      OnEditLoading(),
    );
    Task _t = Task(title: title, desc: desc, done: done, id: id);
    var p = await _taskService.update(_t);
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

  void deleteTask(int taskId) async {
    emit(
      OnEditLoading(),
    );
    var p = await _taskService.delete(taskId);
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
