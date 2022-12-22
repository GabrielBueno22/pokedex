import 'package:flutter/foundation.dart';
import 'package:pokedex/env.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/models/PokemonPagination.dart';

import '../utils/interfaces/ihttp_client.dart';

class PokemonDataRepository {
  final IHttpClient client;

  PokemonDataRepository({required this.client});

  Future<PokemnPagination> getAllPokemons({required int offset}) async {
    const limit = 7;
    final pageOffset = limit * offset;
    final response = await client
        .get('$pokedexApiUrl/pokemon?limit=$limit&offset=$pageOffset');
    return PokemnPagination.fromJson(response);
  }

  Future<Pokemon> getPokemonsDetails({required String name}) async {
    final response = await client.get('$pokedexApiUrl/pokemon/$name');
    return compute(Pokemon.fromJson, response);
  }
}
