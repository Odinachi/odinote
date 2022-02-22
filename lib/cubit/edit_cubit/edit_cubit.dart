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
    if (_uRes.item1 != null) {
    } else {
      emit(OnEditUpdateFailure(error: _uRes.item2));
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
