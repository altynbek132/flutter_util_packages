// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    const defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 10,
        color: Colors.red,
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                enabled = !enabled;
                setState(() {});
              },
              child: const Text('toggle error state'),
            ),

            /// this border should be used in ALL states
            TextField(
              decoration: InputDecoration(
                enabled: enabled,
                border: defaultBorder,
              ),
            ),

            /// suggested solution
            TextField(
              decoration: InputDecoration(
                enabled: enabled,
                enabledBorder: defaultBorder,
              ),
            ),

            /// but it works in such way that we should set border to
            /// ALL states manually
            TextField(
              decoration: InputDecoration(
                border: defaultBorder,
                enabledBorder: defaultBorder,
                disabledBorder: defaultBorder,
                errorBorder: defaultBorder,
                focusedBorder: defaultBorder,
                focusedErrorBorder: defaultBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
