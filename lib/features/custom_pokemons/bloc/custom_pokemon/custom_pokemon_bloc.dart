import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'custom_pokemon_event.dart';
part 'custom_pokemon_state.dart';

class CustomPokemonBloc extends Bloc<CustomPokemonEvent, CustomPokemonState> {
  CustomPokemonBloc() : super(CustomPokemonInitial()) {
    on<CustomPokemonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
