import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final String age;
  final String gender;

  const DetailsScreen(
      {required this.age, required this.gender, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${name}\'s details',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Name: ',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Age: ',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            age,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Gender: ',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            gender,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 25,
          ),
        ]),
      ),
    );
  }
}
