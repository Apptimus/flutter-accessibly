import 'package:accessibly/accessibly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessiblyHeadingText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  const AccessiblyHeadingText(this.data,
      {super.key,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.textHeightBehavior,
      this.selectionColor});

  @override
  Widget build(BuildContext context) {
    final accessibilitySettings = context.watch<Accessibly>();

    final Color? textColor = style?.color;
    final Color? fallbackColor =
        accessibilitySettings.stringToColor(accessibilitySettings.headingColor);

    final bool isBlackOrWhite =
        textColor == Colors.black || textColor == Colors.white;

    final Color? finalColor =
        isBlackOrWhite ? fallbackColor : textColor ?? fallbackColor;

    final boxBorder = accessibilitySettings.cognitiveMode
        ? Border.all(color: Colors.blue, width: 2.0)
        : null;

    const baseFontSize = 20.0;

    return Container(
      padding: accessibilitySettings.cognitiveMode
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: style?.backgroundColor ?? accessibilitySettings.textBgColor,
        border: boxBorder,
      ),
      child: Text(
        data,
        textAlign: textAlign ?? accessibilitySettings.textAlignment,
        style: (style ?? const TextStyle()).copyWith(
          fontWeight: style?.fontWeight ??
              (accessibilitySettings.impairedMode
                  ? FontWeight.bold
                  : FontWeight.normal),
          fontSize: ((style?.fontSize ?? baseFontSize) *
              (accessibilitySettings.textScaleFactor / 100) *
              (accessibilitySettings.impairedMode ? 1.2 : 1)),
          color: finalColor,
          height: accessibilitySettings.lineHeight,
          letterSpacing: accessibilitySettings.letterSpacing,
        ),
        strutStyle: strutStyle,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
