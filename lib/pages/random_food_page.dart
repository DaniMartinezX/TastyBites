import 'package:flutter/material.dart';
import 'package:tasty_bites/services/api/model/api_model.dart';
import 'package:tasty_bites/services/api/service/api_service.dart';

class RandomFoodPage extends StatefulWidget {
  const RandomFoodPage({super.key});

  @override
  State<RandomFoodPage> createState() => _RandomFoodPageState();
}

class _RandomFoodPageState extends State<RandomFoodPage> {
  late List<Meals>? _randomMeal = [];

  @override
  void initState() {
    super.initState();
    _getDataRandom();
  }

  void _getDataRandom() async {
    _randomMeal = (await ApiService().getRandomMeal())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _randomMeal == null || _randomMeal!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _randomMeal!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      //_randomMeal![index].strMealThumb.toString()
                      Image.network(
                        _randomMeal![0].strMealThumb.toString(),
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
