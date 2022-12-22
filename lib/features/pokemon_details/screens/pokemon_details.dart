import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/utils/constants.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetails({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeadWidget(
                name: widget.pokemon.name,
                imageUrlId: widget.pokemon.id!,
                typeElement: widget.pokemon.types!.first,
              ),
              ContentWidget(abilities: widget.pokemon.abilities!)
            ],
          ),
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final List<AbilityElement> abilities;
  const ContentWidget({super.key, required this.abilities});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Abilities',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          Column(
            children: abilities
                .map((e) => Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_right),
                          Text(e.ability.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class HeadWidget extends StatelessWidget {
  final String name;
  final TypeElement typeElement;
  final int imageUrlId;
  const HeadWidget(
      {Key? key,
      required this.name,
      required this.imageUrlId,
      required this.typeElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        color: Color(allTypeColors[typeElement.type.name]!).withOpacity(0.5),
      ),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back)),
          ),
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(allTypeColors[typeElement.type.name]!),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      typeElement.type.name,
                    ),
                  ),
                ),
                Text('#$imageUrlId',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Color(allTypeColors[typeElement.type.name]!)
                      .withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Hero(
              tag: 0,
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl:
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$imageUrlId.png',
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
