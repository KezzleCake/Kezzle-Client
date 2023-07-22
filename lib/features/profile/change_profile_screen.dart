import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class ChangeProfileScreen extends StatefulWidget {
  static const routeURL = '/change_profile';
  static const routeName = 'change_profile';

  const ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  // 초기 닉네임(저장되어있던)
  String _nickname = '보나';
  bool _btnPressed = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = _nickname;
    _textEditingController.addListener(() {
      setState(() {
        //10글자를 넘어가면 못쓰도록 제한
        if (_textEditingController.text.length > 10) {
          _textEditingController.text =
              _textEditingController.text.substring(0, 10);
          _textEditingController.selection = TextSelection.fromPosition(
              TextPosition(offset: _textEditingController.text.length));
        }
        _nickname = _textEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _btnPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _btnPressed = false;
    });
  }

  void onTapSaveBtn() {
    print('Tapped');
    print(_nickname);
    // 변경된 닉네임 저장

    //현재 화면 pop
    Navigator.of(context).pop();
  }

  void keyboardDismiss() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: keyboardDismiss, // 키보드 내리기
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text('프로필 수정')),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('닉네임을 입력해주세요',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray08)),
                      const SizedBox(height: 8),
                      TextField(
                          keyboardType: TextInputType.name,
                          // autofocus: true,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray06),
                          controller: _textEditingController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: '예) 케즐',
                              hintStyle: TextStyle(color: gray04),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: gray03,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: gray03,
                                  )),
                              suffix: Text('${_nickname.length}/10',
                                  style: TextStyle(
                                      color: _nickname.isNotEmpty
                                          ? gray05
                                          : gray04)))),
                    ])),
            bottomNavigationBar: BottomAppBar(
                color: Colors.transparent,
                elevation: 0,
                child: IgnorePointer(
                    ignoring: _textEditingController
                        .text.isEmpty, // 텍스트가 비어있으면 버튼 비활성화
                    child: GestureDetector(
                        onTap: onTapSaveBtn,
                        onTapDown: (details) => _onTapDown(details),
                        onTapUp: (details) => _onTapUp(details),
                        child: AnimatedContainer(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: _textEditingController.text.isEmpty
                                    ? gray04
                                    : (_btnPressed ? coral03 : coral01),
                                borderRadius: BorderRadius.circular(30)),
                            clipBehavior: Clip.hardEdge,
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              '저장하기',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: gray01),
                            )))))));
  }
}
