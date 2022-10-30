import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Immutable description of the state of a beerrow
@immutable
class IBeerRow {
  const IBeerRow({required this.id, required this.beers, this.emptySince})
      :
        // if beers <= emptysince must be set and vice versa
        assert((beers <= 0 && emptySince != null) ||
            (beers > 0 && emptySince == null));
  final num id;
  final num beers;
  final DateTime? emptySince;

  // Class is immutable, replacing is still possible though
  IBeerRow copyWith({num? beers, DateTime? emptySince}) {
    return IBeerRow(
        id: id,
        beers: beers ?? this.beers,
        emptySince: emptySince ?? this.emptySince);
  }
}

class BeerRowListNotifier extends StateNotifier<IBeerRow> {
  BeerRowListNotifier(num id, num beers, {DateTime? emptySince})
      : super(IBeerRow(id: id, beers: beers, emptySince: emptySince));

  num get beers => state.beers;
  num get id => state.id;
  DateTime? get emptySince => state.emptySince;

  // Can be used to increase or decrease amount of beers
  updateAmount(num change) {
    DateTime? emptySince;
    num newAmount = state.beers - change;
    if (newAmount <= 0) {
      emptySince = DateTime.now();
    } else {
      emptySince = null;
    }
    state = IBeerRow(id: state.id, beers: newAmount, emptySince: emptySince);
  }
}

class BeerRowList extends StateNotifier<List<BeerRowListNotifier>> {
  BeerRowList([List<BeerRowListNotifier>? initialRows])
      : super(initialRows ?? []);

  List<BeerRowListNotifier> get beerRows => state;
}
