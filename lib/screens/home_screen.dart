import 'package:flutter/material.dart';
import 'package:odinote/custom_widgets/list_card.dart';

import 'edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: ListCard(
        index: "1",
        isDone: true,
        title: "meet with john and eat kay na agaggag h",
        subtitle: "hhsshshhhhshsshhshhshhshhhhsshshhhhshsshhshhshhshh",
      ),
    );
  }
}
