import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odinote/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class ListCard extends StatelessWidget {
  ListCard(
      {Key? key,
      this.index,
      required this.title,
      required this.isDone,
      this.subtitle,
      this.onPress})
      : super(key: key);
  String title;
  String? subtitle;
  String? index;
  bool isDone;
  VoidCallback? onPress;
  VoidCallback? onDonePress;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: height * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "${isDone ? title[0].toUpperCase() : index}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDone ? greenColor : goldColor),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: isDone ? greenColor : goldColor),
                  shape: BoxShape.circle,
                  color: isDone ? lightGreenColor : goldColor.withOpacity(0.2),
                ),
              ),
            ),
            SizedBox(
              width: width * .03,
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getHeader(title),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: height * .005,
                  ),
                  Text(
                    _getSubtitle(subtitle ?? ""),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: greyColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onDonePress,
                    child: Container(
                      child: isDone
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : const SizedBox(),
                      height: height * .035,
                      width: width * .075,
                      decoration: BoxDecoration(
                        color: isDone ? greenColor : lightGreyColor,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: isDone ? greenColor : greyColor,
                        ),
                      ),
                      padding: const EdgeInsets.all(3),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getSubtitle(String s) {
    if (s == null) {
      return "";
    }
    if (s.length > 32) {
      return "${s.substring(0, 31)}...";
    } else {
      return s;
    }
  }

  String _getHeader(String s) {
    if (s == null) {
      return "";
    }
    if (s.length > 20) {
      return "${s.substring(0, 20)}...";
    } else {
      return s;
    }
  }
}
