import 'package:flutter/material.dart';

import 'color.dart';

const H1Size = 26.0;
const H2Size = 20.0;
const SubTitle = 18.0;
const BodyText = 14.0;
const CaptionText = 12.0;

const FontBold = FontWeight.w700;
const FontMedium = FontWeight.w500;
const FontRegular = FontWeight.w400;
const FontLight = FontWeight.w300;

const String FontNameDefault = "SF UI Text";

final ThemeData tLightGreener = ThemeData(
  scaffoldBackgroundColor: cWhite,
  textTheme: TextTheme(
    headline1: Headline1Style,
    subtitle1: Subtitle1Style,
    bodyText1: BodyText1Style,
    caption: CaptionTextStyle,
  ),
  sliderTheme: SliderThemeData(
    trackShape: CustomTrackShape(),
  ),
);

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

const Headline1Style = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontBold,
  fontSize: H1Size,
  color: cBlack,
);

const BodyText1Style = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontMedium,
  fontSize: BodyText,
);

const CaptionTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontRegular,
  fontSize: CaptionText,
  color: cGray,
);

const Subtitle1Style = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontRegular,
  fontSize: SubTitle,
  color: cGray,
);
