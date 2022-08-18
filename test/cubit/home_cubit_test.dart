import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odinote/cubit/home_cubit/home_cubit.dart';
import 'package:odinote/models/task.dart';

import '../service/app_service_test.mocks.dart';

void main() {
  late HomeScreenCubit mockCubit;
  late MockTaskService mockService;
  late Task testTask = Task(id: 1, title: "first ", done: false, desc: "yes");
  List<Task> taskList = List.generate(10, (index) => testTask);

  setUp(() async {
    mockService = MockTaskService();
    mockCubit = HomeScreenCubit(mockService);
  });
  group("Home Screen bloc test", () {
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if fetch all works',
      build: () => mockCubit,
      setUp: () =>
          when(mockService.getAllTask()).thenAnswer((_) async => taskList),
      act: (b) => b.fetchAllTask(),
      expect: () => [isA<OnLoading>(), isA<OnSuccess>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if fetch all is empty',
      build: () => mockCubit,
      setUp: () => when(mockService.getAllTask()).thenAnswer((_) async => []),
      act: (b) => b.fetchAllTask(),
      expect: () => [isA<OnLoading>(), isA<OnEmpty>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if fetch all fails',
      build: () => mockCubit,
      setUp: () => when(mockService.getAllTask()).thenAnswer((_) async => null),
      act: (b) => b.fetchAllTask(),
      expect: () => [isA<OnLoading>(), isA<OnFailure>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if update task works',
      build: () => mockCubit,
      setUp: () {
        when(mockService.update(any)).thenAnswer((_) async => testTask.id!);
        when(mockService.getAllTask()).thenAnswer((_) async => taskList);
      },
      act: (b) => b.updateTask(testTask),
      expect: () => [isA<OnSuccess>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if update task is empty',
      build: () => mockCubit,
      setUp: () {
        when(mockService.update(any)).thenAnswer((_) async => testTask.id!);
        when(mockService.getAllTask()).thenAnswer((_) async => []);
      },
      act: (b) => b.updateTask(testTask),
      expect: () => [isA<OnEmpty>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if update task fails',
      build: () => mockCubit,
      setUp: () {
        when(mockService.update(any)).thenAnswer((_) async => null);
        when(mockService.getAllTask()).thenAnswer((_) async => taskList);
      },
      act: (b) => b.updateTask(testTask),
      expect: () => [isA<OnUpdateFailure>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if update all works',
      build: () => mockCubit,
      setUp: () =>
          when(mockService.getAllTask()).thenAnswer((_) async => taskList),
      act: (b) => b.updateList(),
      expect: () => [isA<OnSuccess>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if update all fails',
      build: () => mockCubit,
      setUp: () => when(mockService.getAllTask()).thenAnswer((_) async => null),
      act: (b) => b.updateList(),
      expect: () => [isA<OnFailure>()],
    );
    blocTest<HomeScreenCubit, HomeScreenState>(
      'check if update all is empty',
      build: () => mockCubit,
      setUp: () => when(mockService.getAllTask()).thenAnswer((_) async => []),
      act: (b) => b.updateList(),
      expect: () => [isA<OnEmpty>()],
    );
  });
  tearDown(() => mockCubit.close());
}
