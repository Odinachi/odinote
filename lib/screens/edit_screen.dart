import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:odinote/cubit/edit_cubit/edit_cubit.dart';
import 'package:odinote/models/new_task.dart';
import 'package:odinote/models/new_task_response.dart';
import 'package:odinote/screens/home_screen.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key, this.task}) : super(key: key);
  Task? task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditScreenCubit()..checkMode(task),
      child: _EditScreen(),
    );
  }
}

class _EditScreen extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool isCreate = true;
  bool isloading = false;

  Task? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<EditScreenCubit, EditScreenState>(
      builder: (context, state) {
        if (state is OnEditMode) {
          isloading = false;
          isCreate = false;
          _title.text = state.task!.title;
          _desc.text = state.task!.description!;
          task = state.task;
        }
        if (state is OnEditLoading) {
          isloading = true;
        }
        if (state is OnEditUpdateLoading) {
          isloading = true;
        }
        if (state is OnEditFailure) {
          isloading = false;
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error ?? "an unexpected error occured",
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 150,
                  right: 20,
                  left: 20),
            ));
          });
        }
        if (state is OnEditUpdateFailure) {
          isloading = false;

          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        if (state is OnEditDeleteFailure) {
          isloading = false;

          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error ?? "an unexpected error occured",
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 150,
                  right: 20,
                  left: 20),
            ));
          });
        }
        if (state is OnEditSuccess) {
          isloading = false;

          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                "Task created Succesfully",
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 150,
                  right: 20,
                  left: 20),
            ));
          });
          _desc.text = "";
          _title.text = "";
        }
        if (state is OnEditDeleteSuccess) {
          isloading = false;

          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                "Task Deleted Succesfully",
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

          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false);
          });
        }
        if (state is OnEditUpdateSuccess) {
          isloading = false;

          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text(
                "Task Updated Succesfully",
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 150,
                  right: 20,
                  left: 20),
            ));
          });
        }
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .12,
              padding: EdgeInsets.fromLTRB(16, 46, 16, 10),
              color: Color(0xff742DDD),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()),
                              (route) => false);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        isCreate ? "Create Task" : "Update Task",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      context.read<EditScreenCubit>().deleteTask(task!.id);
                    },
                    child: isCreate
                        ? const SizedBox()
                        : const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                  )
                ],
              ),
            ),
            isloading == true
                ? Container(
                    height: MediaQuery.of(context).size.height * .8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(16),
                            const Text(
                              "Title",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Gap(16),
                            Container(
                              child: TextFormField(
                                cursorColor: Color(0xff742DDD),
                                controller: _title,
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "Title cannot be empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "What do you want to do?",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffF5F5F5),
                                ),
                              ),
                            ),
                            Gap(26),
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Gap(16),
                            Container(
                              height: 200,
                              child: TextFormField(
                                cursorColor: Color(0xff742DDD),
                                controller: _desc,
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "Title cannot be empty";
                                  }
                                  return null;
                                },
                                maxLines: 200,
                                decoration: InputDecoration(
                                  hintText: "Describe your task",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffF5F5F5),
                                ),
                              ),
                            ),
                            Gap(36),
                            InkWell(
                              onTap: () {
                                if (_form.currentState!.validate()) {
                                  if (isCreate) {
                                    NewTaskRequestModel n = NewTaskRequestModel(
                                        title: _title.text,
                                        description: _desc.text);
                                    context
                                        .read<EditScreenCubit>()
                                        .createTask(n);
                                  } else {
                                    Task t = Task(
                                        title: _title.text,
                                        description: _desc.text,
                                        id: task!.id,
                                        isCompleted: task!.isCompleted,
                                        developerId: task!.developerId,
                                        createdAt: task!.createdAt,
                                        updatedAt: DateTime.now());
                                    context
                                        .read<EditScreenCubit>()
                                        .updateTask(t);
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: const Text(
                                  "Save",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff742DDD),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    ));
  }
}
