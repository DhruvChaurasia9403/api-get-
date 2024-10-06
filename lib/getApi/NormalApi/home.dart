import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../apiDartFile_QuickType/post_model.dart'; // Ensure your PostModel file is correctly named

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPost() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      postList = data.map((post) => PostModel.fromJson(post)).toList();
      return postList;
    } else {
      return postList;
    }
  }

  Color getColorByIndex(int index) {
    // You can create a color-changing logic based on index or return a static color
    return index % 2 == 0 ? Colors.blue.shade50 : Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<PostModel>>(
              future: getPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4.0, // Add elevation for shadow effect
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ), // Add margin around cards
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          // ListTile inside the Card
                          title: Text(
                            snapshot.data![index].title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(snapshot.data![index].body),
                          tileColor: getColorByIndex(index),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No posts available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
