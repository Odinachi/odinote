import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odinote/constants.dart';
import 'package:odinote/cubit/home_cubit/home_cubit.dart';
import 'package:odinote/custom_widgets/list_card.dart';
import 'package:odinote/screens/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomeScreenCubit>(
        create: (context) => HomeScreenCubit()..fetchAllTask(),
        child: _HomeScreen(),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.centerLeft, child: Text("Todo List")),
        backgroundColor: const Color(0xff742DDD),
      ),
      body: BlocConsumer<HomeScreenCubit, HomeScreenState>(
        listenWhen: (prev, next) {
          if (prev is OnUpdateLoading) {
            Navigator.pop(context);
          }
          return true;
        },
        listener: (context, state) {
          if (state is OnUpdateSuccess) {
            showSnackBar(context, true, message: "Update successful");
          }
          if (state is OnFailure) {
            showSnackBar(context, false, message: state.error);
          }
          if (state is OnUpdateLoading) {
            showLoading(context);
          }
          if (state is OnUpdateFailure) {
            showSnackBar(context, false, message: state.error);
          }
        },
        builder: (context, state) {
          if (state is OnLoading) {
            return appShimmer();
          }

          if (state is OnSuccess) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state.unCompletedTasks!.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: state.unCompletedTasks!.length,
                          itemBuilder: (context, index) {
                            var t = state.unCompletedTasks![index];
                            return ListCard(
                              onDonePress: () {
                                t.done = true;
                                context.read<HomeScreenCubit>().updateTask(t);
                              },
                              onPress: () async {
                                var p = await Navigator.pushNamed(
                                    context, "edit",
                                    arguments: EditScreenArg(t));
                                if (p != null) {
                                  context.read<HomeScreenCubit>().updateList();
                                }
                              },
                              index: (index + 1).toString(),
                              isDone: false,
                              title: t.title ?? "",
                              subtitle: t.desc,
                            );
                          },
                        ),
                      if (state.completedTasks!.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.completedTasks!.length,
                          itemBuilder: (context, index) {
                            var t = state.completedTasks![index];
                            return ListCard(
                              onDonePress: () {
                                t.done = false;
                                context.read<HomeScreenCubit>().updateTask(t);
                              },
                              onPress: () async {
                                var p = await Navigator.pushNamed(
                                    context, "edit",
                                    arguments: EditScreenArg(t));
                                if (p != null) {
                                  context.read<HomeScreenCubit>().updateList();
                                }
                              },
                              index: index.toString(),
                              isDone: true,
                              title: t.title ?? "",
                              subtitle: t.desc,
                            );
                          },
                        ),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      var p = await Navigator.pushNamed(context, "edit",
                          arguments: EditScreenArg(null));
                      if (p != null) {
                        context.read<HomeScreenCubit>().updateList();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(50),
                      decoration: const BoxDecoration(
                          color: Color(0xff742DDD), shape: BoxShape.circle),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            );
          }

          if (state is OnEmpty) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Todo List is empty",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        "Create a task",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () async {
                      var p = await Navigator.pushNamed(context, "edit",
                          arguments: EditScreenArg(null));
                      if (p != null) {
                        context.read<HomeScreenCubit>().updateList();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(50),
                      decoration: const BoxDecoration(
                          color: Color(0xff742DDD), shape: BoxShape.circle),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: InkWell(
              onTap: () {
                context.read<HomeScreenCubit>().fetchAllTask();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Something happened",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    "Click Here to Refresh",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
