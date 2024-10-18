import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonAll extends HookConsumerWidget{
  const ButtonAll({
    super.key,
    required this.isActiveAll,
    required this.isActiveNearby,
    required this.onPressed,
  });

  final ValueNotifier<bool> isActiveAll;
  final ValueNotifier<bool> isActiveNearby;
  final VoidCallback onPressed; 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return SizedBox(
      height: 24,
      width: 44,
      child: TextButton(
        
        onPressed: () {
     
        isActiveAll.value = true;
        isActiveNearby.value = false;
         
        },
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            shape:
                WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: isActiveAll.value ? Colors.black : Colors.black26,)))),
        child: Center(
          child: Text('Все',
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400), ),
        ),
      ),
    );
  }
}