import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/repositories/pokemon_data_repository.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

import '../bloc/bloc/all_pokemons_bloc.dart';

class AllPokemons extends StatefulWidget {
  const AllPokemons({Key? key}) : super(key: key);

  @override
  State<AllPokemons> createState() => _AllPokemonsState();
}

class _AllPokemonsState extends State<AllPokemons> {
  late final bloc = AllPokemonsBloc(
      repository: RepositoryProvider.of<PokemonDataRepository>(context));
  late ScrollController _scrollController;

  @override
  void initState() {
    bloc.add(const FetchPokemonsEvent());
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<AllPokemonsBloc, AllPokemonsState>(
          builder: (context, state) {
            if (state is AllPokemonsFetchingSuccess) {
              return NotificationListener(
                  onNotification: _handleScrollNotification,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.pokemons.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            PokemonCard(
                              pokemon: state.pokemons[index],
                            ),
                            Visibility(
                                visible: index == state.pokemons.length - 1 &&
                                    state.isFetchingNextPage,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ))
                          ],
                        );
                      }));
            }
            if (state is AllPokemonsFetching || state is AllPokemonsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Erro ao carregar'));
            }
          },
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final currentState = bloc.state;
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      if (currentState is AllPokemonsFetchingSuccess) {
        if (!currentState.isOnLastPage && !currentState.isFetchingNextPage) {
          bloc.add(const FetchPokemonsEvent());
        }
      }
    }
    return false;
  }
}
