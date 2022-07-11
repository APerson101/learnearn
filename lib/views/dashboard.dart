import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/layout/responsive_layout_builder.dart';
import 'package:learnearn/widgets/balance_stats.dart';
// import 'package:get/get.dart';
import 'package:learnearn/widgets/top_bar.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayoutBuilder(
        small: (context, child) {
          return SingleChildScrollView(
            child: Column(children: const [
              BalanceStats(),
              _LatestActivity(),
              _PendingTxns()
            ]),
          );
        },
        medium: (context, child) => const _DashboardViewLargeMedium(),
        large: (context, child) => const _DashboardViewLargeMedium());
  }
}

class _DashboardViewLargeMedium extends ConsumerWidget {
  const _DashboardViewLargeMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color.fromARGB(255, 54, 54, 54),
      child: Stack(
        children: [
          const Positioned(top: 0, left: 0, right: 0, child: TopBar()),
          const Positioned(top: 70, left: 20, right: 20, child: BalanceStats()),
          Positioned(
              bottom: 20,
              left: 20,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: const _LatestActivity()),
          Positioned(
              right: 20,
              bottom: 20,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.3,
              child: const _PendingTxns())
        ],
      ),
    );
  }
}

class _LatestActivity extends StatelessWidget {
  const _LatestActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Latest Activity",
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: Text(
                          "You booked a tutorial with xch...0458 for 1:30 Pm on 12/2/22",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: Text(
                          "You answered a question asked by xch...58343 for LRN 40",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: Text(
                          "You voted on 'Increase in pay'",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

class _PendingTxns extends StatelessWidget {
  const _PendingTxns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Pending Transactions",
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.input),
                    title: Text(
                      "Incoming payment for question answered",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    trailing: Text(
                      "\$LRN 50",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.input),
                        title: Text(
                          "Incoming payment for question answered",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Text(
                          "\$LRN 50",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Colors.green),
                        ),
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.outbond),
                        title: Text(
                          "Outgoing payment for question asked",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Text(
                          "\$LRN 500",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Colors.green),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
