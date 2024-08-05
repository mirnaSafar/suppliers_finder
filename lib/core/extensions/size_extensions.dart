import 'package:flutter/widgets.dart';

extension ScreenSize on BuildContext {
  double screenWidth(double percent) {
    final width = MediaQuery.of(this).size.width;
    return width / percent;
  }

  double screenHeight(double percent) {
    final height = MediaQuery.of(this).size.height;
    return height / percent;
  }
}
