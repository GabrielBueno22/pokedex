import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_pokemon_details_event.dart';
part 'fetch_pokemon_details_state.dart';

class FetchPokemonDetailsBloc extends Bloc<FetchPokemonDetailsEvent, FetchPokemonDetailsState> {
  FetchPokemonDetailsBloc() : super(FetchPokemonDetailsInitial()) {
    on<FetchPokemonDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
