import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


import 'package:game_list_page/providers/games_provider.dart';
import 'package:game_list_page/widgets/button_all.dart';
import 'package:game_list_page/widgets/button_nearby.dart';
import 'package:game_list_page/widgets/game_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GamesListPage extends HookConsumerWidget {
  const GamesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesProvider = ref.watch(gamesProviderProvider);
    final gamesProviderNotifier = ref.read(gamesProviderProvider.notifier);

    final isActiveAll = useState(true);
    final isActiveNearby = useState(false);

    final scrollController = useScrollController();

    const pageSize = 20;

    Future<void> fetchNearbyGames(WidgetRef ref) async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      await ref.read(gamesProviderProvider.notifier).fetchGames(
          latitude: position.latitude,
          longitude: position.longitude,
          isNear: true);
      print('latitude: ${position.latitude}, longitude ${position.longitude}');
    }

    Future<void> fetchAllGames() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      await ref.read(gamesProviderProvider.notifier).fetchGames(
          latitude: position.latitude,
          longitude: position.longitude,
          isNear: false);
    }

    useEffect(() {
      fetchAllGames();

      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          gamesProviderNotifier.loadMoreGames();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(154.0),
        child: AppBar(
          title: const Text('Games'),
        ),
      ),
      body: gamesProvider.when(
        data: (games) {
          final isShowingNearby = isActiveNearby.value;
          final allGames = games.expand((game) => game.results).toList();
          final nearbyGames = isShowingNearby
              ? allGames.where((result) =>
                  result.distanceFromUser != null &&
                  result.distanceFromUser! <= 20).toList()
              : allGames;
          final startIndex = isShowingNearby ? (gamesProviderNotifier.currentPageNearby - 1) * pageSize : (gamesProviderNotifier.currentPageAll - 1) * pageSize;
          final endIndex = startIndex + pageSize;
          final displayedGames = nearbyGames.sublist(startIndex, endIndex.clamp(0, nearbyGames.length));
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ButtonAll(
                        isActiveAll: isActiveAll,
                        isActiveNearby: isActiveNearby,
                        onPressed: () {
                          fetchAllGames();
                          isActiveAll.value = true;
                          isActiveNearby.value = false;
                        }),
                    const SizedBox(width: 10),
                    ButtonNearby(
                      isActiveNearby: isActiveNearby,
                      isActiveAll: isActiveAll,
                      onPressed: () {
                        fetchNearbyGames(ref);
                        isActiveNearby.value = true;
                        isActiveAll.value = false;
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: nearbyGames.isEmpty
                      ? const Center(child: Text('Не найдено игр рядом'))
                      : ListView.builder(
                          itemCount: displayedGames.length,
                          itemBuilder: (context, index) {
                            final result = displayedGames[index];
                            return GameCard(
                                gameResult:
                                    result); 
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
