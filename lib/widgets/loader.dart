import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: Transform.scale(
          scale: .5,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
