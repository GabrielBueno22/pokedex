import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/home/screens/home_screen.dart';
import 'package:pokedex/repositories/pokemon_data_repository.dart';
import 'package:pokedex/utils/dio_http_client.dart';
import 'package:pokedex/utils/interfaces/ihttp_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _client = DioHttpClient(client: Dio());
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IHttpClient>.value(value: _client),
        RepositoryProvider<PokemonDataRepository>(
          create: (context) =>
              PokemonDataRepository(client: RepositoryProvider.of(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 2,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
