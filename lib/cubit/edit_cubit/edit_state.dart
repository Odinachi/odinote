part of "edit_cubit.dart";

abstract class EditScreenState {
  const EditScreenState();
}

class InitialEditState extends EditScreenState {
  List<Object> get props => [];
}

class OnEditLoading extends EditScreenState {
  List<Object> get props => [];
}

class OnEditUpdateLoading extends EditScreenState {
  List<Object> get props => [];
}

class OnEditFailure extends EditScreenState {
  String? error;
  OnEditFailure({this.error});
  List<Object> get props => [];
}

class OnEditUpdateFailure extends EditScreenState {
  String? error;
  OnEditUpdateFailure({this.error});
  List<Object> get props => [];
}

class OnEditSuccess extends EditScreenState {
  List<Object> get props => [];
}

class OnEditUpdateSuccess extends EditScreenState {
  List<Object> get props => [];
}
