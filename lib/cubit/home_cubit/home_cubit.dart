import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odinote/models/new_task_response.dart';
import 'package:odinote/models/update_request_model.dart';
import 'package:odinote/service/mutation_strings.dart';
import 'package:odinote/service/service.dart';

part 'home_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(InitialState());
  AppService _service = AppService();

  void fetchAllTask() async {
    emit(OnLoading());
    var _res = await _service.getAll(getAllQuery);
    if (_res.item1 != null) {
      List<Task> _com = [];
      List<Task> _unCom = [];
      if (_res.item1!.tasks!.isNotEmpty) {
        for (var element in _res.item1!.tasks!) {
          if (element.isCompleted == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnSuccess(completedtasks: _com, unCompletedtasks: _unCom));
      } else {
        emit(OnEmpty());
      }
    } else {
      emit(OnFailure(error: _res.item2));
    }
  }

  void updateTask(UpdateRequestModel task) async {
    emit(OnUpdateLoading());

    var _uRes = await _service.update(
      updateMutation,
      variables: task.toJson(),
    );
    if (_uRes.item1 != null) {
      emit(OnUpdateSuccess());
      fetchAllTask();
    } else {
      emit(OnUpdateFailure(error: _uRes.item2));
    }
  }

  void updateList() async {
    emit(OnUpdateLoading());
    var _res = await _service.getAll(getAllQuery);
    if (_res.item1 != null) {
      List<Task> _com = [];
      List<Task> _unCom = [];
      if (_res.item1!.tasks!.isNotEmpty) {
        for (var element in _res.item1!.tasks!) {
          if (element.isCompleted == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnSuccess(completedtasks: _com, unCompletedtasks: _unCom));
      } else {
        emit(OnEmpty());
      }
    } else {
      emit(OnFailure(error: _res.item2));
    }
  }
}
