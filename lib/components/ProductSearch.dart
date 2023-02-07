
import 'package:flutter/material.dart';
import 'package:richcollection/widgets/ProductDescriptiveView.dart';


class ProductSearch extends SearchDelegate{

  List<String> search = [];
  List<dynamic> allIds = [];

  Map<String,dynamic> filteredIds = {};

  ProductSearch(searchList,ids){
    this.search = searchList;
    this.allIds = ids;
  }

  @override
  List<Widget>? buildActions(BuildContext context)=> [IconButton(
      onPressed: (){
        if(query==""){
          close(context, null);
        }
        query = "";
      },
      icon: const Icon(Icons.clear)
  )];

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text(""),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    Map<String,String> filteredIds = {};
    List<String> suggestion = search.where((searchResult){
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);

    }).toList();

    for(var i=0;i<search.length;i++) {
      filteredIds[search[i]] = allIds[i];
    }

    return ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (context,index){
          final suggest = suggestion[index];

          return ListTile(
            title: Text(suggest),
            onTap:(){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDescriptiveView(filteredIds[suggest])));
            }
          );
        }
    );
  }

  @override
  Widget? buildLeading(BuildContext context)=> IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
  );

}