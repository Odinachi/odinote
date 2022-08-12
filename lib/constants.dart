import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:odinote/colors.dart';

const String tableTodo = 'todo';
const String demoDb = 'demo.db';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnDesc = 'description';
const String columnDone = 'done';

showSnackBar(BuildContext ctx, bool isSuccess, {String? message}) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(
      message ?? "an unexpected error occured",
      textAlign: TextAlign.center,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: isSuccess ? greenColor : Colors.red,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
  ));
}

void showLoading(BuildContext ctx) {
  showDialog(
      context: ctx,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          ));
}

Widget appShimmer() {
  return ListView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(vertical: 20),
    itemCount: 5,
    itemBuilder: (context, idext) {
      return Column(
        children: const [
          SizedBox(
            height: 30,
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
