import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../features/pokemon_details/screens/pokemon_details.dart';
import '../models/Pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(width: 0.5)),
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => PokemonDetails(
                pokemon: pokemon,
              ),
            ),
          );
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pokemon.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl:
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
