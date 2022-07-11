import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/layout/responsive_layout_builder.dart';
import 'package:learnearn/providers/base_screen_provider.dart';
import '../views/dapp.dart';

class ContextMenuItem extends ConsumerWidget {
  const ContextMenuItem({
    Key? key,
    required this.view,
    required this.iconImage,
  }) : super(key: key);
  final ScreensEnum view;
  final String iconImage;
//What am I suppposed to do now that things are like this
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayoutBuilder(
      large: (context, child) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            onTap: () {
              ref.watch(baseProvider.notifier).changeScreen(view);
            },
            title: Text(describeEnum(view)),
            leading: ImageIcon(
              AssetImage(iconImage),
              size: 24,
              // color: isActive ? null : Colors.grey,
            ),
          ),
        ),
      ),
      medium: (context, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                ref.watch(baseProvider.notifier).changeScreen(view);
              },
              icon: ImageIcon(
                AssetImage(iconImage),
                size: 24,
              ))),
      small: (_, __) => Container(),
    );
  }
}
