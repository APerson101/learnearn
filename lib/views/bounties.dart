import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/api/bonties_api.dart';
import 'package:learnearn/layout/responsive_layout_builder.dart';
import 'package:learnearn/models/bounties_model.dart';

import 'bounty_details.dart';

final loadBounitesProvider = FutureProvider((ref) async {
  return await ref.watch(bountiesProvider).getAllBounties();
});

class BountiesView extends ConsumerWidget {
  const BountiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(loadBounitesProvider).when(data: (bounties) {
      return Stack(
        children: [
          const Positioned(top: 0, child: _TopBar()),
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                  child: _SearchResults(
                bounties: bounties,
              )))
        ],
      );
    }, error: (Object error, StackTrace? stackTrace) {
      return const Center(
        child: Text("Unknown Error"),
      );
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(small: (context, child) {
      //rerturn Multiple platform goals
      return Row(
        children: [
          Text(
            'Search through bounties!',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Search'))
        ],
      );
    }, medium: (context, child) {
      return Row(
        children: [
          Text(
            'Search through bounties!',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Search'))
        ],
      );
    }, large: (context, child) {
      return Row(
        children: [
          Text(
            'Search through bounties!',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Search'))
        ],
      );
    });
  }
}

class _SearchResults extends ConsumerWidget {
  final List<_SearchTile> allResults = [];
  List<BountiesModel> bounties;
  _SearchResults({
    required this.bounties,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    for (var i = 0; i < bounties.length; i++) {
      allResults.add(_SearchTile(searchResult: bounties[i]));
    }

    return Column(
      children: allResults,
    );
  }
}

class _SearchTile extends ConsumerWidget {
  const _SearchTile({required this.searchResult});
  final BountiesModel searchResult;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayoutBuilder(large: (context, child) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BountyDetailsView(
                    bounty: searchResult,
                  )));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: getTexts(searchResult, context)),
                  const VerticalDivider(),
                  getStats(searchResult, context)
                ]),
          ),
        ),
      );
    }, medium: (context, child) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(child: getTexts(searchResult, context)),
            const VerticalDivider(),
            getStats(searchResult, context)
          ]),
        ),
      );
    }, small: (context, child) {
      return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: getTexts(searchResult, context)),
                    const Divider(),
                    getStats(searchResult, context)
                  ],
                ),
              )));
    });
  }

  Widget getTexts(BountiesModel searchResult, BuildContext context) {
    return Column(
      children: [
        Text(searchResult.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(
          height: 20,
        ),
        Text(searchResult.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget getStats(BountiesModel searchResult, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'LRM ${searchResult.reward.toString()}',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${searchResult.views} views',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${searchResult.comments} comments',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
