import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game_list_page/providers/games_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GamesListPage extends HookConsumerWidget {
  const GamesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesProviderState = ref.watch(gamesProviderProvider);

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
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0),
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];

               
                return Column(
                  children: game.results.map((result) {
                    return Container(
                      height: 210, 
                    
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0), 
                      decoration: BoxDecoration(
                        // color:
                        //     Colors.white, 
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/card_background/back_card.jpeg"),
                          fit: BoxFit.cover,
                        ), 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), 
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), 
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                           

                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: 177,
                                height: 46, 
                                child: ClipRect(
                               
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 8.0,
                                        sigmaY: 8.0), 
                                    child: Container(
                                      color: Colors.grey.withOpacity(
                                          0.3), 
                                      child: Center(
                                        child: Text(
                                          'Top Left Container',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(153, 11, 0, 0),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.share_outlined,
                                        color: Colors.white,
                                      ))),
                            ],
                          ),
                          SizedBox(height: 11),

                          Container(
                            margin: EdgeInsets.only(left: 284),
                            child: Text(
                              '${result.existingPlayerCount} 231 км',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50, 
                            color: Colors
                                .blue, 
                            child: Center(
                              child: Text(
                                'Bottom Upper Container',
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(3, 0, 3, 5),

                            height: 50, 
                            color: Colors
                                .blue, 
                            child: Center(
                              child: Text(
                                'Bottom Container',
                                style: TextStyle(
                                    color: Colors.white), 
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
