import 'package:flutter/material.dart';

import '../../all_pokemons/screens/all_pokemons.dart';
import '../../custom_pokemons/screens/custom_pokemons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Pokemons',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: 'My pokemons',
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
        body:
            _currentIndex == 0 ? const AllPokemons() : const CustomPokemons());
  }
}
