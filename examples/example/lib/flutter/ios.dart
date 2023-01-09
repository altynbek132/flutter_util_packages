import 'package:flutter/material.dart';

class IosScreen extends StatelessWidget {
  const IosScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox.square(
            dimension: 50,
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> main() async {
  runApp(
    MaterialApp(
      home: IosScreen(),
    ),
  );
}
