import 'package:flutter/material.dart';
import 'package:utils/utils_flutter.dart';

class SizeBuilder extends StatefulWidget {
  const SizeBuilder({
    super.key,
    required this.subject,
    required this.builder,
  });

  final Widget subject;
  final Widget Function(BuildContext context, Size size) builder;

  @override
  State<SizeBuilder> createState() => _SizeBuilderState();
}

class _SizeBuilderState extends State<SizeBuilder> {
  Size? _size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.of(context); // subscribe to MediaQuery changes
    _size = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_size == null)
          Offstage(
            child: SizeReportingWidget(
              onSizeChange: (size) {
                _size = size;
                setState(() {});
              },
              child: widget.subject,
            ),
          ),
        if (_size != null) widget.builder(context, _size!),
      ],
    );
  }
}
