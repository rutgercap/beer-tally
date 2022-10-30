import 'package:beer_tally/models/beer_row_model.dart';
import 'package:beer_tally/widgets/tally_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ECurrentMode {
  overviewMode,
  refillMode,
  updateMode,
}

final currentModeProvider = StateProvider<ECurrentMode>(
  (ref) => ECurrentMode.overviewMode,
);

class BeerTallyScreen extends ConsumerWidget {
  const BeerTallyScreen({super.key});

  // For testing purposes
  List<BeerRowListNotifier> _generateRows() {
    List<BeerRowListNotifier> current = [];
    current.add(BeerRowListNotifier(0, 10));
    current.add(BeerRowListNotifier(1, 0, emptySince: DateTime.now()));
    current.add(BeerRowListNotifier(2, 20));
    current.add(BeerRowListNotifier(3, 60));
    current.add(BeerRowListNotifier(4, 100));
    return current;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beerRowList = BeerRowList(_generateRows());

    String getText(ECurrentMode mode) {
      switch (mode) {
        case ECurrentMode.refillMode:
          return "Total refilled: ";
        case ECurrentMode.updateMode:
          return "Total grabbed: ";
        default:
          return "Ruysdaelkade";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(getText(ref.watch(currentModeProvider))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TODO: make nothing here yet message better
              if (beerRowList.beerRows.isEmpty)
                const Center(
                  child: Text("Nothing here yet!"),
                ),
              for (int i = 0; i < beerRowList.beerRows.length; i++)
                SizedBox(
                    height: 100,
                    child: TallyRow(rowNotifier: beerRowList.beerRows[i])),
              // Sizedbox so last row is never hidden behind FAB
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
      // TODO: Animate nicely
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        if (ref.watch(currentModeProvider) == ECurrentMode.overviewMode)
          FloatingActionButton.extended(
            isExtended: true,
            onPressed: () => ref.read(currentModeProvider.notifier).state =
                ECurrentMode.refillMode,
            label: const Text("Refill"),
          ),
        if (ref.watch(currentModeProvider) != ECurrentMode.overviewMode)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton.extended(
              isExtended: true,
              onPressed: () => ref.read(currentModeProvider.notifier).state =
                  ECurrentMode.refillMode,
              label: const Text("Confirm"),
            ),
          ),
        if (ref.watch(currentModeProvider) != ECurrentMode.overviewMode)
          FloatingActionButton.extended(
            isExtended: true,
            onPressed: () => ref.read(currentModeProvider.notifier).state =
                ECurrentMode.overviewMode,
            label: const Text("Cancel"),
          ),
      ]),
    );
  }
}
