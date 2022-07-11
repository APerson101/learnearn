import 'package:algorand_dart/src/models/assets/asset_holding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/layout/dapp_brekpoints.dart';
import 'package:learnearn/layout/responsive_layout_builder.dart';
import 'package:learnearn/main.dart';

final assets = FutureProvider((ref) {
  return ref.watch(walletProvider).getAssets();
});

class BalanceStats extends StatelessWidget {
  const BalanceStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
        small: (context, child) => Column(
              children: const [_Stats()],
            ),
        medium: (context, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [Spacer(), _Stats()],
            ),
        large: (context, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [Spacer(), _Stats()],
            ));
  }
}

class _Balance extends ConsumerWidget {
  const _Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(assets).when(
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stack) => const Center(child: Text("ERROR")),
        data: (assets) => ResponsiveLayoutBuilder(
            small: (context, child) => _balance(context, 0.8, assets),
            medium: (context, child) => _balance(context, 0.3, assets),
            large: (context, child) => _balance(context, 0.3, assets)));
  }

  Widget _balance(
      BuildContext context, double width, List<AssetHolding> assets) {
    AssetHolding learnAsset =
        assets.where((lrn) => lrn.assetId == 78993896).first;
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width * width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                  text: TextSpan(
                      text: "Balance:   ",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                      text: "\$LRN ${learnAsset.amount}",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    )
                  ])),
              Text(
                "(\$ 500)",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ));
  }
}

class _Stats extends StatelessWidget {
  const _Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontsize =
        MediaQuery.of(context).size.width <= DappBreakPoints.medium ? 15 : 20;
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Visits\n",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: fontsize),
                        children: [
                      TextSpan(
                        text: '1.2K',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: fontsize),
                      )
                    ])),
                RichText(
                    text: TextSpan(
                        text: "Hunted\n",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: fontsize),
                        children: [
                      TextSpan(
                        text: '900',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: fontsize),
                      )
                    ])),
                RichText(
                    text: TextSpan(
                        text: "Answered\n",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: fontsize),
                        children: [
                      TextSpan(
                        text: '450',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: fontsize),
                      )
                    ])),
              ],
            )));
  }
}
