import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:odinote/cubit/home_cubit/home_cubit.dart';
import 'package:odinote/custom_widgets/list_card.dart';
import 'package:odinote/models/update_request_model.dart';

import 'edit_screen.dart';

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
        body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            print(state);
            if (state is OnLoading) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: 5,
                itemBuilder: (context, idext) {
                  return Column(
                    children: [
                      SizedBox(
                        height: _height * .05,
                      ),
                      ListTileShimmer(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        isRectBox: true,
                        height: 10,
                        isDisabledAvatar: true,
                        isDisabledButton: true,
                      ),
                    ],
                  );
                },
              );
            }
            if (state is OnUpdateLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is OnFailure) {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                  content: Text(
                    state.error ?? "an unexpected error occured",
                    textAlign: TextAlign.center,
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 4),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 150,
                      right: 20,
                      left: 20),
                ));
              });
            }
            if (state is OnUpdateFailure) {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                  content: Text(
                    state.error ?? "an unexpected error occured",
                    textAlign: TextAlign.center,
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 150,
                      right: 20,
                      left: 20),
                ));
              });
            }
            if (state is OnSuccess) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        state.unCompletedtasks!.length > 0
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 20),
                                itemCount: state.unCompletedtasks!.length,
                                itemBuilder: (context, index) {
                                  var t = state.unCompletedtasks![index];
                                  return ListCard(
                                    onDonePress: () {
                                      var _task = UpdateRequestModel(
                                          id: t.id,
                                          payload: Payload(
                                              isCompleted: true,
                                              title: t.title,
                                              description: t.description));
                                      print(_task.toJson());
                                      context
                                          .read<HomeScreenCubit>()
                                          .updateTask(_task);
                                    },
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditScreen(
                                            task: t,
                                          ),
                                        ),
                                      );
                                    },
                                    index: (index + 1).toString(),
                                    isDone: false,
                                    title: t.title,
                                    subtitle: t.description,
                                  );
                                },
                              )
                            : SizedBox(),
                        state.completedtasks!.length > 0
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.completedtasks!.length,
                                itemBuilder: (context, index) {
                                  var t = state.completedtasks![index];
                                  return ListCard(
                                    onDonePress: () {
                                      var _task = UpdateRequestModel(
                                          id: t.id,
                                          payload: Payload(
                                              isCompleted: false,
                                              title: t.title,
                                              description: t.description));
                                      context
                                          .read<HomeScreenCubit>()
                                          .updateTask(_task);
                                    },
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditScreen(
                                            task: t,
                                          ),
                                        ),
                                      );
                                    },
                                    index: index.toString(),
                                    isDone: true,
                                    title: t.title,
                                    subtitle: t.description,
                                  );
                                  ;
                                },
                              )
                            : const SizedBox(),
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
                        var i = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) => EditScreen()));
                        if (i != null) {
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
            if (state is OnUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text(
                  "update successful",
                  textAlign: TextAlign.center,
                ),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 150,
                    right: 20,
                    left: 20),
              ));
            }
            if (state is OnEmpty) {
              return Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Todo List is empty",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          "Create a task",
                          style: const TextStyle(
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
                        var i = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) => EditScreen()));
                        if (i != null) {
                          context.read<HomeScreenCubit>().updateList();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(50),
                        decoration: BoxDecoration(
                            color: Color(0xff742DDD), shape: BoxShape.circle),
                        child: Icon(
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
                  children: [
                    Text(
                      "Something happened",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      "Click Here to Refresh",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
        //

        );
  }
}
