import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learnearn/api/wallet_api.dart';
import 'package:learnearn/providers/logged_in_provider.dart';
import 'package:learnearn/views/base_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final loggedinProvider =
    StateNotifierProvider<LoggedInStatus, LoggedInstate>((ref) {
  return LoggedInStatus(LoggedInstate.loggedOut);
});

final walletProvider = Provider((ref) => WalletAPI());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: const BaseScreen(),
    );
  }
}
