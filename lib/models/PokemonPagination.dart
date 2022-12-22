import 'package:pokedex/models/Pokemon.dart';

class PokemnPagination {
  PokemnPagination({
    required this.count,
    this.next,
    required this.results,
  });

  final int count;
  final String? next;
  final List<Pokemon> results;

  factory PokemnPagination.fromJson(Map<String, dynamic> json) =>
      PokemnPagination(
        count: json["count"],
        next: json["next"],
        results:
            List<Pokemon>.from(json["results"].map((x) => Pokemon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
