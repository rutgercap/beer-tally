import 'package:beer_tally/models/beer_row_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OutOfBeers extends StatelessWidget {
  const OutOfBeers({super.key, required this.emptySince});
  final DateTime emptySince;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FiveBeerIconSet extends StatelessWidget {
  const FiveBeerIconSet({super.key, required this.total})
      : assert(total <= 5 && total >= 0);
  final String beerAssetName = 'assets/beer_bottle.svg';
  final num total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < total; i++)
          SvgPicture.asset(beerAssetName,
              height: 50, semanticsLabel: 'Acme Logo'),
        if (total == 5)
          const SizedBox(
            width: 20,
          )
      ],
    );
  }
}

class TallyRow extends StatelessWidget {
  TallyRow({super.key, required this.rowNotifier});

  final BeerRowListNotifier rowNotifier;

  // TODO: must be a better way to do this
  num beersPerRow(num i) {
    num beersLeft = rowNotifier.beers - (i * 5);
    if (beersLeft >= 5) {
      return 5;
    }
    return beersLeft;
  }

  // TODO: make dynamic based on screen size
  final num _maxRows = 8;
  num calcRows() {
    num rows = (rowNotifier.beers / 5).ceil();
    if (rows > _maxRows) {
      return _maxRows;
    }
    return rows;
  }

  num calcExtraBeers() {
    num maxBeers = (_maxRows - 1) * 5;
    return rowNotifier.beers - maxBeers;
  }

  @override
  Widget build(BuildContext context) {
    // If person has over the max amount of beers
    num extraBeers = calcExtraBeers();

    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 80,
              child: Text('KV'),
            ),
          ),
        ),
        Expanded(
          flex: 11,
          child: Row(
            children: [
              for (int i = 0; i < calcRows(); i++)
                // Always display first maxrows - 1
                if (i != _maxRows - 1)
                  FiveBeerIconSet(total: beersPerRow(i))
                // If more than max displayable, print how much
                else if (extraBeers > 5)
                  Text(" + ${extraBeers} more")
                // else just show last beers
                else
                  FiveBeerIconSet(total: beersPerRow(i))
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                  onPressed: ((() => print("clicked"))),
                  child: const Text("Grab")),
            ),
            Text("Total: ${rowNotifier.beers}"),
          ]),
        )
      ],
    );
  }
}
