import 'package:accessibly/accessibly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessiblyText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const AccessiblyText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final accessibilitySettings = context.watch<Accessibly>();

    // final TextStyle textStyle = style ?? const TextStyle();
    final Color? textColor = style?.color;
    final Color? fallbackColor =
        accessibilitySettings.stringToColor(accessibilitySettings.textColor);

    final bool isBlackOrWhite =
        textColor == Colors.black || textColor == Colors.white;

    final Color? finalColor =
        isBlackOrWhite ? fallbackColor : textColor ?? fallbackColor;

    TextStyle? textstyle = (style ?? const TextStyle()).copyWith(
      backgroundColor:
          style?.backgroundColor ?? accessibilitySettings.textBgColor,
      color: finalColor,
    );

    if (accessibilitySettings.textScaleFactor != 100) {
      textstyle = textstyle.copyWith(
          fontSize: (textstyle.fontSize ?? 14) *
              accessibilitySettings.textScaleFactor /
              100);
    }

    if (accessibilitySettings.impairedMode) {
      textstyle = textstyle.copyWith(
        fontSize: (textstyle.fontSize ?? 14) * 1.2,
        fontWeight: style?.fontWeight ??
            (accessibilitySettings.impairedMode
                ? FontWeight.bold
                : FontWeight.normal),
      );
    }

    if (accessibilitySettings.monochrome) {
      final Color? monochromeColor =
          accessibilitySettings.stringToColor(accessibilitySettings.textColor);

      textstyle =
          textstyle.copyWith(color: monochromeColor, backgroundColor: null);
    }

    if (accessibilitySettings.letterSpacing != 100) {
      textstyle = textstyle.copyWith(
        letterSpacing: (accessibilitySettings.letterSpacing - 100) / 10,
      );
    }

    if (accessibilitySettings.lineHeight > 0) {
      textstyle = textstyle.copyWith(
        height: (accessibilitySettings.lineHeight) / 10,
      );
    }

    return Text(
      data,
      textAlign: accessibilitySettings.textAlignment,
      style: textstyle,
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      // textScaleFactor: textScaleFactor,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

Size _textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
