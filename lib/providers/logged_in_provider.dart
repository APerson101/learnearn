import 'package:riverpod/riverpod.dart';

enum LoggedInstate { loggedIn, loggedOut, loading }

class LoggedInStatus extends StateNotifier<LoggedInstate> {
  LoggedInStatus(state) : super(state);

  bool logIn() {
    state = LoggedInstate.loading;
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      state = LoggedInstate.loggedIn;
    });

    return true;
  }

  bool logOut() {
    state = LoggedInstate.loading;
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      state = LoggedInstate.loggedOut;
    });
    return true;
  }
}
