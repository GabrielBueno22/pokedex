// ignore: file_names
import 'dart:convert';

import 'package:equatable/equatable.dart';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon extends Equatable {
  const Pokemon({
    this.abilities,
    this.id,
    required this.name,
    this.order,
    this.types,
  });

  final List<AbilityElement>? abilities;
  final int? id;
  final String name;
  final int? order;
  final List<TypeElement>? types;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        abilities: json["abilities"] == null
            ? null
            : List<AbilityElement>.from(
                json["abilities"].map((x) => AbilityElement.fromJson(x))),
        id: json["id"],
        name: json["name"],
        order: json["order"],
        types: json["types"] == null
            ? null
            : List<TypeElement>.from(
                json["types"].map((x) => TypeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "abilities": abilities == null
            ? null
            : List<dynamic>.from(abilities!.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "order": order,
        "types": types == null
            ? null
            : List<dynamic>.from(types!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [abilities, id, name, order, types];
}

class AbilityElement extends Equatable {
  const AbilityElement({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  final Ability ability;
  final bool isHidden;
  final int slot;

  factory AbilityElement.fromJson(Map<String, dynamic> json) => AbilityElement(
        ability: Ability.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };

  @override
  List<Object?> get props => [ability, slot, isHidden];
}

class Ability extends Equatable {
  const Ability({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };

  @override
  List<Object?> get props => [name, url];
}

class TypeElement extends Equatable {
  const TypeElement({
    required this.slot,
    required this.type,
  });

  final int slot;
  final Type type;

  factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
        slot: json["slot"],
        type: Type.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {"slot": slot, "type": type.toJson()};

  @override
  List<Object?> get props => [slot, type];
}

class Type extends Equatable {
  const Type({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };

  @override
  List<Object?> get props => [name, url];
}
