import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odinote/models/new_task.dart';
import 'package:odinote/models/new_task_response.dart';
import 'package:odinote/service/mutation_strings.dart';
import 'package:odinote/service/service.dart';

part 'edit_state.dart';

class EditScreenCubit extends Cubit<EditScreenState> {
  EditScreenCubit() : super(InitialEditState());
  AppService _service = AppService();

  void createTask(NewTaskRequestModel newTaskRequestModel) async {
    emit(OnEditLoading());
    var _res = await _service.create(insertMutation,
        variables: newTaskRequestModel.toJson());
    if (_res.item1 != null) {
      emit(OnEditSuccess());
    } else {
      emit(OnEditFailure(error: _res.item2));
    }
  }

  void updateTask(Task task) async {
    emit(OnEditLoading());
    var _uRes = await _service.update(
      updateMutation,
      variables: task.toJson(),
    );
    var _res = await _service.getAll(insertMutation);
    if (_uRes.item1 != null) {
      if (_res.item1 != null) {
        List<Task> _com = [];
        List<Task> _unCom = [];
        for (var element in _res.item1!.data!.tasks!) {
          if (element.isCompleted == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnEditUpdateSuccess());
      } else {
        emit(OnEditUpdateFailure(error: _uRes.item2));
      }
    } else {
      emit(OnEditUpdateFailure(error: _res.item2));
    }
  }

  void deleteTask(String TasskId) async {
    var _res = await _service.delete(query: deleteMutation, id: TasskId);
    if (_res.item1 != null) {
      emit(OnEditSuccess());
    } else {
      emit(OnEditFailure(error: _res.item2));
    }
  }
}
