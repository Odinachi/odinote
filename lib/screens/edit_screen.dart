import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:odinote/constants.dart';
import 'package:odinote/cubit/edit_cubit/edit_cubit.dart';
import 'package:odinote/models/task.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key, this.task}) : super(key: key);
  Task? task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => EditScreenCubit(),
        child: _EditScreen(
          task: task,
        ));
  }
}

class _EditScreen extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final _form = GlobalKey<FormState>();
  Task? task;
  bool changed = false;

  _EditScreen({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _desc.text = task?.desc ?? "";
    _title.text = task?.title ?? "";

    return Scaffold(
      body: BlocListener<EditScreenCubit, EditScreenState>(
        listenWhen: (prev, nxt) {
          if (prev is OnEditUpdateLoading || prev is OnEditLoading) {
            Navigator.pop(context);
          }
          if (prev is OnEditSuccess ||
              prev is OnEditDeleteSuccess ||
              prev is OnEditUpdateSuccess) {
            changed = true;
          }
          return true;
        },
        listener: (context, state) {
          if (state is OnEditUpdateFailure) {
            showSnackBar(context, false, message: state.error);
          }
          if (state is OnEditDeleteFailure) {
            showSnackBar(context, false, message: state.error);
          }
          if (state is OnEditSuccess) {
            showSnackBar(context, true, message: "Task created Successfully");
          }
          if (state is OnEditDeleteSuccess) {
            showSnackBar(context, true, message: "Task Deleted Successfully");
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pop(context, changed);
            });
          }
          if (state is OnEditUpdateSuccess) {
            showSnackBar(context, true, message: "Task updated Successfully");
          }
          if (state is OnEditUpdateLoading) {
            showLoading(context);
          }
          if (state is OnEditLoading) {
            showLoading(context);
          }
          if (state is OnEditFailure) {
            showSnackBar(context, false, message: state.error);
          }
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .12,
              padding: const EdgeInsets.fromLTRB(16, 46, 16, 10),
              color: const Color(0xff742DDD),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, changed);
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
                        task == null ? "Create Task" : "Update Task",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  if (task != null)
                    InkWell(
                      onTap: () {
                        context.read<EditScreenCubit>().deleteTask(task!.id!);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(16),
                        const Text(
                          "Title",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Gap(16),
                        TextFormField(
                          cursorColor: const Color(0xff742DDD),
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
                            fillColor: const Color(0xffF5F5F5),
                          ),
                        ),
                        const Gap(26),
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Gap(16),
                        SizedBox(
                          height: 200,
                          child: TextFormField(
                            cursorColor: const Color(0xff742DDD),
                            controller: _desc,
                            maxLines: 200,
                            decoration: InputDecoration(
                              hintText: "Describe your task",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              fillColor: const Color(0xffF5F5F5),
                            ),
                          ),
                        ),
                        const Gap(36),
                        InkWell(
                          onTap: () {
                            if (_form.currentState?.validate() == false) return;
                            if (task == null) {
                              context.read<EditScreenCubit>().createTask(
                                  title: _title.text, desc: _desc.text);
                            } else {
                              context.read<EditScreenCubit>().updateTask(
                                    id: task!.id!,
                                    title: _title.text,
                                    done: task!.done!,
                                    desc: _desc.text,
                                  );
                            }
                            if (task == null) {
                              _title.clear();
                              _desc.clear();
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
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
                              color: const Color(0xff742DDD),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditScreenArg {
  Task? task;
  EditScreenArg(this.task);
}
