import 'dart:convert';

import 'package:apipart2integration/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UsersData> userData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
          'The HTTP API INTEGRATION',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(17)),

                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  height: 290,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(index, 'ID: ', userData[index].id.toString()),
                        getText(
                            index, 'Name: ', userData[index].name.toString()),
                        getText(
                            index, 'Email: ', userData[index].email.toString()),
                        getText(
                            index, 'Phone: ', userData[index].phone.toString()),
                        getText(index, 'Website: ',
                            userData[index].website.toString()),
                        getText(index, 'Company Name: :',
                            '${userData[index].company.name.toString()}, ${userData[index].company.catchPhrase.toString()} , ${userData[index].company.bs.toString()}'),
                        getText(index, 'Adrress: ',
                            '${userData[index].address.suite.toString()}, ${userData[index].address.street.toString()}, ${userData[index].address.city.toString()} , - ${userData[index].address.zipcode.toString()}, ${userData[index].address.geo.toString()}'),
                      ]),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: fieldName,
            style: (const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
          ),
          TextSpan(
            text: content,
            style: (const TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<List<UsersData>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userData.add(UsersData.fromJson(index));
      }
      return userData;
    } else {
      return userData;
    }
  }
}
