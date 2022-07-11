import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learnearn/api/bonties_api.dart';
import 'package:learnearn/layout/dapp_brekpoints.dart';
import 'package:learnearn/layout/responsive_layout_builder.dart';
import 'package:learnearn/models/wallet_model.dart';
import 'package:learnearn/providers/base_screen_provider.dart';
import 'package:learnearn/views/dashboard.dart';
import 'package:learnearn/views/login.dart';
import 'package:learnearn/views/search_delegate.dart';
import 'package:learnearn/views/txns.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'bounties.dart';

final baseProvider =
    StateNotifierProvider<BaseScreenProvider, ScreensEnum>((ref) {
  return BaseScreenProvider(ScreensEnum.dashboard);
});

class MainDapp extends ConsumerWidget {
  const MainDapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: const _MainContent(),
      bottomNavigationBar:
          MediaQuery.of(context).size.width <= DappBreakPoints.small
              ? const NavBar()
              : null,
    );
  }
}

class _MainContent extends ConsumerWidget {
  const _MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayoutBuilder(
        small: (context, child) => SingleChildScrollView(
              child: Column(children: const [DappHeader(), DappSections()]),
            ),
        medium: (context, child) => const _MediumLargeView(),
        large: (context, child) => const _MediumLargeView());
  }
}

class _MediumLargeView extends ConsumerWidget {
  const _MediumLargeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: const [
        Positioned(left: 10, right: 10, height: 50, child: DappHeader()),
        Positioned(
          left: 10,
          top: 50,
          bottom: 10,
          width: 100,
          child: NavRail(),
        ),
        Positioned(
          left: 120,
          top: 60,
          right: 10,
          bottom: 10,
          child: DappSections(),
        )
      ],
    );
  }
}

class DappHeader extends ConsumerWidget {
  const DappHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: FlutterLogo(),
                ),
                const Align(
                  child: Text('0x5gr4...4fdg4'),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: SearchDel());
                      },
                      icon: const Icon(Icons.search)),
                )
              ],
            ),
          )),
      medium: (_, __) {
        Wallet? wallet = ref.watch(bountiesProvider).wallet;
        return Row(children: [
          const Spacer(),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: Text(wallet == null ? "Import Wallet" : "Sign Out")),
        ]);
      },
      large: (_, __) {
        Wallet? wallet = ref.watch(bountiesProvider).wallet;
        print('wallet status is $wallet:');
        return Row(children: [
          const Spacer(),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: Text(wallet == null ? "Import Wallet" : "Sign Out")),
        ]);
      },
    );
  }

  qrCode(String? uri) async {
    await Get.defaultDialog(
      content: SizedBox(width: 500, height: 500, child: QrImage(data: uri!)),
    );
  }

  connectionCallBack(bool status) {
    if (status) {
      Get.back();

      Get.snackbar(
        "Connection",
        "Connection Successful",
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.back();

      Get.snackbar(
        "Connection",
        "Failed to Connect",
        duration: const Duration(seconds: 2),
      );
    }
  }
}

class DappSections extends ConsumerWidget {
  const DappSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentView = ref.watch(baseProvider);

    return ResponsiveLayoutBuilder(
      small: (context, child) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                right: 0,
                child: getView(currentView),
              ),
            ],
          ),
        ),
      ),
      medium: (context, child) => getView(currentView),
      large: (context, child) => getView(currentView),
    );
  }

  Widget getView(currentView) {
    switch (currentView) {
      case ScreensEnum.dashboard:
        return const DashboardView();
      case ScreensEnum.bounties:
        return const BountiesView();
      case ScreensEnum.activityHistory:
        return const TxnsView();
      default:
        return Container();
    }
  }
}

class NavRail extends ConsumerWidget {
  @override
  const NavRail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
        labelType: NavigationRailLabelType.selected,
        useIndicator: true,
        selectedLabelTextStyle: const TextStyle(color: Colors.lightBlue),
        unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
        indicatorColor: Colors.blueAccent,
        destinations: [
          ...ScreensEnum.values.map((screen) {
            Widget icon;
            String label;
            switch (screen) {
              case ScreensEnum.dashboard:
                icon = const Icon(Icons.dashboard);
                label = "Dashboard";
                break;
              case ScreensEnum.activityHistory:
                icon = const Icon(Icons.history);
                label = "History";
                break;
              case ScreensEnum.bounties:
                icon = const Icon(Icons.list);
                label = "Bounties";
                break;
              case ScreensEnum.notifications:
                icon = const Icon(Icons.notifications);
                label = "Notifications";
                break;
            }
            return NavigationRailDestination(icon: icon, label: Text(label));
          }).toList()
        ],
        selectedIndex: ScreensEnum.values.indexOf(ref.watch(baseProvider)),
        onDestinationSelected: (selected) => ref
            .watch(baseProvider.notifier)
            .changeScreen(ScreensEnum.values[selected]));
  }
}

class NavBar extends ConsumerWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        onTap: (selected) => ref
            .watch(baseProvider.notifier)
            .changeScreen(ScreensEnum.values[selected]),
        currentIndex: ScreensEnum.values.indexOf(ref.watch(baseProvider)),
        items: ScreensEnum.values.map((screen) {
          Widget icon;
          String label;
          switch (screen) {
            case ScreensEnum.dashboard:
              icon = const Icon(Icons.dashboard);
              label = "Dashboard";
              break;
            case ScreensEnum.activityHistory:
              icon = const Icon(Icons.history);
              label = "History";
              break;
            case ScreensEnum.bounties:
              icon = const Icon(Icons.list);
              label = "Bounties";
              break;
            case ScreensEnum.notifications:
              icon = const Icon(Icons.notifications);
              label = "Notifications";
              break;
          }
          return BottomNavigationBarItem(icon: icon, label: label);
        }).toList());
  }
}
