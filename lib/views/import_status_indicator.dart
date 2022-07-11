import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/api/bonties_api.dart';
import 'package:learnearn/models/wallet_model.dart';
import 'package:learnearn/views/login.dart';

final _importWalletProvider =
    FutureProvider.family<Wallet, String>((ref, seed) async {
  return ref.watch(bountiesProvider).getWallletFromSeed(seed: seed);
});

class ImportStatusIndicator extends ConsumerWidget {
  const ImportStatusIndicator({Key? key, required this.callback})
      : super(key: key);

  final VoidCallback callback;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(_importWalletProvider(ref.read(seedProvider))).when(
        data: (wallet) {
          return Material(
            child: Center(
              child: ListTile(
                tileColor: Colors.grey,
                onTap: () {
                  callback();
                  Navigator.of(context).pop();
                },
                title: const Align(
                    alignment: Alignment.center,
                    child: Text("Import successful")),
                subtitle: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_outlined))),
              ),
            ),
          );
        },
        error: (err, r) {
          return const Center(child: Text("Invalid seed phrase"));
        },
        loading: () => const CircularProgressIndicator.adaptive());
  }
}
