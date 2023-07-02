import 'package:flutter/material.dart';

class H1 extends StatelessWidget {
  final String text;
  final Color? color;

  const H1({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: color,
      ),
    );
  }
}

class H2 extends StatelessWidget {
  final String text;
  final Color? color;

  const H2({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

class H3 extends StatelessWidget {
  final String text;
  final Color? color;

  const H3({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

class H4 extends StatelessWidget {
  final String text;
  final Color? color;

  const H4({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}
