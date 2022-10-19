import 'dart:async';

import 'package:flutter/material.dart';

class RemeinderScreen extends StatefulWidget {
  const RemeinderScreen({super.key});

  @override
  State<RemeinderScreen> createState() => _RemeinderScreenState();
}

class _RemeinderScreenState extends State<RemeinderScreen> {
  _open() {
    final radius = Radius.circular(20);
    final roundedRectangleBorder = RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius));
    showModalBottomSheet(
      shape: roundedRectangleBorder,
      context: context,
      builder: (context) {
        return Column(
          children: const [Text('data')],
        );
      },
    );
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), _open);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
           TextButton(onPressed: _open, child: Text('open modal'))
        ],
      ),
    );
  }
}
