import 'package:flutter/material.dart';
import 'package:pokedex/features/custom_pokemons/screens/add_pokemons.dart';
import 'package:pokedex/models/Pokemon.dart';

import '../../../widgets/pokemon_card.dart';

class CustomPokemons extends StatefulWidget {
  const CustomPokemons({Key? key}) : super(key: key);

  @override
  State<CustomPokemons> createState() => _CustomPokemonsState();
}

class _CustomPokemonsState extends State<CustomPokemons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My pokedex'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const AddPokemons(),
              ),
            );
          }),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const PokemonCard(
              pokemon: Pokemon(name: 'Meu pokemon', id: 1),
            );
          }),
    );
  }
}
