import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odinote/models/new_task_response.dart';
import 'package:odinote/service/mutation_strings.dart';
import 'package:odinote/service/service.dart';

part 'home_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(InitialState());
  AppService _service = AppService();

  void fetchAllTask() async {
    print("fetching....");
    emit(OnLoading());
    var _res = await _service.getAll(getAllQuery);
    if (_res.item1 != null) {
      List<Task> _com = [];
      List<Task> _unCom = [];
      if (_res.item1!.tasks!.isNotEmpty) {
        print('kkkk ${_res.item1!.toJson()}');
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

  void updateTask(Task task) async {
    emit(OnLoading());
    var _uRes = await _service.update(
      updateMutation,
      variables: task.toJson(),
    );
    var _res = await _service.getAll(insertMutation);
    if (_uRes.item1 != null) {
      if (_res.item1 != null) {
        List<Task> _com = [];
        List<Task> _unCom = [];
        for (var element in _res.item1!.tasks!) {
          if (element.isCompleted == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnUpdateSuccess(completedtasks: _com, unCompletedtasks: _unCom));
      } else {
        emit(OnUpdateFailure(error: _uRes.item2));
      }
    } else {
      emit(OnUpdateFailure(error: _res.item2));
    }
  }
}
