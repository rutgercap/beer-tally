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

  String _getText(ECurrentMode mode) {
    switch (mode) {
      case ECurrentMode.refillMode:
        return "Total refilled: ";
      case ECurrentMode.updateMode:
        return "Total grabbed: ";
      default:
        return "Ruysdaelkade";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beerRows = ref.watch(beerRowProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(_getText(ref.watch(currentModeProvider))),
        // actions: [
        //   IconButton(
        //       onPressed: () => print("settings"), icon: Icon(Icons.settings)),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TODO: make nothing here yet message better
              if (beerRows.isEmpty)
                const Center(
                  child: Text("Nothing here yet!"),
                ),
              for (int i = 0; i < beerRows.length; i++)
                SizedBox(
                    height: 100,
                    child: TallyRow(
                      id: i,
                      beers: beerRows[i].beers,
                      emptySince: beerRows[i].emptySince,
                    )),
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
