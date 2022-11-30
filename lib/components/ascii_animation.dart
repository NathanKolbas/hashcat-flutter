import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Range {
  const Range(this.start, this.end);

  final int start;
  final int end;
}

class AsciiAnimation extends StatefulWidget {
  static const _charRange = Range(33, 126);
  static const _charRangeNumbers = Range(48, 57);
  static String _defaultTextFunction(String s) => s;
  static const defaultSpeed = Duration(seconds: 1);
  static final defaultFont = GoogleFonts.sourceCodePro();

  const AsciiAnimation({
    Key? key,
    required this.length,
    this.range = _charRange,
    this.speed = defaultSpeed,
    this.style,
    this.textFunction = _defaultTextFunction,
  }) : super(key: key);

  /// ASCII animation that is only numbers
  const AsciiAnimation.numbers({
    Key? key,
    required this.length,
    this.range = _charRangeNumbers,
    this.speed = defaultSpeed,
    this.style,
    this.textFunction = _defaultTextFunction,
  }) : super(key: key);

  /// The number of chars
  final int length;

  /// The char range in ASCII. Defaults to visible chars 33..126.
  final Range range;

  /// How fast the animation should happen
  final Duration speed;

  /// The style of the text
  final TextStyle? style;

  /// A function that can be applied the text before it is rendered.
  /// An example use case is formatting a number to a currency.
  final String Function(String) textFunction;

  @override
  _AsciiAnimationState createState() => _AsciiAnimationState();
}

class _AsciiAnimationState extends State<AsciiAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late String text;

  String getText() {
    String result = '';
    final rand = Random();
    for (var i=0; i < widget.length; i++) {
      int char = rand.nextInt(widget.range.end - widget.range.start) + widget.range.start;
      result += String.fromCharCode(char);
    }
    return widget.textFunction(result);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed,
    )
      ..addListener(() => setState(() => text = widget.textFunction((text.split('')..shuffle()).join())));

    text = getText();
    _controller.repeat();

    super.initState();
  }


  @override
  void didUpdateWidget(AsciiAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.speed;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: widget.style ?? AsciiAnimation.defaultFont,
    );
  }
}
