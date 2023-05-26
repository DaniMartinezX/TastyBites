import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_bites/constants/routes.dart';
import 'package:tasty_bites/enums/menu_action.dart';
import 'package:tasty_bites/services/api/model/api_model.dart';
import 'package:tasty_bites/services/api/service/api_service.dart';
import 'package:tasty_bites/services/auth/bloc/auth_bloc.dart';
import 'package:tasty_bites/services/auth/bloc/auth_event.dart';
import 'package:tasty_bites/utilities/dialogs/logout_dialog.dart';

class RandomFoodPage extends StatefulWidget {
  const RandomFoodPage({Key? key}) : super(key: key);

  @override
  State<RandomFoodPage> createState() => _RandomFoodPageState();
}

class _RandomFoodPageState extends State<RandomFoodPage> {
  List<Meals>? _randomMeal;

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
    int currentIndex = 1;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tasty bites!"),
          backgroundColor: const Color.fromARGB(255, 234, 79, 32),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(searchFoodRoute);
              },
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      // ignore: use_build_context_synchronously
                      context.read<AuthBloc>().add(
                            const AuthEventLogOut(),
                          );
                    }
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text('Log out'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: _randomMeal == null || _randomMeal!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          //_randomMeal![index].strMealThumb.toString()
                          InkWell(
                            onTap: () {
                              print("Pulsado en el meal");
                            },
                            child: ClipOval(
                              child: Image.network(
                                _randomMeal![0].strMealThumb.toString(),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 234, 79, 32),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4.0),
                                bottomRight: Radius.circular(4.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  _randomMeal![0].strMeal.toString(),
                                  textAlign: TextAlign
                                      .center, // Reemplaza 'itemName' con el nombre real del item
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Roboto'),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _randomMeal![0].strCategory.toString(),
                                  textAlign: TextAlign
                                      .center, // Reemplaza 'itemName' con el nombre real del item
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Roboto'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.casino),
                      label: const Text("Get a random meal!"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 234, 79, 32)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(400, 100)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shuffle),
                label: 'Random',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              )
            ],
            currentIndex: currentIndex,
            onTap: (int index) {
              setState(() {
                currentIndex = index;
                //TODO switch
              });
            }));
  }
}
