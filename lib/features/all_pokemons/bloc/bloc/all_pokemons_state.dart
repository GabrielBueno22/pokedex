part of 'all_pokemons_bloc.dart';

abstract class AllPokemonsState extends Equatable {
  const AllPokemonsState();

  @override
  List<Object?> get props => [];
}

class AllPokemonsInitial extends AllPokemonsState {}

class AllPokemonsFetching extends AllPokemonsState {}

class AllPokemonsFetchingSuccess extends AllPokemonsState {
  final bool isFetchingNextPage;
  final List<Pokemon> pokemons;
  final int page;
  final bool isOnLastPage;

  const AllPokemonsFetchingSuccess({
    required this.isFetchingNextPage,
    required this.pokemons,
    required this.page,
    required this.isOnLastPage,
  });

  AllPokemonsFetchingSuccess copyWith(
      {bool? isFetchingNextPage,
      List<Pokemon>? pokemons,
      int? page,
      bool? isOnLastPage,
      int? total}) {
    return AllPokemonsFetchingSuccess(
        isFetchingNextPage: isFetchingNextPage ?? this.isFetchingNextPage,
        pokemons: pokemons ?? this.pokemons,
        page: page ?? this.page,
        isOnLastPage: isOnLastPage ?? this.isOnLastPage);
  }

  @override
  List<Object?> get props => [isFetchingNextPage, pokemons, page, isOnLastPage];
}

class AllPokemonsFetchingFailure extends AllPokemonsState {}
