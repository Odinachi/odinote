part of "home_cubit.dart";

abstract class HomeScreenState {
  const HomeScreenState();
}

class InitialState extends HomeScreenState {
  List<Object> get props => [];
}

class OnLoading extends HomeScreenState {
  List<Object> get props => [];
}

class OnUpdateLoading extends HomeScreenState {
  List<Object> get props => [];
}

class OnEmpty extends HomeScreenState {
  List<Object> get props => [];
}

class OnFailure extends HomeScreenState {
  String? error;
  OnFailure({this.error});
  List<Object> get props => [];
}

class OnUpdateFailure extends HomeScreenState {
  String? error;
  OnUpdateFailure({this.error});
  List<Object> get props => [];
}

class OnSuccess extends HomeScreenState {
  List<Task>? completedTasks;
  List<Task>? unCompletedTasks;
  OnSuccess({this.completedTasks, this.unCompletedTasks});
  List<Object> get props => [];
}

class OnUpdateSuccess extends HomeScreenState {
  List<Task>? completedTasks;
  List<Task>? unCompletedTasks;
  OnUpdateSuccess({this.completedTasks, this.unCompletedTasks});
  List<Object> get props => [];
}
