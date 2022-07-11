import 'package:flutter/material.dart';

class SearchDel extends SearchDelegate {
  String search = '';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () => search = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back));
  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(search));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> allItems = [];
    allItems.add("Hello");
    allItems.add("World");
    allItems.add("Abdul");
    allItems.add("Hadi");
    allItems.add("Hashim");
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) =>
            ListTile(title: Text(allItems[index])));
  }
}
