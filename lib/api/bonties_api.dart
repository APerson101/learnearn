import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnearn/main.dart';
import 'package:learnearn/models/bounties_model.dart';
import 'package:learnearn/models/wallet_model.dart';
import 'package:learnearn/widgets/top_bar.dart';

import '../models/comment_model.dart';

final activeUser = Provider((ref) {
  var wat = ref.watch(walletProvider);
  return wat.activeUserAddress;
});

final createBountiesProvider =
    FutureProvider.family<void, BountiesModel>((ref, model) async {
  await ref.watch(bountiesProvider).createBounty(model);
});

final activeSubjectDropDown = StateProvider((ref) => Subjects.calculus);

final bountiesProvider = Provider((ref) {
  return BountiesAPI();
});

final getWalletProvider =
    StateProvider((ref) => ref.watch(bountiesProvider).wallet);

class BountiesAPI {
  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;
  BountiesAPI() {
    _firebaseFunctions.useFunctionsEmulator('localhost', 5001);
  }
  Wallet? wallet;
  createBounty(BountiesModel model) async {
    /**
     * get bounty, 
     * save to firebase
     * create smart contract:
     *  
     */
    var callable = _firebaseFunctions.httpsCallable(
      'addBounty',
    );
    var response = await callable.call({'bounty': model.toMap()});
    print(response.data);
  }

  deleteBounty(String bountyID) async {
    var callable = _firebaseFunctions.httpsCallable(
      'deleteBounty',
    );
    var response = await callable.call({'bounty_id': bountyID});
    print(response.data);
  }

  addBountyComment(String bountyID, CommentModel commentData) async {
    var callable = _firebaseFunctions.httpsCallable(
      'addBountyComment',
    );
    var response = await callable
        .call({'bounty_id': bountyID, 'comment_data': commentData.toJson()});
    print(response.data);
  }

  deleteBountyComment(String bountyId, String commentID) async {
    var callable = _firebaseFunctions.httpsCallable(
      'deleteBountyComment',
    );
    var response =
        await callable.call({'bounty_id': bountyId, 'comment_id': commentID});
    print(response.data);
  }

  Future<List<BountiesModel>> getAllBounties() async {
    var callable = _firebaseFunctions.httpsCallable('getAllBounties');
    var response = await callable.call();
    var list = response.data as List;
    List<BountiesModel> allBounties = [];
    for (var item in list) {
      item as Map<String, dynamic>;
      allBounties.add(BountiesModel.fromMap(item));
    }
    for (var i = 0; i < 5; i++) {
      allBounties.add(BountiesModel(
          title: 'sample title',
          body: "Sample Body",
          views: 4,
          id: '4421',
          comments: 5,
          subject: 'Calculus',
          reward: 40,
          open: true));
    }
    return allBounties;
  }

  downvoteBounty() {}
  setBountyStatus(bool isOpen) {}
  increaseViewCount() {}
  Future<Wallet> getWallletFromSeed({required String seed}) async {
    var callable = _firebaseFunctions.httpsCallable('getWalletFromSeed');
    var response = await callable.call({'seed': seed});
    wallet = Wallet.fromMap(response.data);
    print(wallet.toString());
    return Wallet.fromMap(response.data);
  }

  Future<List<CommentModel>> getallBountyComments(String id) async {
    List<CommentModel> comments = [];
    for (var i = 0; i < 5; i++) {
      comments.add(CommentModel(
          comment: 'the answer to this is',
          userAddress: '787234rhj',
          votes: 4));
    }
    // var callable = _firebaseFunctions.httpsCallable('getAllComments');
    // var response = await callable.call({'id': id});
    // var list = response.data as List;
    // for (var item in list) {
    //   comments.add(CommentModel.fromMap(item));
    // }
    return comments;
  }
}
