part of 'custom_pokemon_bloc.dart';

abstract class CustomPokemonState extends Equatable {
  const CustomPokemonState();
  
  @override
  List<Object> get props => [];
}

class CustomPokemonInitial extends CustomPokemonState {}
