

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogWithLoader extends StatefulWidget {
  const DialogWithLoader({super.key});

  @override
  _DialogWithLoaderState createState() => _DialogWithLoaderState();

  static Future<void> show(BuildContext context) async {
    await Get.dialog(const DialogWithLoader());
  }

  static void hide() {
    if(Get.isDialogOpen??false) {
      Get.back();
    }
  }
}

class _DialogWithLoaderState extends State<DialogWithLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 50.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Center(
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
        ),
      ),
    );
  }

}
