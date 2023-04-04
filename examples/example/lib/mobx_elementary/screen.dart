import 'package:elementary/elementary.dart';
import 'package:example/mobx_elementary/screen_wm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class Screen extends ElementaryWidget<ScreenWm> {
  const Screen({
    super.key,
  }) : super(screenWmFactory);

  @override
  Widget build(wm) {
    return Observer(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            context.mediaQueryViewInsets.bottom.heightBox,
            Center(child: Text(wm.n.value.toString())),
            TextButton(
              onPressed: () {
                wm.inc();
              },
              child: Text('inc'),
            )
          ],
        ),
      );
    });
  }
}
