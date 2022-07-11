import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:learnearn/api/bonties_api.dart';
import 'package:learnearn/layout/responsive_layout_builder.dart';

class TopBar extends ConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveLayoutBuilder(small: (context, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [buttons(context, ref), personProfile()],
      );
    }, medium: (context, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          buttons(context, ref),
          personProfile()
        ],
      );
    }, large: (context, child) {
      return topBar(context, ref);
    });
  }
}

Widget personProfile() {
  return IconButton(onPressed: () {}, icon: const Icon(Icons.person));
}

topBar(BuildContext context, WidgetRef ref) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Spacer(),
      Text("Welcome!",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold)),
      const Spacer(),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 40,
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),
      ),
      const Spacer(),
      buttons(context, ref),
      const Spacer(),
      personProfile()
    ]),
  );
}

buttons(BuildContext context, WidgetRef ref) {
  String enteredquestion = '';
  String price = '';
  String title = '';
  return ElevatedButton(
    onPressed: () {
      Get.defaultDialog(
          title: "Enter New Question",
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    maxLines: 5,
                    onChanged: (_title) => title = _title,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[600],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Enter the title'),
                  ),
                  TextField(
                    maxLines: 5,
                    onChanged: (question) => enteredquestion = question,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[600],
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Enter the question you need help with'),
                  ),
                  DropdownButton<Subjects>(
                      value: ref.watch(activeSubjectDropDown),
                      items: Subjects.values.map((e) {
                        return DropdownMenuItem(
                          child: Text(describeEnum(e)),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (newsubject) {
                        ref.watch(activeSubjectDropDown.notifier).state =
                            newsubject!;
                      }),
                  TextField(
                    onChanged: (newprice) => price = newprice,
                    decoration: InputDecoration(
                        label: const Text("Set price"),
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'Set Bountry Prize in LRN Token'),
                  ),
                  ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () async {
                              // ref.watch(createBountiesProvider(BountiesModel(
                              //     title: title,
                              //     body: enteredquestion,
                              //     views: 0,
                              //     comments: 0,
                              //     subject: describeEnum(
                              //         ref.watch(activeSubjectDropDown)),
                              //     reward: int.parse(price),
                              //     open: true)));
                              await Future.delayed(
                                  const Duration(seconds: 2),
                                  () => Get.snackbar(
                                      "Confirmation", "New bounty created"));
                              Navigator.of(context).pop();
                            },
                            child: const Text("Confirm")),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel")),
                        const Spacer(),
                      ])
                ],
              ),
            ),
          ));
    },
    child: const Text("New Question"),
    //   // style: ElevatedButton.styleFrom(
    //   //     minimumSize: const Size(100, 75),
    //   //     shape: RoundedRectangleBorder(
    //   //         borderRadius: BorderRadius.circular(20))),
  );
}

enum Subjects {
  physics,
  chemistry,
  calculus,
  linearAlgebra,
}
