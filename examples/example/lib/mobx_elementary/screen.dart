import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screen_wm.dart';

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
            (context.mediaQueryViewInsets.bottom + 0.h).heightBox,
          ],
        ),
      );
    });
  }
}
