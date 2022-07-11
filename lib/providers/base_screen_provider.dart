import 'package:riverpod/riverpod.dart';

enum ScreensEnum { dashboard, activityHistory, bounties, notifications }

class BaseScreenProvider extends StateNotifier<ScreensEnum> {
  BaseScreenProvider(ScreensEnum state) : super(state);

  changeScreen(ScreensEnum newScreen) {
    state = newScreen;
  }
}
