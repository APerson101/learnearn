import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/providers/logged_in_provider.dart';
import 'package:learnearn/views/bounties.dart';

import 'dapp.dart';

final loggedinProvider =
    StateNotifierProvider<LoggedInStatus, LoggedInstate>((ref) {
  return LoggedInStatus(LoggedInstate.loggedIn);
});

class BaseScreen extends ConsumerWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStatus = ref.watch(loggedinProvider);
//if user is logged in, dashboard, otherwise take user to the bounties/new questions page

    if (userStatus == LoggedInstate.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      );
    } else if (userStatus == LoggedInstate.loggedOut) {
      return const Scaffold(
        body: BountiesView(),
      );
    }
    return const MainDapp();
  }
}
