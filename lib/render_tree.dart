import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Future<void> main() async {
  RendererBinding.instance.drawFrame();
  RendererBinding.instance.pipelineOwner.flushLayout();
  {
    for (final ro in dirtyLayouts) {}
  }
  RendererBinding.instance.pipelineOwner.flushCompositingBits();
  RendererBinding.instance.pipelineOwner.flushPaint();
}
