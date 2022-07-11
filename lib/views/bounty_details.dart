import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/api/bonties_api.dart';
import 'package:learnearn/models/bounties_model.dart';
import 'package:learnearn/models/comment_model.dart';

final getCommentsProvider =
    FutureProvider.family<List<CommentModel>, String>((ref, id) async {
  return await ref.watch(bountiesProvider).getallBountyComments(id);
});

final newCommentProvider = StateProvider((ref) => "");

class BountyDetailsView extends ConsumerWidget {
  const BountyDetailsView({Key? key, required this.bounty}) : super(key: key);
  final BountiesModel bounty;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Text(bounty.title),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(child: Text(bounty.body)),
        ),
        Row(children: [
          Card(child: Text(bounty.reward.toString())),
          Card(
            child: Text(bounty.open.toString()),
          )
        ]),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child:
              ref.watch(getCommentsProvider(bounty.id!)).when(data: (comments) {
            return SingleChildScrollView(
              child: Column(children: [
                Row(children: [
                  TextField(
                    onChanged: (newtext) {
                      ref.watch(newCommentProvider.notifier).state = newtext;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Comment',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await ref.watch(bountiesProvider).addBountyComment(
                            bounty.id!,
                            CommentModel(
                                comment: ref.read(newCommentProvider),
                                userAddress: 'userAddress',
                                votes: 0));
                      },
                      child: const Text("save comment"))
                ]),
                ...comments.map((comment) {
                  return ListTile(
                    leading: Text((comments.indexOf(comment) + 1).toString()),
                    title: Text(comment.comment),
                    subtitle: Text("answered by: ${comment.userAddress}"),
                    trailing: Text(comment.votes.toString()),
                  );
                }).toList(),
              ]),
            );
          }, error: (Object error, StackTrace? stackTrace) {
            return const Center(child: Text("Error  loading comments"));
          }, loading: () {
            return const CircularProgressIndicator.adaptive();
          }),
        ),
      ])),
    );
  }
}
