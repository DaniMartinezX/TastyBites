import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomFoodPage extends StatefulWidget {
  const RandomFoodPage({super.key});

  @override
  State<RandomFoodPage> createState() => _RandomFoodPageState();
}

class _RandomFoodPageState extends State<RandomFoodPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Hola',
            style: TextStyle(fontSize: 80),
          ),
        ],
      ),
    ));
  }
}
