import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home4 extends StatefulWidget {
  const Home4({super.key});

  @override
  State<Home4> createState() => _Home4State();
}

class _Home4State extends State<Home4> {

  var data;
  Future<void> getUserApi () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home4'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder:(context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }else if(snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }else{
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReUsable(title: 'name', value: data[index]['name'].toString()),
                              ReUsable(title: 'address', value: data[index]['address']['city'].toString()),
                              ReUsable(title: 'address', value: data[index]['address']['geo']['lng'].toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }, future: getUserApi(),
            )
          )
        ],
      ),
    );
  }
}
class ReUsable extends StatelessWidget {
  final String title;
  final String value;
  ReUsable({Key? key , required this.title, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value)
      ],
    );
  }
}
