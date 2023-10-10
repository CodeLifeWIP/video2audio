import 'package:flutter/material.dart';

class AppBarSearch extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        if(query.isEmpty){
          close(context, null);
        }else{
          query = '';
        }
      }, icon: const Icon(Icons.clear),),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

  }

  @override
  Widget buildResults(BuildContext context) {

    return InkWell(
      onTap: () {close(context, null);},
      child: Container(
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}
