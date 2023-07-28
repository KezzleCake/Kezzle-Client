// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';

// class ReviewWriteScreen extends StatefulWidget {
//   const ReviewWriteScreen({super.key});

//   @override
//   State<ReviewWriteScreen> createState() => _ReviewWriteScreenState();
// }

// class _ReviewWriteScreenState extends State<ReviewWriteScreen> {
//   Uint8List? _file;

//   //사진 삭제 버튼
//   void onTapPictureXbutton() {
//     setState(() {
//       _file = null;
//     });
//   }

//   //화면 아무 곳 터치 시, 키보드 내리기
//   void onTapScreen() {
//     FocusScope.of(context).unfocus();
//   }

//   //이미지 선택
//   pickImage(ImageSource source) async {
//     final ImagePicker _imagePicker = ImagePicker();

//     XFile? _file = await _imagePicker.pickImage(source: source);

//     //File(_file.path)말고 _file.readAsBytes()를 쓰는 이유는?
//     if (_file != null) {
//       return await _file.readAsBytes();
//     }
//     print('No image selected');
//   }

//   //이미지 선택 다이얼로그 띄우기
//   _selectImage(BuildContext parentContext) async {
//     return showDialog(
//         context: parentContext,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             title: const Text('Create a Post'),
//             children: [
//               SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Take a photo'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(
//                     ImageSource.camera,
//                   );
//                   setState(() {
//                     _file = file;
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Choose from gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(
//                     ImageSource.gallery,
//                   );
//                   setState(() {
//                     _file = file;
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('리뷰 작성하기'),
//       ),
//       body: GestureDetector(
//         onTap: onTapScreen,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               const FaIcon(
//                 FontAwesomeIcons.cakeCandles,
//                 size: 52,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 '케이크 주문은 어떠셨나요?',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               RatingBar.builder(
//                 // ignoreGestures: true,
//                 itemSize: 35,
//                 initialRating: 3,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemBuilder: (context, _) => const Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),
//                 onRatingUpdate: (rating) {
//                   print(rating);
//                 },
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               const Divider(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 20,
//                   horizontal: 20,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         fillColor: Colors.grey[200],
//                         filled: true,
//                         // border: InputBorder.none,
//                         hintText: '스토어에 대한 리뷰를 남겨주세요.',
//                         hintStyle: const TextStyle(
//                           fontSize: 16,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                       ),
//                       maxLines: 6,
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     _file == null
//                         ? GestureDetector(
//                             onTap: () => _selectImage(context),
//                             child: Container(
//                               width: 67,
//                               height: 67,
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 10,
//                                 horizontal: 20,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               child: const Column(
//                                 children: [
//                                   FaIcon(FontAwesomeIcons.camera),
//                                   Text('사진'),
//                                 ],
//                               ),
//                             ),
//                           )
//                         : Stack(
//                             alignment: Alignment.topRight,
//                             children: [
//                               GestureDetector(
//                                 onTap: () => _selectImage(context),
//                                 child: Container(
//                                   //default 컨테이너랑 크기 맞춰놓음
//                                   width: 67,
//                                   height: 67,
//                                   child: AspectRatio(
//                                     aspectRatio: 1,
//                                     child:
//                                         Image.memory(_file!, fit: BoxFit.cover),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: GestureDetector(
//                                   onTap: onTapPictureXbutton,
//                                   child: const FaIcon(
//                                       FontAwesomeIcons.squareXmark,
//                                       size: 16),
//                                 ),
//                               ),
//                             ],
//                           ),
//                   ],
//                 ),
//               ),
//               const Divider(),
//               const Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 20,
//                   horizontal: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     EvaluationIndex(
//                       evaluationText: '맛있어요.',
//                     ),
//                     EvaluationIndex(
//                       evaluationText: '친절해요.',
//                     ),
//                     EvaluationIndex(
//                       evaluationText: '구현을 잘해줘요.',
//                     ),
//                     EvaluationIndex(
//                       evaluationText: '재료가 신선해요.',
//                     ),
//                     EvaluationIndex(
//                       evaluationText: '포장이 깔끔해요.',
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(
//                   // vertical: 20,
//                   horizontal: 20,
//                 ),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xffFDDA81),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     '리뷰 작성하기',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EvaluationIndex extends StatelessWidget {
//   final String evaluationText;

//   const EvaluationIndex({
//     super.key,
//     required this.evaluationText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 4,
//       ),
//       child: Row(
//         children: [
//           const FaIcon(
//             FontAwesomeIcons.circleCheck,
//             size: 26,
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Text(
//             evaluationText,
//             style: const TextStyle(
//               fontSize: 16,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
