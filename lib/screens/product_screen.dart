import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///F:/flutter_demo/ecom_app/lib/models/datamodel.dart';

class FoodItemSearch extends SearchDelegate<FoodData> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });

    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future.delayed(Duration(seconds: 2));
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            FoodData project = projectSnap.data[index];

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(project.engishName),
                  leading: Text(project.categories),
                ),
              ],
            );
          },
        );
      },
      future: loadData(),
    );
  }

  Future<List<FoodData>> loadData() async {
    String jsonString = await _loadAJsonAsset();
    return foodDataFromJson(jsonString);
  }

  Future<String> _loadAJsonAsset() async {
    return await rootBundle.loadString('assets/json/data.json');
  }
}

class ProductPage extends StatefulWidget {
  static const String id = 'task2';

  ProductPage();

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Task 2'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: null),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: FoodItemSearch());
              }),
          Expanded(
            child: Container(
              child: projectWidget(),
            ),
          ),
          IconButton(
              tooltip: "Logout",
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.green,
              ),
              onPressed: () async {
                SharedPreferences sharedPreferences;
                sharedPreferences.clear();
                sharedPreferences.commit();

                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<FoodData>> loadData() async {
    String jsonString = await _loadAJsonAsset();
    return foodDataFromJson(jsonString);
  }

  Widget projectWidget() {
    Future.delayed(Duration(seconds: 2));
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            FoodData project = projectSnap.data[index];

            return Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${project.categoryId} : ${project.categories}'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 80,
                              child: Image.asset("${project.image}"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: <Widget>[
                                Text(project.engishName),
                                Text('Price : ${project.price}'),
                              ],
                            ),
                          ],
                        ),
//                Text(project.categoryId),
//                Text(project.itemId),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      future: loadData(),
    );
  }

  Future<String> _loadAJsonAsset() async {
    return await rootBundle.loadString('assets/json/data.json');
  }
}
