import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:odinote/service/graph_ql.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const insert = """
    mutation InsertTask(\$description: String!, \$developer_id: String!, \$title: String!) {
  insert_tasks_one(object: {title: \$title, developer_id: \$developer_id, description: \$description}) {
    created_at
    description
    developer_id
    id
    isCompleted
    title
    updated_at
  }
}
    """;
    AppRepository().performQuery(insert, variables: {});
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.centerLeft, child: Text("Create Task")),
        backgroundColor: const Color(0xff742DDD),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(16),
                Text(
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff742DDD),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
