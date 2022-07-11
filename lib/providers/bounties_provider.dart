import 'package:get/get.dart';
import 'package:learnearn/api/bonties_api.dart';
import 'package:learnearn/models/bounties_model.dart';

class BountiesProvider {
  final BountiesAPI _api = BountiesAPI();
  RxString title = ''.obs;
  RxString body = ''.obs;
  RxString subject = ''.obs;
  RxList<String> hashtags = <String>[].obs;
  RxInt reward = 0.obs;
  RxBool timeBound = false.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  addBounty() {
    BountiesModel bounty;
    if (!timeBound.value) {
      bounty = BountiesModel(
          body: body.value,
          comments: 0,
          open: true,
          reward: reward.value,
          subject: subject.value,
          title: title.value,
          views: 0);
    } else {
      bounty = BountiesModel(
          body: body.value,
          startTime: startDate.value,
          endTime: endDate.value,
          comments: 0,
          open: true,
          reward: reward.value,
          subject: subject.value,
          title: title.value,
          views: 0);
    }

    _api.createBounty(bounty);
  }
}
