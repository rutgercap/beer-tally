import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Immutable description of the state of a beerrow
@immutable
class IBeerRow {
  const IBeerRow({required this.id, required this.beers, this.emptySince})
      :

        /// if beers <= emptysince must be set and vice versa
        assert((beers <= 0 && emptySince != null) ||
            (beers > 0 && emptySince == null));
  final num id;
  final num beers;
  final DateTime? emptySince;

  /// Class is immutable, replacing is still possible though
  IBeerRow copyWith({num? beers, DateTime? emptySince}) {
    /// If new amount of beers is less than 0 and no emptySince is specified
    /// Set emptysince to now
    if (beers != null && emptySince == null && beers <= 0) {
      emptySince = DateTime.now();
    }
    return IBeerRow(
        id: id,
        beers: beers ?? this.beers,
        emptySince: emptySince ?? this.emptySince);
  }
}

class BeerRowList extends StateNotifier<List<IBeerRow>> {
  BeerRowList([List<IBeerRow>? initialRows]) : super(initialRows ?? []);

  List<IBeerRow> get rows => state;

  /// id: id of beerRow
  ///
  /// increase: amount that will be increased for row
  void increaseAmount(num id, num increase) {
    state = [
      for (final row in state)
        if (row.id == id) row.copyWith(beers: row.beers + increase) else row,
    ];
  }

  /// id: id of beerRow
  ///
  /// decrease: amount that will be decreased for row
  void decreaseAmount(num id, num decrease) {
    state = [
      for (var row in state)
        if (row.id == id) row.copyWith(beers: row.beers - decrease) else row,
    ];
  }
}

// Default values for development
final beerRowProvider =
    StateNotifierProvider<BeerRowList, List<IBeerRow>>((ref) {
  return BeerRowList([
    const IBeerRow(id: 0, beers: 10),
    const IBeerRow(id: 1, beers: 100),
    IBeerRow(id: 2, beers: 0, emptySince: DateTime.now()),
    const IBeerRow(id: 3, beers: 20),
    const IBeerRow(id: 4, beers: 60),
    const IBeerRow(id: 5, beers: 80),
  ]);
});
