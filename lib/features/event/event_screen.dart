import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  static const routeName = 'event';
  static const routeURL = '/event';
  final String image;
  final String eventURL;

  const EventScreen({super.key, required this.image, required this.eventURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('이벤트'),
      ),
      body: Column(
        children: [
          Image.asset(
            image,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
