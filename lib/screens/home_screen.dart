import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:odinote/cubit/home_cubit/home_cubit.dart';
import 'package:odinote/custom_widgets/list_card.dart';

import 'edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<HomeScreenCubit>(
        create: (context) => HomeScreenCubit()..fetchAllTask(),
        child: const _HomeScreen(),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => EditScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff742DDD),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(10),
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Align(
              alignment: Alignment.centerLeft, child: Text("Todo List")),
          backgroundColor: const Color(0xff742DDD),
        ),
        body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
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
            if (state is OnUpdateLoading) {}
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
                  duration: Duration(seconds: 3),
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
              return Column(
                children: [
                  state.unCompletedtasks!.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemCount: state.unCompletedtasks!.length,
                          itemBuilder: (context, index) {
                            return ListCard(
                              onDonePress: () {},
                              onPress: () {},
                              index: index.toString(),
                              isDone: false,
                              title: state.unCompletedtasks![index].title,
                              subtitle:
                                  state.unCompletedtasks![index].description,
                            );
                            ;
                          },
                        )
                      : SizedBox(),
                  state.completedtasks!.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemCount: state.completedtasks!.length,
                          itemBuilder: (context, index) {
                            return ListCard(
                              onDonePress: () {},
                              onPress: () {},
                              index: index.toString(),
                              isDone: false,
                              title: state.completedtasks![index].title,
                              subtitle:
                                  state.completedtasks![index].description,
                            );
                            ;
                          },
                        )
                      : SizedBox(),
                ],
              );
            }
            if (state is OnUpdateSuccess) {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
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
              });
            }
            if (state is OnEmpty) {
              return Center(
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
              );
            }
            return Center(
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
            );
          },
        )
        //

        );
  }
}
