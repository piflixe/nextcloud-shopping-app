import 'package:flutter/material.dart';

class AutoFitText extends StatelessWidget {
  const AutoFitText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.center,
    this.maxLines = 2,
    this.minFontSize = 10,
    this.maxFontSize = 17,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLines;
  final double minFontSize;
  final double maxFontSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fontSize = _bestFontSize(
          context: context,
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
        );
        return Text(
          text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: style.copyWith(fontSize: fontSize),
        );
      },
    );
  }

  double _bestFontSize({
    required BuildContext context,
    required double maxWidth,
    required double maxHeight,
  }) {
    if (!maxWidth.isFinite || !maxHeight.isFinite) {
      return maxFontSize;
    }

    final direction = Directionality.of(context);
    final scaler = MediaQuery.textScalerOf(context);
    var low = minFontSize;
    var high = maxFontSize;

    for (var i = 0; i < 12; i++) {
      final mid = (low + high) / 2;
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: style.copyWith(fontSize: mid),
        ),
        maxLines: maxLines,
        textAlign: textAlign,
        textDirection: direction,
        textScaler: scaler,
      )..layout(maxWidth: maxWidth);

      final fits = !painter.didExceedMaxLines && painter.height <= maxHeight;
      if (fits) {
        low = mid;
      } else {
        high = mid;
      }
    }

    return low;
  }
}
