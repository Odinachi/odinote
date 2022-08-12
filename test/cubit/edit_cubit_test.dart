import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odinote/cubit/edit_cubit/edit_cubit.dart';
import 'package:odinote/models/task.dart';
import 'package:odinote/service/app_service.dart';

import '../service/app_service_test.mocks.dart';

class MockService extends Mock implements TaskService {}

void main() {
  late EditScreenCubit mockCubit;
  late MockTaskService mockService;
  late Task testTask = Task(id: 1, title: "first ", done: false, desc: "yes");
  List<Task> taskList = List.generate(10, (index) => testTask);

  setUp(() async {
    mockService = MockTaskService();
    mockCubit = EditScreenCubit(mockService);
    when(mockService.insert(any)).thenAnswer((_) async => testTask);
    when(mockService.update(any)).thenAnswer((_) async => 1);
    when(mockService.delete(any)).thenAnswer((_) async => 1);
    when(mockService.getTask(any)).thenAnswer((_) async => testTask);
    when(mockService.getAllTask()).thenAnswer((_) async => taskList);
  });
  group('EditScreenBloc', () {
    blocTest<EditScreenCubit, EditScreenState>(
      'check if create was successful',
      build: () {
        return EditScreenCubit(mockService);
      },
      setUp: () => when(mockCubit.createTask(title: ""))
          .thenAnswer((_) => Future.value()),
      act: (b) => b.createTask(title: ""),
      expect: () => [isA<OnEditLoading>(), isA<OnEditSuccess>()],
      verify: (b) => verify(() => b.createTask(title: "")).called(1),
    );
  });
}
