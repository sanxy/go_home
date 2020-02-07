import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for properties"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final results = ['Result 1', 'Result 2', 'Result 3', 'Result 4'];

  final recentResults = ['Result 1', 'Result 2'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // build actions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: null,
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: null,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on selecion
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone searches for something
    final suggestionList = query.isEmpty ? recentResults : results;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.home),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
