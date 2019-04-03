import 'package:flutter/cupertino.dart';


void showDialogWithTitle(String title, BuildContext context) {
  showCupertinoDialog(context: context, builder: (_) {
    return CupertinoAlertDialog(
      title: Text(title),
      actions: <Widget>[
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消'),
        ),
      ],
    );
  });
}







