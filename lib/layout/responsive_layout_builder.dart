import 'package:flutter/material.dart';
import 'package:learnearn/layout/dapp_brekpoints.dart';

enum ResponsiveLayoutSize { small, medium, large }
typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder(
      {Key? key,
      required this.small,
      required this.medium,
      required this.large,
      this.child})
      : super(key: key);

  final ResponsiveLayoutWidgetBuilder small;

  final ResponsiveLayoutWidgetBuilder medium;

  final ResponsiveLayoutWidgetBuilder large;

  final Widget Function(ResponsiveLayoutSize currentSize)? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth <= DappBreakPoints.small) {
        return small(context, child?.call(ResponsiveLayoutSize.small));
      }

      if (screenWidth <= DappBreakPoints.medium) {
        return medium(context, child?.call(ResponsiveLayoutSize.medium));
      }

      if (screenWidth <= DappBreakPoints.large) {
        return large(context, child?.call(ResponsiveLayoutSize.large));
      }
      return large(context, child?.call(ResponsiveLayoutSize.large));
    }));
  }
}
