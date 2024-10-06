import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../apiDartFile_QuickType/userModel.dart';

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  List<UserModel> userList = [];
  bool isLoading = true;

  Future<void> getUser() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        userList = jsonResponse.map((data) => UserModel.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ReusableRow(title: 'Name', value: userList[index].name),
                      ReusableRow(
                          title: 'Username', value: userList[index].username),
                      ReusableRow(
                          title: 'Email', value: userList[index].email),
                      ReusableRow(
                          title: 'address', value: userList[index].address.city),
                    ],
                  ),
                ));
          },
        ));
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
