import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:game_list_page/providers/games_provider.dart';
import 'package:game_list_page/widgets/button_all.dart';
import 'package:game_list_page/widgets/button_nearby.dart';
import 'package:game_list_page/widgets/game_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GamesListPage extends HookConsumerWidget {
  const GamesListPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesProviderState = ref.watch(gamesProviderProvider);
    final isActiveAll = useState(true);
     final isActiveNearby = useState(false);
     final activeButtonProvider = StateProvider<int>((ref) => 0);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(154.0),
        child: AppBar(
          title: const Text('Games'),
        ),
      ),
      body: gamesProviderState.when(
        data: (games) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ButtonAll(isActiveAll: isActiveAll, isActiveNearby: isActiveNearby),
                    SizedBox(width: 10,),
                    ButtonNearby(isActiveNearby: isActiveNearby, isActiveAll: isActiveAll),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];

                      return GameCard(game: game);
                    },
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}






