import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kezzle/utils/colors.dart';

class Toast {
  static void toast(context, text) {
    final fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        // color: Colors.black,
        color: coral01,
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500),
      ),
    );

    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 1),
        positionedToastBuilder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: child,
              ),
              // Positioned(
              //   child: child,
              //   bottom: 100,
              // ),
            ],
          );
        });
  }
}
