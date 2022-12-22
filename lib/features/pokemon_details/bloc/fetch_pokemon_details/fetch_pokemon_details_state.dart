part of 'fetch_pokemon_details_bloc.dart';

abstract class FetchPokemonDetailsState extends Equatable {
  const FetchPokemonDetailsState();
  
  @override
  List<Object> get props => [];
}

class FetchPokemonDetailsInitial extends FetchPokemonDetailsState {}
