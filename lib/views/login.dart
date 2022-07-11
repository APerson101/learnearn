import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/views/import_status_indicator.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const Align(
                alignment: Alignment.center, child: Text("Import Wallet")),
            Align(
                alignment: Alignment.center,
                child: TextField(
                    onChanged: (seed) {
                      ref.watch(seedProvider.notifier).state = seed;
                    },
                    decoration:
                        const InputDecoration(hintText: "Enter seed phrase"))),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImportStatusIndicator(
                                callback: () => Navigator.of(context).pop(),
                              )));
                    },
                    child: const Text("Import wallet")))
          ],
        )),
      ),
    );
  }
}

final seedProvider = StateProvider((ref) => '');
