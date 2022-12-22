import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/repositories/pokemon_data_repository.dart';

part 'all_pokemons_event.dart';
part 'all_pokemons_state.dart';

class AllPokemonsBloc extends Bloc<AllPokemonsEvent, AllPokemonsState> {
  final PokemonDataRepository repository;
  AllPokemonsBloc({required this.repository}) : super(AllPokemonsInitial()) {
    on<AllPokemonsEvent>(_onFetch);
  }

  Future<void> _onFetch(
      AllPokemonsEvent event, Emitter<AllPokemonsState> emitter) async {
    final currentState = state;
    if ((currentState is AllPokemonsFetchingSuccess &&
            !currentState.isFetchingNextPage &&
            !currentState.isOnLastPage) ||
        currentState is! AllPokemonsFetching) {
      try {
        if (currentState is AllPokemonsFetchingSuccess) {
          emitter(currentState.copyWith(isFetchingNextPage: true));
          try {
            final nextPage = currentState.page + 1;
            final response =
                await repository.getAllPokemons(offset: currentState.page);

            final pokemonsIncomplete = response.results;
            var pokemonsComplete = [];
            for (var pokemon in pokemonsIncomplete) {
              final p = await repository.getPokemonsDetails(name: pokemon.name);
              pokemonsComplete.add(p);
            }

            emitter(
              currentState.copyWith(
                  isFetchingNextPage: false,
                  page: nextPage,
                  pokemons: [...currentState.pokemons, ...pokemonsComplete],
                  isOnLastPage: response.next == null),
            );
          } catch (e) {
            emitter(currentState.copyWith(isFetchingNextPage: false));
          }
        } else {
          final response = await repository.getAllPokemons(offset: 0);
          final pokemonsIncomplete = response.results;
          var pokemonsComplete = <Pokemon>[];
          for (var pokemon in pokemonsIncomplete) {
            final p = await repository.getPokemonsDetails(name: pokemon.name);
            pokemonsComplete.add(p);
          }

          emitter(
            AllPokemonsFetchingSuccess(
                isFetchingNextPage: false,
                page: 1,
                pokemons: pokemonsComplete,
                isOnLastPage: response.next == null),
          );
        }
      } catch (e) {
        emitter(AllPokemonsFetchingFailure());
      }
    }
  }
}
