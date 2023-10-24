import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchExternalURLDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final String url;

  const LaunchExternalURLDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText = '취소',
    this.confirmText = '이동',
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 0,
        backgroundColor: gray01,
        // contentPadding: const EdgeInsets.symmetric(
        //     horizontal: 24, vertical: 20),
        title: Text(title,
            // '스토어의 카카오톡 채널로\n이동하시겠습니까?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: gray08)),
        content: Text(
            // '먼저 원하는 케이크 디자인 사진을 복사/저장한 후, 카톡으로 전달하여 주문을 완료해보세요!',
            content,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, color: gray06)),
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                flex: 2,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: gray03),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      // '취소',
                      cancelText,
                      style:
                          TextStyle(color: gray05, fontWeight: FontWeight.w600),
                    ))),
            const SizedBox(width: 8),
            Expanded(
                flex: 3,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: coral01),
                    onPressed: () async {
                      Navigator.pop(context);
                      await launchUrlString(url,
                          mode: LaunchMode.externalApplication);
                    },
                    child: Text(
                        // '이동',
                        confirmText,
                        style: TextStyle(
                            color: gray01, fontWeight: FontWeight.w600)))),
          ]),
        ]);
  }
}