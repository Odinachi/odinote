import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odinote/service/app_service.dart';

import '../../models/task.dart';

part 'home_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(InitialState());
  final TaskService _taskService = TaskService.instance;

  void fetchAllTask() async {
    emit(OnLoading());
    var p = await _taskService.getAllTask();
    if (p != null) {
      if (p.isNotEmpty) {
        List<Task> _com = [];
        List<Task> _unCom = [];
        for (var element in p) {
          if (element.done == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnSuccess(completedTasks: _com, unCompletedTasks: _unCom));
      } else {
        emit(OnEmpty());
      }
    } else {
      emit(OnFailure(error: ""));
    }
  }

  void updateTask(Task task) async {
    // emit(OnUpdateLoading());

    var p = await _taskService.update(task);
    if (p != null) {
      var p = await _taskService.getAllTask();
      if (p != null) {
        if (p.isNotEmpty) {
          List<Task> _com = [];
          List<Task> _unCom = [];
          for (var element in p) {
            if (element.done == true) {
              _com.add(element);
            } else {
              _unCom.add(element);
            }
          }
          emit(OnSuccess(completedTasks: _com, unCompletedTasks: _unCom));
        } else {
          emit(OnEmpty());
        }
      }
    } else {
      emit(OnUpdateFailure(error: ""));
    }
  }

  void updateList() async {
    var p = await _taskService.getAllTask();
    if (p != null) {
      if (p.isNotEmpty) {
        List<Task> _com = [];
        List<Task> _unCom = [];
        for (var element in p) {
          if (element.done == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnSuccess(completedTasks: _com, unCompletedTasks: _unCom));
      } else {
        emit(OnEmpty());
      }
    } else {
      emit(OnFailure(error: ""));
    }
  }
}
