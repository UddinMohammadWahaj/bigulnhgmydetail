import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogUtils {
  static bool isDialogOpened = false;
  static Future<void> showDialog(BuildContext context) async {
    isDialogOpened = true;
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Image.asset(
              'assets/images/loader/Bigul-Logo_Loader-Animation_Blue.gif',
              height: 80.0,
              width: 80.0,
            ),
          ),
        );
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  static Future<void> hideProgress(BuildContext context) async {
    if(isDialogOpened) {
      Navigator.of(context).pop();
    }
    isDialogOpened = false;
  }



}
