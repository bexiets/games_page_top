import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:game_list_page/models/games.dart';

import 'package:game_list_page/widgets/slider/custom_slider.dart';
import 'package:intl/intl.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.game,
  });

  final Games game;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: game.results.map((result) {
        // final String gameStartDate = result.startDate
        DateTime parsedDate = DateTime.parse(result.startDate!);
        String formattedDate = DateFormat('dd.MM.yy · HH:mm').format(parsedDate);
        return Column(
          children: [
            Container(
              height: 210,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/card_background/back_2.jpeg"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
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
                        width: 190,
                        height: 46,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: [
                                   Text(
                                  '$formattedDate',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                 Text(
                                  'Cash Game · ${result.contribution} сом',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                ],
                               
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(153, 11, 0, 0),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share_outlined,
                                color: Colors.white,
                              ))),
                    ],
                  ),
                  SizedBox(height: 25),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 24),
                    child: Text(
                      '${result.existingPlayerCount}23 км',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/card_background/avatar_image.jpeg"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 83,
                                    height: 33,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            result.organizer.username!,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow
                                                .ellipsis, // Show ellipsis if overflowed
                                            maxLines: 1,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Организатор',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                            overflow: TextOverflow
                                                .ellipsis, // Show ellipsis if overflowed
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                              child: GestureDetector(
                                onTap: (){
                                  print('Button pressed');
                                },
                                child: Container(
                                  width: 135,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  child: Center(
                                    child: Text(
                                      'Присоединиться',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.fromLTRB(3, 0, 3, 2),
                    height: 46,
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 0, 0, 10),
                          child: CustomSlider(
                            min: 0,
                            max: (result.maxPlayer ?? 0).toDouble(),
                            initialValue:
                                (result.existingPlayerCount ?? 0).toDouble(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 26.0),
                          child: Container(
                            width: 26,
                            height: 48,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/card_background/1.png',
                                  width: 24,
                                  height: 24,
                                ),
                                Text(
                                  '${result.maxPlayer}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

