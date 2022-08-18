import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odinote/cubit/edit_cubit/edit_cubit.dart';
import 'package:odinote/models/task.dart';

import '../service/app_service_test.mocks.dart';

void main() {
  late EditScreenCubit mockCubit;
  late MockTaskService mockService;
  late Task testTask = Task(id: 1, title: "first ", done: false, desc: "yes");

  setUp(() async {
    mockService = MockTaskService();
    mockCubit = EditScreenCubit(mockService);
  });
  group('EditScreenBloc', () {
    blocTest<EditScreenCubit, EditScreenState>(
      'check if create was successful',
      build: () => mockCubit,
      setUp: () =>
          when(mockService.insert(any)).thenAnswer((_) async => testTask),
      act: (b) => b.createTask(title: testTask.title!),
      expect: () => [isA<OnEditLoading>(), isA<OnEditSuccess>()],
    );
    blocTest<EditScreenCubit, EditScreenState>(
      'check if update was successful',
      build: () => mockCubit,
      setUp: () => when(mockService.update(any)).thenAnswer((_) async => 1),
      act: (b) => b.updateTask(
          title: testTask.title!, id: testTask.id!, done: testTask.done!),
      expect: () => [isA<OnEditLoading>(), isA<OnEditUpdateSuccess>()],
    );
    blocTest<EditScreenCubit, EditScreenState>(
      'check if update failed',
      build: () => mockCubit,
      setUp: () => when(mockService.update(any)).thenAnswer((_) async => null),
      act: (b) => b.updateTask(
          title: testTask.title!, id: testTask.id!, done: testTask.done!),
      expect: () => [isA<OnEditLoading>(), isA<OnEditUpdateFailure>()],
    );
    blocTest<EditScreenCubit, EditScreenState>(
      'check if delete was successful',
      build: () => mockCubit,
      setUp: () => when(mockService.delete(any)).thenAnswer((_) async => 1),
      act: (b) => b.deleteTask(taskId: testTask.id!),
      expect: () => [isA<OnEditLoading>(), isA<OnEditDeleteSuccess>()],
    );
    blocTest<EditScreenCubit, EditScreenState>(
      'check if delete failed',
      build: () => mockCubit,
      setUp: () => when(mockService.delete(any)).thenAnswer((_) async => null),
      act: (b) => b.deleteTask(taskId: testTask.id!),
      expect: () => [isA<OnEditLoading>(), isA<OnEditDeleteFailure>()],
    );
  });
  tearDown(() => mockCubit.close());
}
