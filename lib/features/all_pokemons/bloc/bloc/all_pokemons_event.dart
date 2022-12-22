part of 'all_pokemons_bloc.dart';

abstract class AllPokemonsEvent extends Equatable {
  const AllPokemonsEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonsEvent extends AllPokemonsEvent {
  const FetchPokemonsEvent();

  @override
  List<Object> get props => [];
}
